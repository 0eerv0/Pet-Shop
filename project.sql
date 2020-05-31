
--
-- Database: `project`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllEmployees` ()  BEGIN
	SELECT *  FROM staff WHERE NOT sec_id=99999;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMammalPrice` ()  BEGIN
	SELECT 
		priceUSD, 
		name
	FROM
		pets
    where sec_id=69424;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetReptiles` ()  BEGIN
	SELECT
        pet_id,
		name, 
		age,
        ageMonth, 
		description, 
		priceUSD, 
		sex,
        Vaccinated
	FROM
		pets
    WHERE sec_id=69421;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcDiscountedPrice` (`quantity` DECIMAL(9,2), `price` DECIMAL(9.2), `discount` DECIMAL(9,2)) RETURNS DECIMAL(9,2) BEGIN
  DECLARE newPrice DECIMAL(9,2);
  SET newPrice = (quantity * price)* (discount/100);
  RETURN newPrice;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `calcTotal` (`quantity` INT, `price` FLOAT) RETURNS DECIMAL(9,2) BEGIN
  DECLARE total DECIMAL(9,2);
  SET total = price*quantity;
  RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `salaryPromotion` (`salary` INT, `promotion` INT) RETURNS INT(11) BEGIN
  DECLARE newSalary int;
  SET newSalary = salary+promotion;
  RETURN newSalary;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `quantity` int(11) NOT NULL,
  `c_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL,
  `priceUSD` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`quantity`, `c_id`, `prod_id`, `priceUSD`) VALUES
(0, 1158, 25, 50),
(2, 2103, 31, 6),
(7, 2157, 30, 5);

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `c_id` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pnumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`name`, `surname`, `c_id`, `address`, `email`, `pnumber`) VALUES
('Sonila ', 'Dedja', 1043, '3005  Parkway Drive', 'sdedja@epoka.edu.al', 3025148),
('Jeton ', 'Duka', 1158, '2128  Flinderation Road', 'jduka@epoka.edu.al', 4256325),
('Silvester', 'Stal', 1234, '4569  Shady Pines Drive', 'silvester@epoka.edu.al', 5681472),
('Ilir', 'Kasapi', 2103, '2502  Grant Street', 'ikasapi@hotmail.com', 8254196),
('Lindita', 'Baris', 2157, '4469  Grant Street', 'lbaris@gmail.com', 5263145),
('Marigo', 'Love', 2254, '1782  Sharky Lane', 'm.love69@groupbuff.com', 6952695);

--
-- Triggers `client`
--
DELIMITER $$
CREATE TRIGGER `tr_client_log` AFTER INSERT ON `client` FOR EACH ROW BEGIN
        INSERT INTO clientlog(clientID, message)
        VALUES(NEW.c_id, CONCAT('Hi ', NEW.name, ', welcome to our petshop.'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `clientlog`
--

CREATE TABLE `clientlog` (
  `id` int(11) NOT NULL,
  `clientID` int(11) NOT NULL,
  `message` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clientlog`
--

INSERT INTO `clientlog` (`id`, `clientID`, `message`) VALUES
(1, 2254, 'Hi Marigo, welcome to our petshop.');

-- --------------------------------------------------------

--
-- Table structure for table `pets`
--

