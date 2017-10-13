class DefectsController < ApplicationController
    
    def new 
        @defect = Defect.new
    end
    
    def create 
        @defect = Defect.new(params.require(:defect).permit(:defect_no,
        :rtc, :qc, :config, :data_mapping_def, :pc_changes_def,
        :plugin_changes, :ia_changes, :db_changes_def, :external_changes_def, :plug_changes_type,
        :workarounds))
        @current_drop = Iteration.where('date_of_drop > ?', Date.today).order(:date_of_drop).first.id
        @defect.update_attribute(:iteration_id, @current_drop)
        respond_to do |format|
        if @defect.save
            format.html {redirect_to defects_path, notice: "Defect successfully added!"}
        else
            format.html {render :new }
        end
        end
    end
end
