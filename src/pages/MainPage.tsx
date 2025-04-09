import { useState } from "react";
import ToggleButton from "../components/ToggleButton";
import ClickPage from "./ClickPage";
import WritePage from "./WritePage";

export default function MainPage() {
	const [isActive, setIsActive] = useState(false);

	return (
		<>
			{isActive ? <ClickPage /> : <WritePage />}
			<ToggleButton
				isActive={isActive}
				onClick={() => setIsActive((prev) => !prev)}
			></ToggleButton>
		</>
	);
}
