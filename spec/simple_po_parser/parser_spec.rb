require "spec_helper"

describe SimplePoParser::Parser do
  let (:po_header) { File.read(File.expand_path("fixtures/header.po", __dir__))}
  let(:po_complex_message) { File.read(File.expand_path("fixtures/complex_entry.po", __dir__))}
  let(:po_simple_message) { File.read(File.expand_path("fixtures/simple_entry.po", __dir__))}

  it "parses the PO header" do
    expected_result = {
      :translator_comment => ["PO Header entry", ""],
      :flag => ["fuzzy"],
      :msgid => [""],
      :msgstr => ["", "Project-Id-Version: simple_po_parser 1\\n", "Report-Msgid-Bugs-To: me\\n"]
    }
    expect(SimplePoParser::Parser.parse(po_header)).to eq(expected_result)
  end

  it "parses the simple entry as expected" do
    expected_result = {
      :translator_comment => ["translator-comment"],
      :extracted_comment => ["extract"],
      :reference => ["reference1"],
      :msgctxt => ["Context"],
      :msgid => ["msgid"],
      :msgstr => ["translated"]
    }
    expect(SimplePoParser::Parser.parse(po_simple_message)).to eq(expected_result)
  end

  it "parses the complex entry as expected" do
    expected_result = {
      :translator_comment => ["translator-comment", ""],
      :extracted_comment => ["extract"],
      :reference => ["reference1", "reference2"],
      :flag => ["flag"],
      :previous_msgctxt => ["previous context"],
      :previous_msgid => ["", "multiline\\n", "previous messageid"],
      :previous_msgid_plural => ["previous msgid_plural"],
      :msgctxt => ["Context"],
      :msgid => ["msgid"],
      :msgid_plural => ["", "multiline msgid_plural\\n", ""],
      "msgstr[0]" => ["msgstr 0"],
      "msgstr[1]" => ["", "msgstr 1 multiline 1\\n", "msgstr 1 line 2\\n"],
      "msgstr[2]" => ["msgstr 2"]
    }
    expect(SimplePoParser::Parser.parse(po_complex_message)).to eq(expected_result)
  end

end
