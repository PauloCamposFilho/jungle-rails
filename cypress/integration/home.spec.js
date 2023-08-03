describe("Homepage tests", () => {
  beforeEach(() => {
    cy.visit("/");
  });
  
  it("has products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("finds 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

});