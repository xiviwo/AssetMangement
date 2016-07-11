<collection-section: replace>
              <h3>
                <ht key="equipment.collection.heading.other" >
                  Assignments
                </ht>
              </h3>

              <collection:assignments part="assignment" />
              
      <section if="&can_create?(@equipment.assignments)">
          
             
                <h3 >
                  <ht key="assignments.collection.add_form_heading">
                    Add an Assignment
                  </ht>
                </h3>
                
                <form >
                <form:assignments.assign  update="assignment" reset-form refocus-form owner="equipment" without-cancel >
                  <field-list: skip="equipment"/>
                  <submit: label="#{ht 'assignments.actions.add', :default=>['Add'] }"/>
                </form>
              </section>


</collection-section:>


              <section param="add-to-collection" if="&can_create?(@equipment.assignments)">
                <h3 param="add-form-heading">
                  <ht key="assignments.collection.add_form_heading">
                    Add an Assignment
                  </ht>
                </h3>
                <form with="&@assignment || new_for_current_user(@equipment.assignments)" owner="equipment" without-cancel param>
                  <field-list: skip="equipment"/>
                  <submit: label="#{ht 'assignments.actions.add', :default=>['Add'] }"/>
                </form>
              </section>
            </section>
          </section>
        </section>