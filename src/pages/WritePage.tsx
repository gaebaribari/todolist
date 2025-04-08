import { useEffect } from "react";

interface TodoItem {
	title: string;
	completed: boolean;
	completedDate: string | null;
}

interface Prop {
	text: string;
	onText: (input: React.ChangeEvent<HTMLTextAreaElement> | string) => void;
	TodoList: TodoItem[];
}

export default function WritePage({ text, onText, TodoList }: Prop) {
	useEffect(() => {
		const newText = TodoList.filter((item) => !item.completed)
			.map((item) => item.title)
			.join("\n");
		onText(newText);
	}, []);

	return (
		<div className="p-4">
			<label htmlFor="Notes">
				<span className="text-sm font-medium text-gray-700 dark:text-gray-200 mb-2">
					Notes
				</span>
				<textarea
					id="Notes"
					value={text}
					onChange={(e) => onText(e.target.value)}
					className="mt-0.5 w-full resize-none rounded border-gray-300 shadow-sm sm:text-sm dark:border-gray-600 dark:bg-gray-900 dark:text-white"
					rows={10}
				></textarea>
			</label>
		</div>
	);
}
