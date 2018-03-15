Date: Thu, 15 Mar 2018 18:23:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [patch 0/4] genirq: Clean up license information
Message-ID: <20180315172343.GA28917@kroah.com>
References: <20180314211515.429128440@linutronix.de>
 <1521126018.22221.8.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521126018.22221.8.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 08:00:18AM -0700, Joe Perches wrote:
> On Wed, 2018-03-14 at 22:15 +0100, Thomas Gleixner wrote:
> > The following patch series cleans up the licensing information in the
> > generic irq subsystem.
> > 
> >   * Replace boiler plate language and sloppy references with SPDX
> > 
> >   * Add missing SPDX identifiers to files with no license reference
> > 
> >   * Use the proper tag format
> > 
> > While at it clean up the top of file comments by removing pointless
> > references to the filename itself and condense the information where
> > appropriate.
> 
> Hello.
> 
> What do you think of the proposal to convert all the tags
> to the "-or-later" and "-only" variants that the
> https://spdx.org/licenses/ uses today?

Ick ick ick ick.  Let's stick with what we have today, if we do decide
to do this type of foolishness, we can do it all in one simple script to
email to Linus to run on his tree.

thanks,

greg k-h
