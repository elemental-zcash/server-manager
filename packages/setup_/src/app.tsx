import React, { useState } from 'react';
import { Text, Box } from 'ink';
import TextInput from 'ink-text-input';

type Props = {
  name: string | undefined;
};

// export default function App({name = 'Stranger'}: Props) {
//   return (
//     <Text>
//       Hello, <Text color="green">{name}</Text>
//     </Text>
//   );
// }
// @ts-ignore
const b: any = (a: any) => null;



export default function App({ name = '123' }: Props) {
  // const {exit} = useApp();
  const [query, setQuery] = useState('');
  let a = name;
  b(a);


  return (
    <Box flexDirection="column">
      <Text>Please type your query.</Text>
      {/* <Box height={12} paddingLeft={x} paddingTop={y}>
        <Text>^_^</Text>
      </Box> */}
      <TextInput value={query} onChange={setQuery} />
    </Box>
  );
}
