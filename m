Date: Wed, 25 Apr 2018 18:08:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4]  ARM: amba: driver_override improvements and fixes
Message-ID: <20180425160824.GA18150@kroah.com>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <20180410221902.GA16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410221902.GA16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 11:19:02PM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 10, 2018 at 03:21:42PM +0200, Geert Uytterhoeven wrote:
> > 	Hi Greg,
> > 
> > This patch series contains improvements to driver_override handling in
> > the AMBA bus driver, including two bugfixes that are based on similar
> > fixes for the PCI and platform buses, and which Todd Kjos would like to
> > get into the android common branches to fix possible double free.
> > 
> > Changes compared to v1:
> >   - RMK stepped down as amba maintainer.
> 
> No, in the same way as I haven't stepped down as ARM maintainer.
> I've said that I'm not going to be putting as much effort in as I
> have done, specifically I'm not going to be as active reading the
> mailing lists.
> 
> This is the first time I've seen your patches, they look fine to
> me, so please put them in the patch system as normal.

I'll take patches 2 and 3 now as they fix reported issues and would be
good to get merged soon.

thanks,

greg k-h
