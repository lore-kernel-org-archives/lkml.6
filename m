Date: Mon, 19 Mar 2018 18:14:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>, alsa-devel@alsa-project.org,
	Jorge <jorge.sanjuan@codethink.co.uk>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ALSA: usb: initial USB Audio Device Class 3.0
 support
Message-ID: <20180319171408.GC22964@kroah.com>
References: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
 <1521423963-24677-3-git-send-email-ruslan.bilovol@gmail.com>
 <s5h1sggvxkn.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1sggvxkn.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 05:28:56PM +0100, Takashi Iwai wrote:
> On Mon, 19 Mar 2018 02:46:03 +0100,
> Ruslan Bilovol wrote:
> > 
> > Recently released USB Audio Class 3.0 specification
> > introduces many significant changes comparing to
> > previous versions, like
> >  - new Power Domains, support for LPM/L1
> >  - new Cluster descriptor
> >  - changed layout of all class-specific descriptors
> >  - new High Capability descriptors
> >  - New class-specific String descriptors
> >  - new and removed units
> >  - additional sources for interrupts
> >  - removed Type II Audio Data Formats
> >  - ... and many other things (check spec)
> > 
> > It also provides backward compatibility through
> > multiple configurations, as well as requires
> > mandatory support for BADD (Basic Audio Device
> > Definition) on each ADC3.0 compliant device
> > 
> > This patch adds initial support of UAC3 specification
> > that is enough for Generic I/O Profile (BAOF, BAIF)
> > device support from BADD document.
> > 
> > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> 
> Most code changes look fairly straightforward, and not breaking the
> UAC1/UAC2 stuff.  So the stuff is good enough through a quick glance.
> 
> I suppose it's better to merge via sound git tree.
> Greg, could you check include/linux/usb/* (and uapi) stuff and give an
> ack if it's OK?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
