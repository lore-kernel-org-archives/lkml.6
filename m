Date: Wed, 14 Mar 2018 11:51:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>,
	Daniel Vacek <neelx@redhat.com>
Subject: Re: [PATCH 4.15 000/146] 4.15.10-stable review
Message-ID: <20180314105133.GD32615@kroah.com>
References: <20180313152320.439085687@linuxfoundation.org>
 <CA+G9fYspDG9qukkn__sLVpsWkXDhwQ-sOLn6p7R_G0E4xa4vFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYspDG9qukkn__sLVpsWkXDhwQ-sOLn6p7R_G0E4xa4vFA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 03:50:56PM +0530, Naresh Kamboju wrote:
> On 13 March 2018 at 20:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Daniel Vacek <neelx@redhat.com>
> >     mm/page_alloc: fix memmap_init_zone pageblock alignment
> 
> 
> On 4.14 and 4.15, this patch breaks booting on dragonboard 410c and
> hikey 620 (both arm64). The fix has been proposed and tested but is not
> yet in mainline per https://lkml.org/lkml/2018/3/12/710
> 
> A new fix proposed by Daniel is under review,
> mm/page_alloc: fix boot hang in memmap_init_zone
> https://lkml.org/lkml/2018/3/13/1422

Yeah, I think I'm going to drop this patch now, and add it for the next
round.

And please learn to trim your email context...

thanks,

greg k-h
