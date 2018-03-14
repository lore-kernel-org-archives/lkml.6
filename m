Date: Wed, 14 Mar 2018 17:32:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 44/47] tty: remove bfin_jtag_comm and hvc_bfin_jtag
 drivers
Message-ID: <20180314163250.GD4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-45-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-45-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:57PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so these drivers
> are not needed any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/Kconfig             |  13 --
>  drivers/tty/Makefile            |   1 -
>  drivers/tty/bfin_jtag_comm.c    | 353 ----------------------------------------
>  drivers/tty/hvc/Kconfig         |   9 -
>  drivers/tty/hvc/Makefile        |   1 -
>  drivers/tty/hvc/hvc_bfin_jtag.c | 104 ------------
>  6 files changed, 481 deletions(-)
>  delete mode 100644 drivers/tty/bfin_jtag_comm.c
>  delete mode 100644 drivers/tty/hvc/hvc_bfin_jtag.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
