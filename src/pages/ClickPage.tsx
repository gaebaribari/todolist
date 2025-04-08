import { useEffect } from "react";

interface TodoItem {
	title: string;
	completed: boolean;
	completedDate: string | null;
}

interface Prop {
	text: string;
	TodoList: TodoItem[];
	onUpdate: (updateContent: string) => void;
	onClick: (index: number) => void;
}

export default function ClickPage({ text, TodoList, onUpdate, onClick }: Prop) {
	useEffect(() => {
		onUpdate(text);
	}, []);

	const filteredTodo = TodoList.filter((todo) => !todo.completed);

	return (
		<>
			{filteredTodo.map((todo, index) => (
				<div>
					<button onClick={() => onClick(index)}>{todo.title}</button>
				</div>
			))}
		</>
	);
}
