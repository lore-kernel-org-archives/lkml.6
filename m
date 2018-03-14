Date: Wed, 14 Mar 2018 17:33:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 41/47] serial: remove blackfin drivers
Message-ID: <20180314163315.GG4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-42-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-42-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:54PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so both the bfin_uart
> and bfin_sport_uart can be removed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/Kconfig           |  149 ----
>  drivers/tty/serial/Makefile          |    2 -
>  drivers/tty/serial/bfin_sport_uart.c |  937 --------------------
>  drivers/tty/serial/bfin_sport_uart.h |   86 --
>  drivers/tty/serial/bfin_uart.c       | 1551 ----------------------------------
>  5 files changed, 2725 deletions(-)
>  delete mode 100644 drivers/tty/serial/bfin_sport_uart.c
>  delete mode 100644 drivers/tty/serial/bfin_sport_uart.h
>  delete mode 100644 drivers/tty/serial/bfin_uart.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
