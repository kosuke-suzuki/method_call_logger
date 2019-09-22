RSpec.describe MethodCallLogger do
  it "has a version number" do
    expect(MethodCallLogger::VERSION).not_to be nil
  end

  context(:method_call_logging) do
    before(:all) do
      class SampleClass
        method_call_logging

        def initialize(logger)
          @logger = logger
        end

        def sample_method1
        end

        def sample_method2(arg1, arg2, arg3)
        end
      end
    end

    it "logs a called method in a class" do
      logger = double("logger")
      expect(logger).to receive(:debug).with("SampleClass#sample_method1")
      SampleClass.new(logger).sample_method1
    end

    it "also logs arguments" do
      logger = double("logger")
      expect(logger).to receive(:debug).with('SampleClass#sample_method2(arg1:"a", arg2::b, arg3:[{:c=>1}])')
      SampleClass.new(logger).sample_method2("a", :b, [{c: 1}])
    end
  end

  context('method_call_logging with loglevel change') do
    before(:all) do
      class SampleClass2
        method_call_logging sample_method1: Logger::INFO, sample_method2: Logger::WARN

        def initialize(logger)
          @logger = logger
        end

        def sample_method1
        end

        def sample_method2(arg1, arg2, arg3)
        end
      end
    end

    it "logs with the specified loglevel" do
      logger = double("logger")
      expect(logger).to receive(:log).with(Logger::INFO, "SampleClass2#sample_method1")
      SampleClass2.new(logger).sample_method1
    end

    it "logs method call and arguments with the specified loglevel" do
      logger = double("logger")
      expect(logger).to receive(:log).with(Logger::WARN, 'SampleClass2#sample_method2(arg1:"a", arg2::b, arg3:[{:c=>1}])')
      SampleClass2.new(logger).sample_method2("a", :b, [{c: 1}])
    end
  end
end
