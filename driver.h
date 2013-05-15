#pragma once

#include <string>
#include "scanner.h"
#include "parser.tab.hh"

namespace SE{
	class Driver{
		public:
			// constructor
			Driver()
				: parser(NULL), scanner(NULL) {}

			virtual ~Driver();
			void parse(const char *filename);

		private:
			SE::BisonParser *parser;
			SE::FlexScanner *scanner;
	};
}
