class PrescricoesController < ApplicationController
  before_action :set_prescricao, only: %i[ show edit update destroy ]

  # GET /prescricoes or /prescricoes.json
  def index
    @prescricaos = Prescricao.all
  end

  # GET /prescricoes/1 or /prescricoes/1.json
  def show
    @paciente = Paciente.find(params[:paciente_id])
  end

  # GET /prescricoes/new
  def new
    @paciente = Paciente.find(params[:paciente_id])
    @prontuario = @paciente.prontuario
    @prescricao = @prontuario.prescricoes.build
  end

  # GET /prescricoes/1/edit
  def edit
  end

  # POST /prescricoes or /prescricoes.json
  def create
    @paciente = Paciente.find(params[:paciente_id])
    @prontuario = @paciente.prontuario
    @prescricao = @prontuario.prescricoes.build(prescricao_params)

    respond_to do |format|
      if @prescricao.save
        format.html { redirect_to paciente_prescrico_path(@paciente, @prescricao), notice: "Prescrição foi criada com sucesso." }
        format.json { render :show, status: :created, location: @prescricao }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prescricao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prescricoes/1 or /prescricoes/1.json
  def update
    respond_to do |format|
      if @prescricao.update(prescricao_params)
        format.html { redirect_to prescricao_url(@prescricao), notice: "Prescrição atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @prescricao }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prescricao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescricoes/1 or /prescricoes/1.json
  def destroy
    @prescricao.destroy

    respond_to do |format|
      format.html { redirect_to prescricaos_url, notice: "Prescricao was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_prescricao
      @prescricao = Prescricao.find(params[:id])
    end

    def prescricao_params
      params.require(:prescricao).permit(:consulta_id, :cod, :data, :dosagem, :observacoes, :listaMedicamentos)
    end
end
