Date: Mon, 30 Apr 2018 03:59:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	thomas.petazzoni@free-electrons.com,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/6] staging/fbtft: Stop using BL_CORE_DRIVER1
Message-ID: <20180430105957.GA15339@kroah.com>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
 <20180425174253.4616-4-daniel.vetter@ffwll.ch>
 <20180430095415.GB5147@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430095415.GB5147@dell>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 10:54:15AM +0100, Lee Jones wrote:
> Greg, Thomas,
> 
> On Wed, 25 Apr 2018, Daniel Vetter wrote:
> > Leaking driver internal tracking into the already massively confusing
> > backlight power tracking is really confusing.
> > 
> > Luckily we have already a drvdata structure, so fixing this is really
> > easy.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  drivers/staging/fbtft/fbtft-core.c | 4 ++--
> >  drivers/staging/fbtft/fbtft.h      | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> Do you want a pull-request for this patch or can I just take it?

Please take it if you need to take the whole series.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
