Date: Wed, 14 Mar 2018 17:33:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 40/47] serial: remove cris/etrax uart drivers
Message-ID: <20180314163322.GH4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-41-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-41-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:53PM +0100, Arnd Bergmann wrote:
> The cris architecture is getting removed, so we don't need the
> uart driver any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../bindings/serial/axis,etraxfs-uart.txt          |   22 -
>  drivers/tty/serial/Kconfig                         |   11 -
>  drivers/tty/serial/Makefile                        |    2 -
>  drivers/tty/serial/crisv10.c                       | 4248 --------------------
>  drivers/tty/serial/crisv10.h                       |  133 -
>  drivers/tty/serial/etraxfs-uart.c                  |  960 -----
>  6 files changed, 5376 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
>  delete mode 100644 drivers/tty/serial/crisv10.c
>  delete mode 100644 drivers/tty/serial/crisv10.h
>  delete mode 100644 drivers/tty/serial/etraxfs-uart.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
