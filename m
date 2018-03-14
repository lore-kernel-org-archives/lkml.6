Date: Wed, 14 Mar 2018 17:34:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/47] char: remove obsolete ds1302 rtc driver
Message-ID: <20180314163406.GN4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-11-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-11-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:23PM +0100, Arnd Bergmann wrote:
> The m32r architecture was the only user of the old-style
> rtc driver for ds1302. The architecture is getting removed
> now, and we have a modern driver for the same hardware in
> drivers/rtc/rtc-ds1302.c, so this one won't be missed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/Kconfig  |   9 --
>  drivers/char/Makefile |   1 -
>  drivers/char/ds1302.c | 357 --------------------------------------------------
>  3 files changed, 367 deletions(-)
>  delete mode 100644 drivers/char/ds1302.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
