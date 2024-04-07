// ╔╗ ╔═╗╔╗╔╔╦╗╔═╗
// ╠╩╗║╣ ║║║ ║ ║ ║
// ╚═╝╚═╝╝╚╝ ╩ ╚═╝
// ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
// │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
// └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘

const CONFIG = {
	// ┌┐ ┌─┐┌─┐┬┌─┐┌─┐
	// ├┴┐├─┤└─┐││  └─┐
	// └─┘┴ ┴└─┘┴└─┘└─┘

	// General
	name: 'sebas',
	imageBackground: true,
	openInNewTab: true,
	twelveHourFormat: true,

	// Greetings
	greetingMorning: 'Good morning!',
	greetingAfternoon: 'Good afternoon,',
	greetingEvening: 'Good evening,',
	greetingNight: 'Go to Sleep!',

	// Layout
	bentoLayout: 'lists', // 'bento', 'lists', 'buttons'

	// Weather
	weatherKey: '8b05d62206f459e1d298cbe5844d7d87', // Write here your API Key
	weatherIcons: 'OneDark', // 'Onedark', 'Nord', 'Dark', 'White'
	weatherUnit: 'C', // 'F', 'C'
	language: 'en', // More languages in https://openweathermap.org/current#multi

	trackLocation: true, // If false or an error occurs, the app will use the lat/lon below
	defaultLatitude: '19.593',
	defaultLongitude: '-99.250',

	// Autochange
	autoChangeTheme: false,

	// Autochange by OS
	changeThemeByOS: true,

	// Autochange by hour options (24hrs format, string must be in: hh:mm)
	changeThemeByHour: false,
	hourDarkThemeActive: '18:30',
	hourDarkThemeInactive: '07:00',

	// ┌┐ ┬ ┬┌┬┐┌┬┐┌─┐┌┐┌┌─┐
	// ├┴┐│ │ │  │ │ ││││└─┐
	// └─┘└─┘ ┴  ┴ └─┘┘└┘└─┘

	firstButtonsContainer: [
		{
			id: '1',
			name: 'sebas',
			icon: 'github',
			link: 'https://github.com/',
		},
		{
			id: '2',
			name: 'sebas',
			icon: 'mail',
			link: 'https://mail.protonmail.com/',
		},
		{
			id: '3',
			name: 'sebas',
			icon: 'trello',
			link: 'https://todoist.com',
		},
		{
			id: '4',
			name: 'sebas',
			icon: 'calendar',
			link: 'https://calendar.google.com/calendar/r',
		},
		{
			id: '5',
			name: 'sebas',
			icon: 'glasses',
			link: 'https://reddit.com',
		},
		{
			id: '6',
			name: 'sebas',
			icon: 'youtube',
			link: 'https://odysee.com/',
		},
	],

	secondButtonsContainer: [
		{
			id: '1',
			name: 'sebas',
			icon: 'headphones',
			link: 'https://open.spotify.com',
		},
		{
			id: '2',
			name: 'sebas',
			icon: 'twitter',
			link: 'https://twitter.com/',
		},
		{
			id: '3',
			name: 'sebas',
			icon: 'bot',
			link: 'https://discord.com/app',
		},
		{
			id: '4',
			name: 'sebas',
			icon: 'shopping-bag',
			link: 'https://amazon.com/',
		},
		{
			id: '5',
			name: 'sebas',
			icon: 'pen-tool',
			link: 'https://hashnode.com/',
		},
		{
			id: '6',
			name: 'sebas',
			icon: 'figma',
			link: 'https://figma.com/',
		},
	],

	// ┬  ┬┌─┐┌┬┐┌─┐
	// │  │└─┐ │ └─┐
	// ┴─┘┴└─┘ ┴ └─┘

	// First Links Container
	firstlistsContainer: [
		{
			icon: 'star',
			id: '1',
			links: [
				{
					name: 'sebas',
					link: 'https://github.com/gh0stzk/dotfiles',
				},
				{
					name: 'sebas',
					link: 'https://archlinux.org/',
				},
				{
					name: 'sebas',
					link: 'https://chat.openai.com/',
				},
				{
					name: 'sebas',
					link: 'https://monkeytype.com/',
				},
			],
		},
		{
			icon: 'tv',
			id: '2',
			links: [
				{
					name: 'sebas',
					link: 'https://www.youtube.com',
				},
				{
					name: 'sebas',
					link: 'https://www.netflix.com',
				},
				{
					name: 'sebas',
					link: 'https://www.twitch.tv',
				},
				{
					name: 'sebas',
					link: 'https://www.primevideo.com',
				},
			],
		},
	],

	// Second Links Container
	secondListsContainer: [
		{
			icon: 'square-user-round',
			id: '1',
			links: [
				{
					name: 'sebas',
					link: 'https://www.spotify.com',
				},
				{
					name: 'sebas',
					link: 'https://www.reddit.com/r/unixporn',
				},
				{
					name: 'sebas',
					link: 'https://www.facebook.com',
				},
				{
					name: 'sebas',
					link: 'https://twitter.com',
				},
			],
		},
		{
			icon: 'binary',
			id: '2',
			links: [
				{
					name: 'sebas',
					link: 'https://www.reddit.com/r/programming/',
				},
				{
					name: 'sebas',
					link: 'https://www.reddit.com/r/rust/',
				},
				{
					name: 'sebas',
					link: 'https://www.reddit.com/r/golang/',
				},
				{
					name: 'sebas',
					link: 'https://www.reddit.com/r/Python/',
				},
			],
		},
	],
};
