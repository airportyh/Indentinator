require 'rspec'
require 'indentinator.rb'
describe 'convert_file' do
  it "converts basic indentation" do
    text = "
line 1
  line 2
    line 3
line 4"
    convert_indentation(text, 2, 4).should == "
line 1
    line 2
        line 3
line 4"
  end
    
  it "retains non-standard indentation when not multiple 
      of org indentation amount" do
    text = "
line 1
   line 2"
    convert_indentation(text, 2, 4).should == text
  end
  
  it "retains non-standard indentation even when is 
      multiple of org indentation amount" do
    text = "
line 1
  line 2
    line 3
        line 2"
    convert_indentation(text, 2, 4).should == "
line 1
    line 2
        line 3
            line 2"    
  end
  
  it "retains line-up of non-standard indented lines" do
    text = "
line 1
  line 2
  line 3
  line 4"
    convert_indentation(text, 4, 2).should == "
line 1
  line 2
  line 3
  line 4"
  end
  
  it "retains line-up of non-standard indented lines(ex 2)" do
    text = "
line 0
    line 1
      line 2
      line 3
      line 4"
    convert_indentation(text, 4, 2).should == "
line 0
  line 1
    line 2
    line 3
    line 4"
  end
  
  it "should de-indent properly from non-standard indent" do
    text = "
line 0
          line 2
  line 3
line 4"
    convert_indentation(text, 2, 4).should == "
line 0
          line 2
    line 3
line 4"
  end
  
  it "should ignore empty lines" do
    text = "
line 0
    line 1
      line 2
      line 3

      line 4"
    convert_indentation(text, 4, 2).should == "
line 0
  line 1
    line 2
    line 3

    line 4"
  end
  
  it "should de-indent property(ex 2)" do
    text = "
line 1
    line 2
        line 3

        line 4"
    convert_indentation(text, 4, 2).should == "
line 1
  line 2
    line 3

    line 4"
  end
end