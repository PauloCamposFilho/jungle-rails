describe("Adding to cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("can add a product to cart from the home-page", () => {
    cy.get(".products article")
      .first()
      .find("button.btn")
      .click({force: true});
    
      cy.get("a.nav-link[href='/cart']")
      .contains("1");
  });
  it("can add a product to cart from the products-page", () => {
    cy.get(".products article")
      .first()
      .find("a")
      .click({force: true});
    
      cy.get(".product-detail")
      .find("button")
      .click({force:true});
    
      cy.get("a.nav-link[href='/cart']")
      .contains("1");
  });
});