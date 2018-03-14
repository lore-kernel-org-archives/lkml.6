Date: Wed, 14 Mar 2018 17:32:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 43/47] serial: remove tile uart driver
Message-ID: <20180314163257.GE4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-44-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-44-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:56PM +0100, Arnd Bergmann wrote:
> The tile architecture is getting removed, and this driver is
> useless without it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/Kconfig  |   9 -
>  drivers/tty/serial/Makefile |   1 -
>  drivers/tty/serial/tilegx.c | 689 --------------------------------------------
>  3 files changed, 699 deletions(-)
>  delete mode 100644 drivers/tty/serial/tilegx.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
