Date: Wed, 14 Mar 2018 17:34:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/47] char: remove tile-srom.c
Message-ID: <20180314163400.GM4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-12-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-12-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:24PM +0100, Arnd Bergmann wrote:
> The tile architecture is being removed, so we no longer need this driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/Kconfig     |  11 --
>  drivers/char/Makefile    |   1 -
>  drivers/char/tile-srom.c | 475 -----------------------------------------------
>  3 files changed, 487 deletions(-)
>  delete mode 100644 drivers/char/tile-srom.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
