Date: Mon, 23 Apr 2018 08:57:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [patch 0/9] LICENSES: Add missing License Text and fixup bogus
 identifiers
Message-ID: <20180423065700.GG4208@kroah.com>
References: <20180422220208.772527041@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422220208.772527041@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 12:02:08AM +0200, Thomas Gleixner wrote:
> There are a few bogus SPDX identifiers in various files and SPDX
> Identifiers used in tree or about to be used which have no corresponding
> License Text file in the LICENSES directory or use the new variant of the
> GPL-2.0[+] license identifiers which are not mentioned in the GPL-2.0
> Valid-License-Identifiers: tags.
> 
> The following series cleans that up:
> 
>  - Use the proper identifiers
> 
>  - Add GPL-2.0-only and GPL-2.0-or-later identifiers to the GPL2.0 license
> 
>  - Add X11, Apache-2.0, CC-BY-SA-4.0, CCDL-1.0, Linux-OpenIB license texts
>    to the LICENSES directory along with the required documentation texts

I'm thinking we need a script to keep these in check, right?  Does
checkpatch.pl handle knowing what the "currently good" list of license
tags are, or should we just use a separate script to parse the LICENSES/
directory to get that list?

Either way, nice work on this series, thanks for keeping up with them.

thanks,

greg k-h
