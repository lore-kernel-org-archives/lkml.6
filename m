Date: Mon, 23 Apr 2018 10:25:28 +0200
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
Subject: Re: [PATCH v7 1/6] typec: tcpm: Add core support for sink side PPS
Message-ID: <20180423082528.GA20868@kroah.com>
References: <cover.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <daf72dd237653e55c0485e930108c19a4996aa4f.1521799705.git.Adam.Thomson.Opensource@diasemi.com>
 <20180422140508.GA21446@kroah.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6AAD@SW-EX-MBX01.diasemi.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E6B41@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E6B41@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 07:49:38AM +0000, Adam Thomson wrote:
> On 22 April 2018 21:58, Adam Thomson wrote:
> 
> > On 22 April 2018 15:05, Greg Kroah-Hartman wrote:
> > 
> > > On Fri, Mar 23, 2018 at 10:12:20AM +0000, Adam Thomson wrote:
> > > > This commit adds code to handle requesting of PPS APDOs. Switching
> > > > between standard PDOs and APDOs, and re-requesting an APDO to
> > > > modify operating voltage/current will be triggered by an
> > > > external call into TCPM.
> > > >
> > > > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > >  drivers/usb/typec/tcpm.c | 517
> > > ++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  include/linux/usb/pd.h   |   4 +-
> > > >  include/linux/usb/tcpm.h |   1 +
> > > >  3 files changed, 509 insertions(+), 13 deletions(-)
> > >
> > > This patch adds build warnings to the tree, so I can't take it, sorry.
> > > Please fix up and resend.
> > 
> > No problem. Sorry for that. Will take a look and resolve the warnings.
> 
> Sadly this is going to be a bit more than 'resolve the warnings' task now as Jun
> Li's patch set has now made it in before me which means I need to rebase PDO
> Selection because of his changes. :(

Someone was going to have to do that, sorry :(
