Date: Wed, 21 Mar 2018 10:54:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: usb: initial USB Audio Device Class 3.0 support
Message-ID: <20180321095419.GD16947@kroah.com>
References: <1521590639-31383-1-git-send-email-ruslan.bilovol@gmail.com>
 <1521590639-31383-2-git-send-email-ruslan.bilovol@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521590639-31383-2-git-send-email-ruslan.bilovol@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 02:03:59AM +0200, Ruslan Bilovol wrote:
> Recently released USB Audio Class 3.0 specification
> introduces many significant changes comparing to
> previous versions, like
>  - new Power Domains, support for LPM/L1
>  - new Cluster descriptor
>  - changed layout of all class-specific descriptors
>  - new High Capability descriptors
>  - New class-specific String descriptors
>  - new and removed units
>  - additional sources for interrupts
>  - removed Type II Audio Data Formats
>  - ... and many other things (check spec)
> 
> It also provides backward compatibility through
> multiple configurations, as well as requires
> mandatory support for BADD (Basic Audio Device
> Definition) on each ADC3.0 compliant device
> 
> This patch adds initial support of UAC3 specification
> that is enough for Generic I/O Profile (BAOF, BAIF)
> device support from BADD document.
> 
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

Nice work!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
