Date: Wed, 4 Apr 2018 17:42:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Laura Abbott <labbott@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	driverdevel <devel@driverdev.osuosl.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
	Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] MAINTAINERS: add dri-devel&linaro-mm for Android ION
Message-ID: <20180404154243.GB31981@kroah.com>
References: <20180404103037.11581-1-daniel.vetter@ffwll.ch>
 <222a21c2-6de0-d8a8-852a-35786af76a5a@redhat.com>
 <20180404143050.GA20964@kroah.com>
 <CAKMK7uGmtoTiYZ0dCjt44E+1HFFCLFdpoVJYS8o2cK6unzAe9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGmtoTiYZ0dCjt44E+1HFFCLFdpoVJYS8o2cK6unzAe9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 05:17:08PM +0200, Daniel Vetter wrote:
> On Wed, Apr 4, 2018 at 4:30 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Wed, Apr 04, 2018 at 07:17:39AM -0700, Laura Abbott wrote:
> >> On 04/04/2018 03:30 AM, Daniel Vetter wrote:
> >> > Most of the other cross-driver gfx infrastructure (dma_buf, dma_fence)
> >> > also gets cross posted to all the relevant gfx/memory lists. Doing the
> >> > same for ION means people won't miss relevant patches.
> >> >
> >>
> >> No problem from me, the rate of checkpatch fixups should be
> >> small these days.
> >>
> >> Acked-by: Laura Abbott <labbott@redhat.com>
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Greg, can you pls stuff this into your staging queue? Imo makes most
> sense there.

Ok, but that will have to wait until after 4.17-rc1 is out as my pull
request for 4.17-rc1 is already sent to Linus.

thanks,

greg k-h
