defmodule MoonshotPerformance.UploadsTest do
  use MoonshotPerformance.DataCase

  alias MoonshotPerformance.Uploads
  alias MoonshotPerformance.Upload

  describe "create_upload/1" do
    test "creates upload with valid attributes" do
      attrs = %{
        email: "test@example.com",
        file_path: "/uploads/test.pdf"
      }

      assert {:ok, %Upload{} = upload} = Uploads.create_upload(attrs)
      assert upload.email == "test@example.com"
      assert upload.file_path == "/uploads/test.pdf"
      assert upload.status == "pending"
    end

    test "requires email and file_path" do
      attrs = %{}

      assert {:error, changeset} = Uploads.create_upload(attrs)
      assert %{email: ["can't be blank"], file_path: ["can't be blank"]} = errors_on(changeset)
    end

    test "validates email format" do
      attrs = %{
        email: "invalid-email",
        file_path: "/uploads/test.pdf"
      }

      assert {:error, changeset} = Uploads.create_upload(attrs)
      assert %{email: ["must be a valid email"]} = errors_on(changeset)
    end

    test "defaults status to pending" do
      attrs = %{
        email: "test@example.com",
        file_path: "/uploads/test.pdf"
      }

      assert {:ok, upload} = Uploads.create_upload(attrs)
      assert upload.status == "pending"
    end
  end
end
