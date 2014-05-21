module ParametersHelper

  def search_results_test_params
    {
       reference: {
          order_status_names: {
             '4' => 'Invoiced'
          },
          order_stock_status_names: {
             '3' => 'All fulfilled'
          },
          order_type_names: {
             '1' => 'SALES_ORDER'
          }
       },
       response: {
          meta_data: {
             sorting: [
                {
                   direction: 'ASC',
                   filterable: {
                      required: false,
                      report_data_type: 'INTEGER',
                      name: 'orderId',
                      sortable: true,
                      filterable: true
                   }
                }
             ],
             columns: [
                {
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderId',
                   sortable: true,
                   filterable: true
                },
                {
                   reference_data: [
                      'orderTypeNames'
                   ],
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderTypeId',
                   sortable: true,
                   filterable: true
                },
                {
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'contactId',
                   sortable: true,
                   filterable: true
                },
                {
                   reference_data: [
                      'orderStatusNames'
                   ],
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderStatusId',
                   sortable: true,
                   filterable: true
                },
                {
                   reference_data: [
                      'orderStockStatusNames'
                   ],
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'orderStockStatusId',
                   sortable: true,
                   filterable: true
                },
                {
                   required: false,
                   report_data_type: 'PERIOD',
                   name: 'createdOn',
                   sortable: true,
                   filterable: true
                },
                {
                   required: false,
                   report_data_type: 'INTEGER',
                   name: 'createdById',
                   sortable: true,
                   filterable: true
                }
             ],
             last_result: 3,
             first_result: 1,
             results_returned: 3,
             results_available: 3
          },
          results: [
             [
                123456,
                1,
                253,
                4,
                3,
                '2012-12-13T13:00:42.000Z',
                280
             ],
             [
                123457,
                1,
                253,
                4,
                3,
                '2012-12-14T13:00:42.000Z',
                280
             ],
             [
                123458,
                1,
                253,
                4,
                3,
                '2012-12-14T14:00:42.000Z',
                280
             ]
          ]
       }
    }
  end

end
