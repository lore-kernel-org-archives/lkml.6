Date: Sun, 8 Apr 2018 09:19:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: changbin.du@intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fix reST markup error in
 driver-api/usb/typec.rst
Message-ID: <20180408071958.GA7723@kroah.com>
References: <1523155632-10301-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523155632-10301-1-git-send-email-changbin.du@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 10:47:12AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> There is an format error in driver-api/usb/typec.rst that breaks sphinx
> docs building.
> 
> reST markup error:
> /home/changbin/work/linux/Documentation/driver-api/usb/typec.rst:215: (SEVERE/4) Unexpected section title or transition.
> 
> ------------------------
> Documentation/Makefile:68: recipe for target 'htmldocs' failed
> make[1]: *** [htmldocs] Error 1
> Makefile:1527: recipe for target 'htmldocs' failed
> make: *** [htmldocs] Error 2
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  Documentation/driver-api/usb/typec.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, someone else already sent this, sorry.  I'll be sending it
onward after 4.17-rc1 is out.

greg k-h
