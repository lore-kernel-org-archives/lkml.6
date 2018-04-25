Date: Wed, 25 Apr 2018 17:26:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, alexdeucher@gmail.com,
	christian.koenig@amd.com, kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org, hdegoede@redhat.com
Subject: Re: [PATCH 1/9] firmware: some documentation fixes
Message-ID: <20180425152617.GA5058@kroah.com>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-2-andresx7@gmail.com>
 <20180425152526.GA4921@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425152526.GA4921@kroah.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 05:25:26PM +0200, Greg KH wrote:
> On Mon, Apr 23, 2018 at 04:11:57PM -0400, Andres Rodriguez wrote:
> > Including:
> >  - Fixup outdated kernel-doc paths
> >  - Slightly too short title underline
> >  - Some typos
> > 
> > Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> > ---
> >  Documentation/driver-api/firmware/request_firmware.rst | 16 ++++++++--------
> >  drivers/base/firmware_loader/fallback.c                |  4 ++--
> >  drivers/base/firmware_loader/fallback.h                |  2 +-
> >  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> This fails to apply to my driver-core-next branch.  Can you please
> rebase it and resend?

Oops, I meant the driver-core-linus branch, which is where "fixes" would
go at the moment.

thanks,

greg k-h
