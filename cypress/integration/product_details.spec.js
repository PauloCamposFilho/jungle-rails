describe("Product Details", () => {
  beforeEach(() => {
    cy.viewport(1600, 900);
    cy.visit("/");
  });
  it("properly enters a product page", () => {
    cy.get(".products article")
      .first()
      .find("a")
      .click();
    cy.get("article.product-detail").should("exist");
  });
});