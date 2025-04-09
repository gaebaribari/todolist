import { create } from "zustand";

interface TodoState {
	title: string;
	completed: boolean;
	completedDate: string | null;
}

interface TodolistState {
	todolist: TodoState[];
	updateTodolist: (updateContent: string) => void;
	completeTodo: (index: number) => void;
}

export const useTodolistStore = create<TodolistState>()((set) => ({
	todolist: [],
	updateTodolist: (updateContent: string) => {
		const lines = updateContent.split("\n");
		const newTodoList = lines.map((line) => ({
			title: line,
			completed: false,
			completedDate: null,
		}));
		set(() => ({ todolist: [...newTodoList] }));
	},
	completeTodo: (index: number) => {
		const TIME_ZONE = 9 * 60 * 60 * 1000;
		const d = new Date();

		const date = new Date(d.getTime() + TIME_ZONE).toISOString().split("T")[0];
		const time = d.toTimeString().split(" ")[0];

		set((state) => {
			const newTodos = [...state.todolist];
			newTodos[index] = {
				...newTodos[index],
				completed: true,
				completedDate: date + " " + time,
			};
			return { todolist: newTodos };
		});
	},
}));
