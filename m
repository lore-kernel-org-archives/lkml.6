Date: Fri, 4 May 2018 10:37:09 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver-core: Return EBUSY error instead of BUG_ON()
Message-ID: <20180504173709.GC4649@kroah.com>
References: <20180307094902.20316-1-flo@geekplace.eu>
 <20180504132357.31771-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504132357.31771-1-flo@geekplace.eu>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 03:23:57PM +0200, Florian Schmaus wrote:
> I triggerd the BUG_ON() in driver_register(), which was added in
> f48f3febb2cbfd0f2ecee7690835ba745c1034a4, when booting a domU Xen
> domain. Since there was no contextual information logged, I needed to
> attach kgdb to determine the culprit (the wmi-bmof driver in my case).
> 
> Instead of running into a BUG_ON() we print an error message
> identifying the driver but continue booting.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>  drivers/base/driver.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

What changed from v1?  Always put that below the --- line.

Also, it's best to quote commits with the following format:
	f48f3febb2cb ("driver-core: do not register a driver with bus_type not registered")

v3?

thanks,

greg k-h