CREATE TABLE `pets` (
  `pet_id` int(11) NOT NULL,
  `sec_id` int(11) NOT NULL,
  `type` enum('Dog','Cat','Hamster','Ferret','Frog','Salamander','Axolotl','Robin','Sparrow','Owl','Clownfish','Blue Tang','Lizard','Turtle') NOT NULL,
  `breed` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `ageMonth` int(11) NOT NULL,
  `sex` enum('Male','Female') NOT NULL,
  `description` text NOT NULL,
  `Vaccinated` enum('Yes','No') NOT NULL,
  `priceUSD` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pets`
--

INSERT INTO `pets` (`pet_id`, `sec_id`, `type`, `breed`, `name`, `age`, `ageMonth`, `sex`, `description`, `Vaccinated`, `priceUSD`) VALUES
(1201, 69420, 'Frog', 'Darwin\'s Frog', 'Steve', 10, 2, 'Male', 'Darwin\\\'s frog was named after Charles Darwin, who discovered it on his world voyage. This frog lives in the cool forest streams of South America, mostly in Argentina and Chile.Darwin\\\'s frog is small a', 'Yes', 20),
(1202, 69420, 'Frog', 'Goliath Frog', 'Ponyo', 2, 6, 'Female', 'The goliath frog otherwise known as goliath bullfrog or giant slippery frog is the largest living frog on Earth. Specimens can grow up to 32 centimetres in length from snout to vent, and weigh up to 3.25 kilograms. This species has a relatively small habitat range in Cameroon and Equatorial Guinea.', 'Yes', 112),
(1301, 69420, 'Salamander', 'Spotted Salamander', 'Franky', 5, 1, 'Male', 'The spotted salamander or yellow-spotted salamander is a mole salamander common in eastern United States and Canada. The spotted salamander is the state amphibian of Ohio and South Carolina. This salamander ranges from Nova Scotia, to Lake Superior, to southern Georgia and Texas', 'No', 17),
(1401, 69420, 'Axolotl', 'Mexican Axolotl', 'Mudkip', 14, 7, 'Female', 'Mexican axolotl salamanders are amphibians that spend their whole lives underwater. They exist in the wild in only one place—the lake complex of Xochimilco, a network of artificial channels, small lakes, and temporary wetlands that help supply water to nearby Mexico City’s 18 million residents.', 'Yes', 35),
(2201, 69424, 'Dog', 'Akita Chow', 'Dash', 3, 2, 'Male', 'The Akita Chow is a mixed breed dog–a cross between the Akita and Chow Chow dog breeds. Large, independent, and loyal, these pups inherited some of the best traits from both of their parents.', 'Yes', 856),
(2202, 69424, 'Dog', 'Beagle', 'Bonnie', 0, 5, 'Female', 'Small, compact, and hardy, Beagles are active companions for kids and adults alike. Canines of this dog breed are merry and fun loving, but being hounds, they can also be stubborn and require patient, creative training techniques.', 'Yes', 269),
(2203, 69424, 'Dog', 'Chinook', 'Maddie', 2, 3, 'Female', 'Created in the White Mountains of New Hampshire, the Chinook dog breed made his name on Admiral Byrd’s first Antarctic expedition in 1928. These days he’s a multipurpose dog who’s happy hiking, competing in agility and other dog sports, pulling a sled or other conveyance, and playing with the kids.', 'No', 315),
(2204, 69424, 'Dog', 'Border Terrier', 'Thor', 1, 0, 'Male', 'This alert, good-natured dog was originally bred to assist in foxhunts, driving foxes out of their hiding places and out into the open for the hounds to chase. He still has a powerful drive to hunt and dig, as well as the energy level that enabled him to keep up with hunters on horseback. These traits can make him an aggravating pet for some owners; for others, Border Terriers are wonderful companions who play hard and love harder.', 'No', 670),
(2401, 69424, 'Cat', 'Birman', 'Puss', 0, 2, 'Female', 'With her marvelous, social personality, the Birman doesn’t like being the only animal in the house. She is active and playful but quiet if you are busy. This healthy, long-lived breed has an outstanding semi-long silky coat that does not mat and a luxurious, long bottle-brush tail. Brilliant blue, almost-round eyes are prominent features of her sweet expression.', 'Yes', 34),
(2402, 69424, 'Cat', 'Chartreux', 'Oliver', 6, 1, 'Male', 'Often called the smiling cat of France, the Chartreux has a sweet, smiling expression. This sturdy, powerful cat has a distinctive blue coat with a resilient wooly undercoat. Historically known as fine mousers with strong hunting instincts, the Chartreux enjoys toys that move. This is a slow-maturing breed that reaches adulthood in three to five years. A loving, gentle companion, the Chartreux forms a close bond with her family.', 'Yes', 27),
(2403, 69424, 'Cat', 'American Wirehair', 'Elio', 3, 2, 'Male', 'Distinguished from other breeds by its wiry, dense coat that is described as feeling like steel wool, the American Wirehair is considered a national treasure. This intelligent and highly adaptable breed is playful and keenly interested in her surroundings. Easy to care for, the American Wirehair has a relaxed, loving, sweet personality, making her an ideal companion for families with children 6 and older and having other pets.', 'Yes', 354),
(2601, 69424, 'Hamster', 'Teddy Bear', 'Hamtaro', 0, 7, 'Male', 'They are very easy to handle and make wonderful pets for children. They are not social with other hamsters however, and should be kept alone after 10 weeks of age. If caged together, Syrian hamsters can actually fight until they kill each other. Syrian hamsters are nocturnal, and are rarely active during the day.', 'Yes', 23),
(2602, 69424, 'Hamster', 'Dwarf Campbell Russi', 'Totoro', 1, 3, 'Female', 'Dwarf Campbell Russian hamsters are more social  and they can be kept in same sex pairs or groups of their breed as long as they are introduced at a young age.They still make good pets; they just require supervision of both child and pet during interactions. Though they are nocturnal, they are often awake for short periods during the day.', 'No', 36),
(2603, 69424, 'Ferret', 'Albino', 'Alfred', 0, 3, 'Male', 'Albino ferrets have a white coat, a pink nose, and pink to red eyes. They mainly look attractive because of their neat white coat, which also makes it easier for the owners to locate their pets even in dark rooms. These ferrets are especially energetic in the morning and love to nap in the afternoons. They should be bathed once a month. Albino ferrets are often kept as a therapy pet for the kids and the elderly.', 'Yes', 24),
(3201, 69422, 'Clownfish', 'Clownfish', 'Nemo', 0, 5, 'Male', 'Bright orange with three distinctive white bars, clown anemonefish are among the most recognizable of all reef-dwellers. They reach about 4.3 inches in length, and are named for the multicolored sea anemone in which they make their homes.', 'No', 5),
(3202, 69422, 'Clownfish', 'Clownfish', 'Marlin', 1, 6, 'Male', 'Bright orange with three distinctive white bars, clown anemonefish are among the most recognizable of all reef-dwellers. They reach about 4.3 inches in length, and are named for the multicolored sea anemone in which they make their homes.', 'Yes', 5),
(3203, 69422, 'Blue Tang', 'Blue Tang', 'Dory', 1, 4, 'Female', 'The Blue Tang boasts a vibrant electric blue body dressed with bold black markings. In fact, the black that begins at the eyes, traces the dorsal line down to the tail, and circles back above the pectoral fin to create a unique shape reminiscent of a painter\\\'s palette. This marking is why the Blue Tang is also known as the Palette Surgeonfish. It is also called the Pacific Blue Tang, and Hepatus or Regal Tang. Regardless of common name, Paracanthurus hepatus is equal parts beauty and peacefulness that suits almost any large community marine aquarium.', 'No', 89),
(4201, 69421, 'Lizard', 'Collared', 'Slesh', 15, 2, 'Male', 'If collared lizards grew to the size of Komodo dragons, they would probably prey upon them. Crotaphytus are voracious predators on other lizard species, although they don’t pass up the chance to snack on insects and other small vertebrates. Juvenile collared lizards concentrate more on insects whereas adult collared lizards take small mice. Collared lizards proportionately large heads are equipped with large jaws that can kill prey animals with a few quick bites.', 'No', 471),
(4202, 69421, 'Lizard', 'Caiman', 'Nyla', 4, 2, 'Female', 'This is not a lizard for beginners! This rare and specialized denizen of forested riverbanks is imported in low numbers and is still a rarity in the pet trade. The caiman lizards’ large size and potentially painful bite are two more reasons that few tackle its husbandry. Worst of all, most fresh imports prefer a diet of snails  a food item difficult to provide for most keepers.', 'Yes', 671),
(4401, 69421, 'Turtle', 'The red-eared slider', 'Mike', 20, 6, 'Male', 'The red-eared slider is a medium-sized to large-sized freshwater turtle with origins in the southeastern United States. Their natural range is from Indiana to the north, New Mexico to the west, and the Gulf of Mexico to the south, though sliders have been introduced into the wild well beyond this range.', 'Yes', 104),
(5201, 69423, 'Robin', 'European Robin', 'Kuqo', 1, 8, 'Male', 'Common to fairly common in wooded habitats, gardens, hedges in farmland, and heathland, usually fairly near cover. Hops perkily on the ground, pausing to look around, when often flicks wings and cocks tail. Also feeds by dropping to the ground from low perches, snatching up prey and flying back up to a shady perch. Plumage distinctive, with bright orangey face and breast (easily hidden when facing away); juvenile in summer very different, with bold pale buffy spotting on back and breast.', 'No', 495),
(5401, 69423, 'Sparrow', 'House Sparrow', 'Jack', 6, 1, 'Female', 'The house sparrow is a bird of the sparrow family Passeridae, found in most parts of the world. It is a small bird that has a typical length of 16 cm and a mass of 24–39.5 g. Females and young birds are coloured pale brown and grey, and males have brighter black, white, and brown markings', 'No', 6),
(5601, 69423, 'Owl', 'Barred', 'Barry', 26, 5, 'Male', 'The Barred Owl’s hooting call, “Who cooks for you? Who cooks for you-all?” is a classic sound of old forests and treed swamps. But this attractive owl, with soulful brown eyes and brown-and-white-striped plumage, can also pass completely unnoticed as it flies noiselessly through the dense canopy or snoozes on a tree limb. Originally a bird of the east, during the twentieth century it spread through the Pacific Northwest and southward into California.', 'Yes', 593);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `prod_id` int(11) NOT NULL,
  `priceUSD` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`prod_id`, `priceUSD`, `name`, `quantity`) VALUES
(25, 50, 'Chris Christensen Sp', 2),
(26, 8, 'Wahl 4-In-1 Calming Pet Shampoo – Cleans, Conditio', 0),
(27, 4, 'Purina Friskies Gravy Swirlers Adult Dry Cat Food', 5),
(28, 2, 'SmartyKat Catnip Cat Toys', 3),
(29, 15, 'Wagner\'s 13008 Deluxe Blend Wild Bird Food, 10-Pou', 1),
(30, 5, 'Outward Hound Invincibles Squeaky Dog Toy', 7),
(31, 6, 'Fluker\'s Turtle Food', 2),
(32, 6, 'Fluker\'s Pothos Repta Vines for Reptiles and Amphi', 4),
(33, 12, 'KAYTEE® Forti-Diet Pro Health Hamster & Gerbil Food', 2);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `tr_ins_prodName` BEFORE INSERT ON `products` FOR EACH ROW SET NEW.name = UPPER(NEW.name)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_up_prodName` BEFORE UPDATE ON `products` FOR EACH ROW SET NEW.name = LOWER(NEW.name)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sector`
--

CREATE TABLE `sector` (
  `sec_id` int(11) NOT NULL,
  `type` enum('AMP','REP','FIS','BIR','MAM','Manager') NOT NULL,
  `s_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sector`
--

INSERT INTO `sector` (`sec_id`, `type`, `s_id`) VALUES
(69420, 'AMP', 130),
(69421, 'REP', 372),
(69422, 'FIS', 503),
(69423, 'BIR', 859),
(69424, 'MAM', 927),
(99999, 'Manager', 665);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `s_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `Sex` enum('Male','Female') NOT NULL,
  `email` varchar(50) NOT NULL,
  `pnumber` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `sec_id` int(11) DEFAULT NULL,
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`s_id`, `name`, `surname`, `Sex`, `email`, `pnumber`, `address`, `sec_id`, `salary`) VALUES
(130, 'Phillip', 'Stalcup', 'Male', '6gvje9n35om@groupbuff.com', 467611174, '273  Forest Avenue', 69420, 250),
(372, 'Adrian', 'Cartwright', 'Male', 'av7nfd06gwn@powerencry.com', 77964787, '3753  County Line Road', 69421, 350),
(503, 'Marie', 'Smith', 'Female', 'z3k1rk80rp@fakemailgenerator.net', 24322033, '3579  Whispering Pines Circle', 69422, 475),
(665, 'Richard', 'Hill', 'Male', 'o18nztu7ge@meantinc.com', 45820552, '3712  Big Indian', 99999, 900),
(859, 'Florence', 'Manion', 'Female', 'ng5jk7yjwja@powerencry.com', 84128424, '182  Hardesty Street', 69423, 630),
(927, 'Janie', 'King', 'Male', 'janieking@gmail.com', 16494613, '1666  Rubaiyat Road', 69424, 190);

