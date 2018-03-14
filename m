Date: Wed, 14 Mar 2018 17:33:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 42/47] serial: remove m32r_sio driver
Message-ID: <20180314163308.GF4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-43-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-43-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:55PM +0100, Arnd Bergmann wrote:
> The m32r architecture is getting removed, so we don't need this
> any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/Kconfig        |   29 -
>  drivers/tty/serial/Makefile       |    1 -
>  drivers/tty/serial/m32r_sio.c     | 1053 -------------------------------------
>  drivers/tty/serial/m32r_sio_reg.h |  150 ------
>  4 files changed, 1233 deletions(-)
>  delete mode 100644 drivers/tty/serial/m32r_sio.c
>  delete mode 100644 drivers/tty/serial/m32r_sio_reg.h

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
