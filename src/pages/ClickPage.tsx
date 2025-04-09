import { useEffect } from "react";
import { useTextStore } from "../stores/useTextStore";
import { useTodolistStore } from "../stores/useTodolistStore";

export default function ClickPage() {
	const { text } = useTextStore();
	const { todolist, updateTodolist, completeTodo } = useTodolistStore();

	useEffect(() => {
		updateTodolist(text);
	}, []);

	const filteredTodo = todolist.filter((todo) => !todo.completed);

	return (
		<>
			{filteredTodo.map((todo, index) => (
				<div>
					<button onClick={() => completeTodo(index)}>{todo.title}</button>
				</div>
			))}
		</>
	);
}
