require 'rspec'
require 'indentinator'
include Indentinator

describe 'indent_amount' do
  it "sniffs indent amount 2" do
    text = "
line 1
  line 2"
    indent_amount(text.split("\n")).should == " " * 2
    text = "
line 1
    line 2"
    indent_amount(text.split("\n")).should == " " * 4
  end
  
  it "should pick most frequent indentation" do
    text = "
line 1
    line 2
        line 3
          line 4"
    indent_amount(text.split("\n")).should == " " * 4
  end
  
  it "should support tabs" do
    lines = [
      "line 1",
      "\tline 2",
      "\t\tline 3"
      ]
    indent_amount(lines).should == "\t"
  end
  
  it "should support tabs - adheres to frequency principle" do
    lines = [
      "line 1",
      "\tline 2",
      "\t\tline 3",
      "        line 4"
      ]
    indent_amount(lines).should == "\t"
  end
  
  it "should support tabs - adheres to frequency principle(2)" do
    lines = [
      "line 1",
      "\tline 2",
      "\t\tline 3",
      "line 4",
      "    line 5",
      "        line 6",
      "            line 7"
      ]
    indent_amount(lines).should == "    "
  end
end

describe 'convert_file' do
  it "converts basic indentation" do
    text = "
line 1
  line 2
    line 3
line 4"
    convert_indentation(text, ' ' * 2, ' ' * 4).should == "
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
    convert_indentation(text, ' ' * 2, ' ' * 4).should == text
  end
  
  it "retains non-standard indentation even when is 
      multiple of org indentation amount" do
    text = "
line 1
  line 2
    line 3
        line 2"
    convert_indentation(text, ' ' * 2, ' ' * 4).should == "
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
    convert_indentation(text, ' ' * 4, ' ' * 2).should == "
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
    convert_indentation(text, ' ' * 4, ' ' * 2).should == "
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
    convert_indentation(text, ' ' * 2, ' ' * 4).should == "
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
    convert_indentation(text, ' ' * 4, ' ' * 2).should == "
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
    convert_indentation(text, ' ' * 4, ' ' * 2).should == "
line 1
  line 2
    line 3

    line 4"
  end

  it "should de-indent property(ex 3)" do
    text = "
line 2
    line 3
      line 4
    line 5"
    convert_indentation(text, ' ' * 2, ' ' * 4).should == "
line 2
    line 3
        line 4
    line 5"
  end

  it "should de-indent property(ex 4)" do
    text = "
line 2
      line 3
          line 4
      line 5"
    convert_indentation(text, ' ' * 2, ' ' * 4).should == text
  end
  
  it "should de-indent property(ex 5)" do
    text = "
line 1
    line 2
          line 3
              line 4
          line 5
    line 6"
    convert_indentation(text, ' ' * 2, ' ' * 4).should == text
  end
  
  it "should support tabs" do
    lines = [
      "line 1",
      "\tline 2",
      "\tline 3",
      "\t\tline 4"
    ]
    convert_lines(lines, "\t", " " * 4).should == [
      "line 1",
      "    line 2",
      "    line 3",
      "        line 4"
    ]
  end
  
  it "should support tabs (ex 2)" do
    text = "
line 1
  line 2
    line 3
line 4"
    convert_indentation(text, ' ' * 2, "\t").should == "
line 1
\tline 2
\t\tline 3
line 4"
  end
  
  it "tabs should be converted always" do
    lines = [
      "line 1",
      "  line 2",
      "\tline 3"
    ]
    convert_lines(lines, ' ' * 2, ' ' * 4).should == [
      "line 1",
      "    line 2",
      "    line 3"
    ]
  end
end