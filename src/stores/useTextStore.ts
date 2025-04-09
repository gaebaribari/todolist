import { create } from "zustand";

interface TextState {
	text: string;
	updateText: (input: string | React.ChangeEvent<HTMLTextAreaElement>) => void;
}

export const useTextStore = create<TextState>()((set) => ({
	text: "",
	updateText: (input) => {
		if (typeof input === "string") {
			set(() => ({ text: input }));
		} else {
			set(() => ({ text: input.target.value }));
		}
	},
}));
