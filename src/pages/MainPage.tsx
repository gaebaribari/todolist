import { useState } from "react";
import ToggleButton from "../components/ToggleButton";
import ClickPage from "./ClickPage";
import WritePage from "./WritePage";

interface TodoItem {
	title: string;
	completed: boolean;
	completedDate: string | null;
}

type UpdateText = (
	input: string | React.ChangeEvent<HTMLTextAreaElement>
) => void;

export default function MainPage() {
	const [isActive, setIsActive] = useState(false);
	const [todoList, setTodoList] = useState<TodoItem[]>([]);
	const [text, setText] = useState("");

	const updateText: UpdateText = (input) => {
		if (typeof input === "string") {
			setText(input);
		} else {
			setText(input.target.value);
		}
	};

	const updateTodoList = (updateContent: string) => {
		const lines = updateContent.split("\n");
		const newTodoList = lines.map((line) => ({
			title: line,
			completed: false,
			completedDate: null,
		}));
		setTodoList([...newTodoList]);
	};

	const completeTodoItem = (index: number) => {
		const TIME_ZONE = 9 * 60 * 60 * 1000;
		const d = new Date();

		const date = new Date(d.getTime() + TIME_ZONE).toISOString().split("T")[0];
		const time = d.toTimeString().split(" ")[0];

		setTodoList((prev) => {
			const newTodos = [...prev];
			newTodos[index] = {
				...newTodos[index],
				completed: true,
				completedDate: date + " " + time,
			};
			console.log(newTodos);
			return newTodos;
		});
	};

	return (
		<>
			{isActive ? (
				<ClickPage
					text={text}
					TodoList={todoList}
					onUpdate={updateTodoList}
					onClick={completeTodoItem}
				/>
			) : (
				<WritePage text={text} onText={updateText} TodoList={todoList} />
			)}
			<ToggleButton
				isActive={isActive}
				onClick={() => setIsActive((prev) => !prev)}
			></ToggleButton>
		</>
	);
}
