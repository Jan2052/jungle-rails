describe('Product detail', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length.greaterThan", 1);
  });

  it("should navigate to the product detail page", () => {
    cy.get(".products article").first().click();
    cy.get(".product-detail").should("be.visible");

  });
});