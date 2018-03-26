Date: Mon, 26 Mar 2018 14:50:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH v7 2/6] Documentation: power: Initial effort to document
 power_supply ABI
Message-ID: <20180326125019.GA29451@kroah.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <0a26f379c29d65b6e0fa416a4b73aea010b9f718.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180326095703.GA26466@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E2EFD@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E2EFD@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 12:40:06PM +0000, Adam Thomson wrote:
> On 26 March 2018 10:57, Greg Kroah-Hartman wrote:
> 
> > On Fri, Mar 23, 2018 at 10:12:21AM +0000, Adam Thomson wrote:
> > > This commit adds generic ABI information regarding power_supply
> > > properties. This is an initial attempt to try and align the usage
> > > of these properties between drivers. As part of this commit,
> > > common Battery and USB related properties have been listed.
> > >
> > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 443
> > ++++++++++++++++++++++++++++
> > >  MAINTAINERS                                 |   1 +
> > >  2 files changed, 444 insertions(+)
> >
> > How was this not documented before?
> 
> As an FYI, there is some overall documentation under:
> 
>  Documentation/power/power_supply_class.txt
> 
> However, after discussions with Heikki, it was determined something more
> detailed would be useful to help clarify usage.

Oh I agree, it belongs in Documentation/ABI/ like you did here, thank
you so much for that.  I was just amazed it wasn't already there...

thanks,

greg k-h
