Date: Wed, 14 Mar 2018 17:32:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 45/47] tty: hvc: remove tile driver
Message-ID: <20180314163243.GC4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-46-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-46-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:58PM +0100, Arnd Bergmann wrote:
> The Tile architecture is obsolete and getting removed from the kernel,
> this removes the corresponding console driver as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/hvc/Makefile   |   1 -
>  drivers/tty/hvc/hvc_tile.c | 196 ---------------------------------------------
>  2 files changed, 197 deletions(-)
>  delete mode 100644 drivers/tty/hvc/hvc_tile.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
