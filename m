Date: Wed, 14 Mar 2018 17:33:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/47] char: remove blackfin OTP driver
Message-ID: <20180314163355.GL4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-13-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-13-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:25PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so we don't
> need this driver any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/Kconfig    |  28 ------
>  drivers/char/Makefile   |   1 -
>  drivers/char/bfin-otp.c | 237 ------------------------------------------------
>  3 files changed, 266 deletions(-)
>  delete mode 100644 drivers/char/bfin-otp.c
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
