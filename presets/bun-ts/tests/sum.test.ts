import { expect, test } from "bun:test";
import { sum } from "../src/sum.ts";

test("sums an empty collection and signed values", () => {
  expect(sum([])).toBe(0);
  expect(sum([2, -5, 4])).toBe(1);
});
