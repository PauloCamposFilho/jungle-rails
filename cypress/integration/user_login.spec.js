describe("User login tests", () => {
  beforeEach(() => {
    cy.visit("/login");
  });

  it("successfully logs the user in", () => {
    cy.get("input[name='email']")
      .type("b@b.com");
    cy.get("input[name='password'")
      .type("1234");
    cy.get("input[type='submit']")
      .click();
    // check navbar contains user name and logout button.
    cy.get(".navbar-nav")
      .find(".nav-item.login")
      .contains(/testing user/i)
    cy.get(".navbar-nav")
      .find(".nav-item.login a[href='/logout']");
  });

  it("successfully logs out the user", () => {
    cy.get("input[name='email']")
      .type("b@b.com");
    cy.get("input[name='password'")
      .type("1234");
    cy.get("input[type='submit']")
      .click();
    // check navbar contains user name and logout button.
    cy.get(".navbar-nav")
      .find(".nav-item.login")
      .contains(/testing user/i)
    cy.get(".navbar-nav")
      .find(".nav-item.login a[href='/logout']")
      .click({force:true});
    // check navbar contains login button
    cy.wait(1000); // wait for logout
    cy.get(".navbar-nav")
      .find(".nav-item.login a")
      .contains(/login/i);
  });
});