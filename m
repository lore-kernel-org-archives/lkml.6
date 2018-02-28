Date: Wed, 28 Feb 2018 16:26:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Thomas Winischhofer <thomas@winischhofer.net>,
	linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] console: Expand dummy functions for CFI
Message-ID: <20180228152641.GA16045@kroah.com>
References: <CGME20180227000432epcas2p1408299421426381f05a548283953b064@epcas2p1.samsung.com>
 <1519689860-7421-1-git-send-email-keescook@chromium.org>
 <1712993.EvPlpO244k@amdc3058>
 <2698133.VOZeH6rfJt@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2698133.VOZeH6rfJt@amdc3058>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 04:14:38PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, February 28, 2018 04:09:47 PM Bartlomiej Zolnierkiewicz wrote:
> > On Monday, February 26, 2018 04:04:17 PM Kees Cook wrote:
> > > This is a small series that cleans up struct consw a bit and
> > > prepares it for Control Flow Integrity checking (i.e. Clang's
> > > -fsanitize=cfi).
> > 
> > for drivers/video/ parts:
> > 
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> also I'll be happy to merge all patches through fbdev tree
> (if Greg is fine with it and ACKs drivers/usb/ parts)

I've already taken this through the tty tree, sorry about that.
Shouldn't cause any merge issues.

greg k-h
