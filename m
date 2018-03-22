Date: Thu, 22 Mar 2018 10:01:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [usb-next, v2 PATCH] usb: xhci: skip phys initialization of
 shared hcd
Message-ID: <20180322090127.GA12048@kroah.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 04:39:20PM +0800, Chunfeng Yun wrote:
> The phys has already been initialized when add primary hcd,
> including usb2 phys and usb3 phys also if exist, so needn't
> re-parse "phys" property again.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/core/hcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What changed from version 1?

Always put that below the --- line like the kernel documentation asks
you to do.

v3?

thanks,

greg k-h
