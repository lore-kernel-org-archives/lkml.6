Date: Wed, 14 Mar 2018 17:33:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Bin Liu <b-liu@ti.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 38/47] usb: musb: remove blackfin port
Message-ID: <20180314163337.GJ4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-39-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-39-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:51PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so we can clean up
> all the special cases in the musb driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/musb/Kconfig        |  10 +-
>  drivers/usb/musb/Makefile       |   1 -
>  drivers/usb/musb/blackfin.c     | 623 ----------------------------------------
>  drivers/usb/musb/blackfin.h     |  81 ------
>  drivers/usb/musb/musb_core.c    |   5 -
>  drivers/usb/musb/musb_core.h    |  30 --
>  drivers/usb/musb/musb_debugfs.c |   2 -
>  drivers/usb/musb/musb_dma.h     |  11 -
>  drivers/usb/musb/musb_gadget.c  |  35 ---
>  drivers/usb/musb/musb_regs.h    | 182 ------------
>  drivers/usb/musb/musbhsdma.c    |   5 -
>  drivers/usb/musb/musbhsdma.h    |  64 -----
>  include/linux/usb/musb.h        |   7 -
>  13 files changed, 1 insertion(+), 1055 deletions(-)
>  delete mode 100644 drivers/usb/musb/blackfin.c
>  delete mode 100644 drivers/usb/musb/blackfin.h

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
