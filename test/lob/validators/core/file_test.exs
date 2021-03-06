defmodule Lob.Validators.Core.FileTest do
  use ExUnit.Case, async: true
  alias Lob.Validators.Core.File
  import Lob.Validators.Core.Validate
  require Lob.Tests.Shared

  Lob.Tests.Shared.validator(File)

  test "File produces no errors for nil" do
    rule = %File{}
    assert validate(rule, nil, %{}, []) == []
  end

  test "File produces error if none of the url, path, content are set" do
    rule = %File{}
    assert validate(rule, %{}, %{}, []) |> length == 1
  end

  test "produces error if more then one of the url, path, content are set" do
    rule = %File{}
    value = %{path: "./it", content: "12345678901as"}
    assert validate(rule, value, %{}, []) |> length == 1
  end

  test "produces no errors if valid content is set" do
    rule = %File{}
    value = %{content: "12345678901as"}
    assert validate(rule, value, %{}, []) == []
  end

  test "produces error if valid path is set and name is not set" do
    rule = %File{}
    value = %{path: "./test/fixtures/letter.pdf"}
    assert validate(rule, value, %{}, []) == [":name is required if :path is set"]
  end

  test "produces error if valid path is set and name is not valid" do
    rule = %File{}
    value = %{path: "./test/fixtures/letter.pdf", name: ""}
    assert validate(rule, value, %{}, []) |> length == 1
  end

  test "produces no errors if valid path is set and name is valid" do
    rule = %File{}
    value = %{path: "./test/fixtures/letter.pdf", name: "letter"}
    assert validate(rule, value, %{}, []) == []
  end

end
