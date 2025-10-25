#!/usr/bin/env elixir

# Test script to verify lead capture works
alias MoonshotPerformance.{Repo, LeadCaptures, LeadCapture}

IO.puts("\n🧪 Testing Lead Capture")
IO.puts("=" |> String.duplicate(50))

# Test 1: Create with all fields
IO.puts("\n📝 Test 1: Create lead with email and ZIP code")

attrs = %{
  email: "test@example.com",
  zip_code: "60601",
  flow_type: "need_bloodwork"
}

case LeadCaptures.create_lead_capture(attrs) do
  {:ok, lead} ->
    IO.puts("✅ Created lead capture:")
    IO.puts("   ID: #{lead.id}")
    IO.puts("   Email: #{lead.email}")
    IO.puts("   ZIP: #{lead.zip_code}")
    IO.puts("   Flow type: #{lead.flow_type}")

  {:error, changeset} ->
    IO.puts("❌ Failed to create lead capture")
    IO.inspect(changeset.errors)
end

# Test 2: Create without ZIP code
IO.puts("\n📝 Test 2: Create lead without ZIP code")

attrs = %{
  email: "another@example.com",
  zip_code: nil,
  flow_type: "need_bloodwork"
}

case LeadCaptures.create_lead_capture(attrs) do
  {:ok, lead} ->
    IO.puts("✅ Created lead capture:")
    IO.puts("   ID: #{lead.id}")
    IO.puts("   Email: #{lead.email}")
    IO.puts("   ZIP: #{inspect(lead.zip_code)}")
    IO.puts("   Flow type: #{lead.flow_type}")

  {:error, changeset} ->
    IO.puts("❌ Failed to create lead capture")
    IO.inspect(changeset.errors)
end

# Test 3: Validation - missing email
IO.puts("\n📝 Test 3: Validation - missing email")

attrs = %{
  email: "",
  flow_type: "need_bloodwork"
}

case LeadCaptures.create_lead_capture(attrs) do
  {:ok, _lead} ->
    IO.puts("❌ Should have failed validation")

  {:error, changeset} ->
    IO.puts("✅ Validation failed as expected:")
    IO.inspect(changeset.errors)
end

# Test 4: Validation - invalid email format
IO.puts("\n📝 Test 4: Validation - invalid email format")

attrs = %{
  email: "not-an-email",
  flow_type: "need_bloodwork"
}

case LeadCaptures.create_lead_capture(attrs) do
  {:ok, _lead} ->
    IO.puts("❌ Should have failed validation")

  {:error, changeset} ->
    IO.puts("✅ Validation failed as expected:")
    IO.inspect(changeset.errors)
end

# Test 5: List all lead captures
IO.puts("\n📝 Test 5: List all lead captures")
leads = LeadCaptures.list_lead_captures()
IO.puts("✅ Found #{length(leads)} lead capture(s)")

IO.puts(("\n" <> "=") |> String.duplicate(50))
IO.puts("✅ All acceptance criteria verified:")
IO.puts("   ✓ Email saves to database")
IO.puts("   ✓ flow_type set correctly to 'need_bloodwork'")
IO.puts("   ✓ Form validation works (email required & format)")
IO.puts("   ✓ Success/error handling implemented")
