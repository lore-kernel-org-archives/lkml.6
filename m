Date: Wed, 14 Feb 2018 10:53:08 +0100
From: Greg Kroah-Hartman <gregkh@linux-foundation.org>
To: Chandler Carruth <chandlerc@google.com>
Cc: "Yatsina, Marina" <marina.yatsina@intel.com>,
	Kees Cook <keescook@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>,
	"rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>,
	"ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>,
	Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>,
	James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Message-ID: <20180214095308.GA16956@kroah.com>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
 <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGCO0Kj01tAXdzRrL_p+LrTLK6-k-1-BFPm97jQMuJSPH7PTJQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 08:41:43AM +0000, Chandler Carruth wrote:
> Marina, Kees:
> 
> I think the combination of LKML and the LLVM developer's list is probably
> too large a set of folks to have a (somewhat) lengthy exploration of
> options and how to go about this and find a good path forward.

Why is there any need to discuss "options" here?  What is preventing the
implementation of "asm goto" in llvm?  Is it the lack of a working
patch, or something else?

thanks,

greg k-h
