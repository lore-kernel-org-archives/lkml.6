Date: Thu, 22 Mar 2018 15:05:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Axtens <dja@axtens.net>
Cc: Michael Neuling <mikey@neuling.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Jiri Slaby <jslaby@suse.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tty crash in Linux 4.6
Message-ID: <20180322140554.GA3273@kroah.com>
References: <alpine.LRH.2.02.1605161555430.8188@file01.intranet.prod.int.rdu2.redhat.com>
 <573A5996.3080305@hurleysoftware.com>
 <573B3F84.5050201@hurleysoftware.com>
 <573B5E4C.8030808@hurleysoftware.com>
 <alpine.LRH.2.02.1607071855150.19053@file01.intranet.prod.int.rdu2.redhat.com>
 <CAEjGV6zRghiCCMC1+-n+YPeA0Lrq=-vcvdoYpbwE4G=TXWzY3Q@mail.gmail.com>
 <87po3wusq1.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87po3wusq1.fsf@linkitivity.dja.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 12:48:06AM +1100, Daniel Axtens wrote:
> Hi,
> 
> >> This patch works, I've had no tty crashes since applying it.
> >>
> >> I've seen that you haven't sent this patch yet to Linux-4.7-rc and
> >> Linux-4.6-stable. Will you? Or did you create a different patch?
> >
> > We are hitting this now on powerpc.  This patch never seemed to make
> > it upstream (drivers/tty/tty_ldisc.c hasn't been touched in 1 year).
> 
> I seem to be hitting this too on a kernel that has the 4.6 changes
> backported to 4.4.
> 
> Has there been any further progress on getting this accepted?

Can you try applying 28b0f8a6962a ("tty: make n_tty_read() always abort
if hangup is in progress") to see if that helps out or not?

thanks,

greg k-h
