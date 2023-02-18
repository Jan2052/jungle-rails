describe('Add to cart', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:3000')
  })

  it('should add a product to the cart and increase the count', () => {
    cy.wait(2000) // wait for 2 seconds

    cy.get('.products article').first().within(() => {
      cy.get('button').first().click({force: true})})

    cy.get('.navbar')
      .should('contain', 'My Cart (1)')
  })
})
