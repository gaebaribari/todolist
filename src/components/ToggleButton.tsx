interface Props {
	isActive: boolean;
	onClick: () => void;
}

export default function ToggleButton({ isActive, onClick }: Props) {
	return (
		<div className="text-right mr-2">
			<label className="inline-flex items-center cursor-pointer">
				<input
					type="checkbox"
					checked={isActive}
					onChange={onClick}
					className="sr-only peer"
				/>
				<div className="relative w-11 h-6 bg-gray-200 peer-focus:outline-none  peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600 dark:peer-checked:bg-blue-600"></div>
				<span className="ms-3 text-sm text-gray-900 dark:text-gray-300">
					Toggle me
				</span>
			</label>
		</div>
	);
}
