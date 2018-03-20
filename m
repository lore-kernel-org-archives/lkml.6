Date: Tue, 20 Mar 2018 12:28:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	johan@kernel.org, richard.leitner@skidata.com,
	felipe.balbi@linux.intel.com
Subject: Re: [PATCH v2] USB: misc: uss720: more vendor/product ID's
Message-ID: <20180320112803.GA21216@kroah.com>
References: <20180320093759.GA22605@kroah.com>
 <1521543527-12914-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521543527-12914-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 03:58:47AM -0700, Daniel Gimpelevich wrote:
> Reporting two more VID/PID pairs that work with this driver, having used
> an informational webpage <http://reboots.g-cipher.net/lcd/> as a buying
> guide now. The page listed additional working VID/PID pairs but did not
> include these two. None were upstreamed. Also taking this opportunity to
> sort the pairs numerically.
> 
> Of the two such cables now in my possession, one is white, bearing the
> In-System Design ISD-103 label on one side, sold as an Epson CAEUL0002
> "USB to Parallel Smart Cable For Apple Macintosh Computers" (04b8:0002),
> and the other is black, bearing the In-System Design ISD-101 label on one
> side, sold as an early Belkin F5U002 (05ab:0002).
> 
> Signed-off-by: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
> ---
>  drivers/usb/misc/uss720.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

For the next time, you should put the versioning of the patch below the
--- line, saying what changed in each version, so we remember what is
going on here.

thanks,

greg k-h
