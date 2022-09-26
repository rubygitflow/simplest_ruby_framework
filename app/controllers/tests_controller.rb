class TestsController < SimplestRubyFramework::Controller

  def index
    @time = Time.now
    # по условию допускаем замену шаблона для рендеринга
    rand(0..100) > 49 ? render('tests/list') : render('tests/index')
    # render('tests/index')
  end

  def create

  end

  def show
    @test = Test.find(id: params[:id])
    raise IndexError.new(:unprocessable_entity) if @test.nil?
  end

  def list
    @time = Time.now
  end
end
