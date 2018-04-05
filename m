Date: Thu, 5 Apr 2018 18:12:14 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180405161214.GB9976@kroah.com>
References: <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
 <5AC5FAA8.80409@nxp.com>
 <20180405114736.GA12178@lunn.ch>
 <5AC61393.7090509@nxp.com>
 <20180405124810.GE12178@lunn.ch>
 <5AC63610.4000504@nxp.com>
 <20180405152348.GC32663@lunn.ch>
 <HE1PR0402MB2700E32234735AC12C18BB8F94BB0@HE1PR0402MB2700.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB2700E32234735AC12C18BB8F94BB0@HE1PR0402MB2700.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 03:35:30PM +0000, Ruxandra Ioana Ciocoi Radulescu wrote:
> > -----Original Message-----
> > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > Sent: Thursday, April 5, 2018 6:24 PM
> > To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Cc: Stuart Yoder <stuyoder@gmail.com>; Arnd Bergmann <arnd@arndb.de>;
> > Ioana Ciornei <ioana.ciornei@nxp.com>; gregkh
> > <gregkh@linuxfoundation.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Ruxandra Ioana Ciocoi Radulescu
> > <ruxandra.radulescu@nxp.com>; Razvan Stefanescu
> > <razvan.stefanescu@nxp.com>; Roy Pledge <roy.pledge@nxp.com>;
> > Networking <netdev@vger.kernel.org>
> > Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
> > 
> > On Thu, Apr 05, 2018 at 02:43:29PM +0000, Laurentiu Tudor wrote:
> > > Hi Andrew,
> > >
> > > On 04/05/2018 03:48 PM, Andrew Lunn wrote:
> > > >>> Hi Laurentiu
> > > >>>
> > > >>> So i can use switchdev without it? I can modprobe the switchdev
> > > >>> driver, all the physical interfaces will appear, and i can use ip addr
> > > >>> add etc. I do not need to use a user space tool at all in order to use
> > > >>> the network functionality?
> > > >>
> > > >> Absolutely!
> > > >
> > > > Great.
> > > >
> > > > Then the easiest way forwards is to simply drop the IOCTL code for the
> > > > moment. Get the basic support for the hardware into the kernel
> > > > first. Then come back later to look at dynamic behaviour which needs
> > > > some form of configuration.
> > >
> > > Hmm, not sure I understand. We already have a fully functional ethernet
> > > driver [1] and a switch driver [2] ...
> > 
> > In staging, the tree of crap. You want to get it out of there and into
> > the main tree. But that effort is being side lined by the discussion
> > around this IOCTL call.  The best way forward is to to accept Greg is
> > not going to take this patchset at the moment, and move on. As you
> > said, it is not needed for the Ethernet and switchdev driver.
> > 
> > What needs to happen before the Ethernet driver can be reviewed for
> > moving out of staging?
> 
> Hi Andrew,
> 
> We're waiting for the DPIO driver (which we depend on) to be moved
> out of staging first, it's currently under review:
> https://lkml.org/lkml/2018/3/27/1086

That's stalled on my side right now as the merge window is open and I
can't do any new stuff until after 4.17-rc1 is out.  So everyone please
be patient a bit...

thanks,

greg k-h
