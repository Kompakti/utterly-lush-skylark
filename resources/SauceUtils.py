class SauceUtils:
    """Project-internal utility library for the utterly-lush-skylark test suite."""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def calculate_subtotal_price(self, item_prices: list[str]) -> float:
        subtotal = 0.0
        for price in item_prices:
            subtotal = subtotal + float(price.strip("$"))
        return subtotal

    def should_be_less_than(self, smaller: float, greater: float) -> None:
        if smaller >= greater:
            raise AssertionError(f"{smaller} is not less than {greater}")
