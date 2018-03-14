Date: Wed, 14 Mar 2018 17:33:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 37/47] usb: host: remove tilegx platform glue
Message-ID: <20180314163344.GK4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-38-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-38-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:50PM +0100, Arnd Bergmann wrote:
> The tile architecture is getting removed, so the ehci and ohci platform
> glue drivers are no longer needed. In case of ohci, this is the last
> one to define a PLATFORM_DRIVER macro, so we can remove even more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/host/ehci-hcd.c    |   5 -
>  drivers/usb/host/ehci-tilegx.c | 207 -----------------------------------------
>  drivers/usb/host/ohci-hcd.c    |  18 ----
>  drivers/usb/host/ohci-tilegx.c | 196 --------------------------------------
>  include/linux/usb/tilegx.h     |  35 -------
>  5 files changed, 461 deletions(-)
>  delete mode 100644 drivers/usb/host/ehci-tilegx.c
>  delete mode 100644 drivers/usb/host/ohci-tilegx.c
>  delete mode 100644 include/linux/usb/tilegx.h

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
