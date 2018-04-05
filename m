Date: Thu, 5 Apr 2018 14:30:18 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Stuart Yoder <stuyoder@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180405123018.GA17751@kroah.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch>
 <5AC5FAA8.80409@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AC5FAA8.80409@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 10:30:01AM +0000, Laurentiu Tudor wrote:
> Hello,
> 
> My 2c below.
> 
> On 04/04/2018 03:42 PM, Andrew Lunn wrote:
> >> I hear you.  It is more complicated this way...having all these individual
> >> objects vs just a single "bundle" of them that represents a NIC.  But, that's
> >> the way the DPAA2 hardware is, and we're implementing kernel support for
> >> the hardware as it is.
> >
> > Hi Stuart
> >
> > I see we are not making any progress here.
> >
> > So what i suggest is you post the kernel code and configuration tool
> > concept to netdev for a full review. You want reviews from David
> > Miller, Jiri Pirko, Jakub Kicinski, David Ahern, etc.
> >
> 
> I think that the discussion steered too much towards networking related 
> topics, while this ioctl doesn't have much to do with networking.
> It's just an ioctl for our mc-bus bus driver that is used to manage the 
> devices on this bus through userspace tools.
> In addition, I'd drop any mention of our reference user space app 
> (restool) to emphasize that this ioctl is not added just for a 
> particular user space app. I think Stuart also mentioned this.

I'm not going to take a "generic device configuration ioctl" patch
unless it is documented to all exactly what it does, and why it is
there.

thanks,

greg k-h
