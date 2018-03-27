Date: Tue, 27 Mar 2018 09:05:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 3.18.102
Message-ID: <20180327070528.GB31193@kroah.com>
References: <CGME20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1@epcas1p2.samsung.com>
 <20180325085952.GA31575@kroah.com>
 <5AB9A111.1080105@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AB9A111.1080105@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:40:33AM +0900, Seung-Woo Kim wrote:
> Hello,
> 
> Until 3.18.102, it looks like following patch series for v4l2 seems missed.
> 
> 273caa2 media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
> a1dfb4c media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic
> d83a824 media: v4l2-compat-ioctl32.c: don't copy back the result for
> certain errors
> 169f24c media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
> a751be5 media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
> b8c601e media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
> 8ed5a59 media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
> 333b1e9 media: v4l2-compat-ioctl32.c: avoid sizeof(type)
> 486c521 media: v4l2-compat-ioctl32.c: move 'helper' functions to
> __get/put_v4l2_format32
> b7b957d media: v4l2-compat-ioctl32.c: fix the indentation
> 3ee6d04 media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
> 181a4a2 media: v4l2-ioctl.c: don't copy back the result for -ENOTTY

That is correct.

> Any plan to apply the series?

Do you have a backported version of this series that will apply to that
kernel tree?  If so, I'll be glad to apply it but I'm pretty sure the
reason I did not apply them was because they did not apply correctly.

Also, are you even sure you need these patches for 3.18.y?  Do you have
a v4l2 device that relies on these fixes?

thanks,

greg k-h
