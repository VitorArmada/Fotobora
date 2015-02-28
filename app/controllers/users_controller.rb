class UsersController < ApplicationController
  before_action :set_user, only: [:show, :import, :import_post]

  # GET /users/1
  # GET /users/1.json
  def show      

  end

  def import

  end

  def import_post

    file = params[:file]

    # Check if a file was uploaded

      if file.nil?
        flash[:errors] =
          [ "No file submitted. Submit a file." ]
        redirect_to import_user_url(@user)
        return
      end

    # Parse

      begin
        gentree = JSON.parse(file.read)
      rescue Exception => e
        error = e.to_s.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
        flash[:errors] =
          [ "#{error}" ]
        redirect_to import_user_url(@user)
        return
      end

    # Verify structure

      e = []
      keys = []
      keys_all = []

      # Test main structure

        if gentree.has_key?('arvgen') == false
          e << "Key 'arvgen' not found in the file."
        elsif gentree['arvgen'].nil?
          e << "No values found in the file for key 'arvgen'."

      # Test for missing values

        else
          index = 0
          gentree['arvgen'].each do |x|
            index = index + 1
            e << "Element \##{index} doesn't have a 'nome' key" unless x.has_key?('nome')
            e << "Element \##{index} doesn't have a 'id' key" unless x.has_key?('id')
            e << "Element \##{index} doesn't have a 'id_pai' key" unless x.has_key?('idpai')
            e << "Element \##{index} doesn't have a 'id_mae' key" unless x.has_key?('idmae')
            e << "Element \##{index} doesn't have a 'nome' value" if x['nome'].nil?
            e << "Element \##{index} doesn't have a 'id' value" if x['id'].nil?
            keys_all << x['id']
          end   
        end

        if e.empty? == false
          flash[:errors] = e
          redirect_to import_user_url(@user)
          return
        end

      # Test for invalid values

        index = 0
        gentree['arvgen'].each do |x|
          index = index + 1
          if keys.include?( x['id'] )
            e << "Element \##{index} has a duplicate 'id' value (#{x['id']})"
          else
            keys << x['id']
          end
          if x['idpai'].nil? == false &&
            keys_all.include?( x['idpai'] ) == false
            e << "Element \##{index} has an unmatched 'idpai' value (#{x['idpai']})"
          end
          if x['idmae'].nil? == false &&
            keys_all.include?( x['idmae'] ) == false
            e << "Element \##{index} has an unmatched 'idmae' value (#{x['idmae']})"
          end
        end

        if e.empty? == false
          flash[:errors] = e
          redirect_to import_user_url(@user)
          return
        end

    # Delete previous Family Tree records before importing

      current_user.people.each { |x| x.destroy }

    # Import Family Tree

      people_assoc = { }

      gentree['arvgen'].each do |x|
        person = @user.people.build
        person.name = x['nome']
        people_assoc[ x['id'] ] = person
        person.save # sets id attribute
      end

      gentree['arvgen'].each do |x|
        person = people_assoc[ x['id'] ]
        person.father_id = people_assoc[ x['idpai'] ].id unless x['idpai'].nil? 
        person.mother_id = people_assoc[ x['idmae'] ].id unless x['idmae'].nil? 
        person.save
      end

      @x = people_assoc

    # Generate Family Tree image

      require 'graphviz'

      # Create a new graph
      g = GraphViz.new( :G, :type => :digraph )

      # Create nodes

      nodes = { }

      current_user.people.each do |p|
        nodes[ p.id ] = g.add_nodes( p.name )
      end

      # Create edges
      current_user.people.each do |p|
        g.add_edges( nodes[ p.father_id ], nodes[ p.id ] ) unless p.father_id.nil?
        g.add_edges( nodes[ p.mother_id ], nodes[ p.id ] ) unless p.mother_id.nil?
      end

      # Generate output image
      temp_filename = (0...8).map { (65 + rand(26)).chr }.join + '.png'

      g.output( :png => temp_filename )

      # Store image in the database
      temp_file = File.open( temp_filename )

      @user.gentree = temp_file
      @user.save!

      # Remove temporary file
      temp_file.close
      File.delete(temp_filename)

    # Redirect to User page

      redirect_to @user, notice: 'Family Tree successfully imported.'

  end

  private

    def set_user
      # If not specified, display the current logon user profile
      user_id = params[:id].nil? ? current_user.id : params[:id]
      @user = User.find(user_id)
    end
end
