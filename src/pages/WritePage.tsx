import { useEffect } from "react";
import { useTextStore } from "../stores/useTextStore";
import { useTodolistStore } from "../stores/useTodolistStore";

export default function WritePage() {
	const { text, updateText } = useTextStore();
	const { todolist } = useTodolistStore();
	useEffect(() => {
		const newText = todolist
			.filter((item) => !item.completed)
			.map((item) => item.title)
			.join("\n");
		updateText(newText);
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
					onChange={(e) => updateText(e.target.value)}
					className="mt-0.5 w-full resize-none rounded border-gray-300 shadow-sm sm:text-sm dark:border-gray-600 dark:bg-gray-900 dark:text-white"
					rows={10}
				></textarea>
			</label>
		</div>
	);
}
