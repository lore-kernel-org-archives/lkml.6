Date: Wed, 14 Mar 2018 17:33:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 39/47] usb: isp1362: remove blackfin arch glue
Message-ID: <20180314163329.GI4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-40-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-40-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:35:52PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, and this is the last
> remaining architecture specific setting, so the various hacks
> can be removed now.
> 
> >From all I can tell, there are no remaining in-tree users of the
> driver, but it could be used by out-of-tree platform ports.
> I've marked the driver as 'depends on COMPILE_TEST', short of
> removing it outright.
> 
> It was originally written for some ARM PXA machines using the same
> chip, but that platform never really worked and the code has been
> removed a long time ago.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/host/Kconfig   |  1 +
>  drivers/usb/host/isp1362.h | 44 --------------------------------------------
>  2 files changed, 1 insertion(+), 44 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
