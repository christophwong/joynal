require 'spec_helper'

describe LocationRecord do
  it {should belong_to :journal_entry}
end
