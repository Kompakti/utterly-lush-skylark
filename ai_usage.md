# AI Usage

AI (commercial LLMs) was used without specific skills or MCPs. Exact tokens not available, but usage was under 10 %.

AI was used to extract locators from the page html. For the first resource, the agent did more than asked and created
the keywords at the same time. After this, it was instructed to show a plan of the keywords before implementing those.
The idea was to include only keywords that are needed for the initial set of tests (but all of those did not end up
being used yet.)

Next, AI was used to construct the user and product data. It was specifically asked to store the data in python
variable files. It had all the necessary information from the previous tasks.

AI wrote the initial login tests based on test names. It was then used to re-write those from testing one specific user
to cover all cases.

The shopping flow test case was initially written manually. Then AI was used to review it and first set of fixes was
done manually. Later, AI was used for smaller fixes that were needed based on the test runs.

For future, I would add separate skills (extract locator, review test case etc.) to make prompting easier, automate the review, and to share common way of working.