-- --------------------------------------------------------

--
-- Table structure for table `usage_for`
--

CREATE TABLE `usage_for` (
  `type_product` varchar(50) NOT NULL,
  `pet_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usage_for`
--

INSERT INTO `usage_for` (`type_product`, `pet_id`, `prod_id`) VALUES
('Shampoo', 2201, 25),
('Shampoo', 2202, 26),
('Toy', 2203, 30),
('Food', 2401, 27),
('Toy', 2403, 28),
('Food', 2602, 33),
('Food', 4401, 31),
('Habitat', 4401, 32),
('Food', 5201, 29);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`c_id`,`prod_id`),
  ADD KEY `prod_id` (`prod_id`),
  ADD KEY `priceUSD` (`priceUSD`),
  ADD KEY `quantity` (`quantity`),
  ADD KEY `quantity_2` (`quantity`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`c_id`);

--
-- Indexes for table `clientlog`
--
ALTER TABLE `clientlog`
  ADD PRIMARY KEY (`id`,`clientID`);

--
-- Indexes for table `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`pet_id`),
  ADD KEY `pets` (`sec_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`prod_id`),
  ADD KEY `priceUSD` (`priceUSD`,`quantity`),
  ADD KEY `quantity` (`quantity`);

--
-- Indexes for table `sector`
--
ALTER TABLE `sector`
  ADD PRIMARY KEY (`sec_id`),
  ADD KEY `sector` (`s_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`s_id`),
  ADD KEY `staff` (`sec_id`);

--
-- Indexes for table `usage_for`
--
ALTER TABLE `usage_for`
  ADD PRIMARY KEY (`pet_id`,`prod_id`),
  ADD KEY `usage_for2` (`prod_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientlog`
--
ALTER TABLE `clientlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill`
--
ALTER TABLE `bill`
  ADD CONSTRAINT `bill_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `client` (`c_id`),
  ADD CONSTRAINT `bill_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `products` (`prod_id`),
  ADD CONSTRAINT `bill_ibfk_3` FOREIGN KEY (`priceUSD`) REFERENCES `products` (`priceUSD`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `bill_ibfk_4` FOREIGN KEY (`quantity`) REFERENCES `products` (`quantity`);

--
-- Constraints for table `pets`
--
ALTER TABLE `pets`
  ADD CONSTRAINT `pets` FOREIGN KEY (`sec_id`) REFERENCES `sector` (`sec_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sector`
--
ALTER TABLE `sector`
  ADD CONSTRAINT `sector` FOREIGN KEY (`s_id`) REFERENCES `staff` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff` FOREIGN KEY (`sec_id`) REFERENCES `sector` (`sec_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usage_for`
--
ALTER TABLE `usage_for`
  ADD CONSTRAINT `usage_for` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usage_for2` FOREIGN KEY (`prod_id`) REFERENCES `products` (`prod_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
