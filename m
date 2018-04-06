Date: Fri, 6 Apr 2018 15:18:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel+linux-input@molgen.mpg.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-input@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ben Caradoc-Davies <ben@transient.nz>
Subject: Re: Commit *driver core: emit uevents when device is bound to a
 driver* causes regression
Message-ID: <20180406131820.GA4555@kroah.com>
References: <8d22cfe6-90b6-eb86-d82e-0e037bfbed4e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d22cfe6-90b6-eb86-d82e-0e037bfbed4e@molgen.mpg.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 02:20:40PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Commit 1455cf8 (driver core: emit uevents when device is bound to a
> driver) [1], introduced in Linux 4.14-rc1, causes a regression in user
> space.
> 
> After disconnecting USB devices, they are still shown as plugged in [2][3].
> 
> > I seem to be having a similar issue, but with an iPhone X using USB
> > to provide internet access. Even after the phone is disconnected, it
> > still shows up as "loaded active plugged". The only way to fix this
> > is to reboot or use a different USB port.
> 
> `git bisect` shows that commit 1455cf8 (driver core: emit uevents when
> device is bound to a driver) is at fault [4].
> 
> As user space should not break with newer Linux kernels, do you know what to
> do about that or can you think of a fix?

I thought we fixed this with follow-on patches, are you sure you are
using the latest 4.14.y kernel that has been released?

thanks,

greg k-h
