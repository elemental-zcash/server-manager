#!/usr/bin/env node
const { runner, garson, prompts, actions } = require('garson');

const config = garson()
  .prompt(
    'apps',
    prompts.multiChoices({
      message: 'Which apps do you want to install? (*) required\nPress space to select/deselect.',
      items: [
        { label: 'Elemental SSO (*)', value: 'sso', isSelected: true },
        { label: 'Elemental Pay', value: 'pay', isSelected: true },
        { label: 'ZPublish', value: 'publish' },
        // { label: 'Everything', value: 'lwm', isSelected: false },
      ],
      // optional handler
      onChangeMiddleware(newItems, oldItems, allItems) {
        if (!newItems.some(({ value }) => value === 'sso')) {
          return newItems.concat(allItems.find(({ value }) => value === 'sso'));
        }

        return newItems;
      },
    })
  )
  .prompt(
    'ssoHostname',
    prompts.input({
      message: "What's your SSO server URL hostname?",
      placeholder: 'E.g. sso.example.com',
    })
  )
  .prompt(
    'payHostname',
    prompts.input({
      message: "What's your payment server URL hostname?",
      placeholder: 'E.g. sso-api.example.com',
    })
  )
  .prompt(
    'publishHostname',
    prompts.input({
      message: "What's your ZPublish URL hostname?",
      placeholder: 'E.g. zpublish.org',
    })
  )
  // second prompt
  .prompt(
    'lastName',
    prompts.input({
      message: "What's your last name?",
      placeholder: 'E.g. Smith',
    })
  )
  // final action
  .action(results => {
    // note the keys of the result object
    const { firstName, lastName } = results;
    actions.printMessage({ message: `Hello, ${firstName} ${lastName}` });
  });

runner(config);
