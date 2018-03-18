Date: Sun, 18 Mar 2018 12:14:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/109] 4.14.28-stable review
Message-ID: <20180318111442.GA4607@kroah.com>
References: <20180316152329.844663293@linuxfoundation.org>
 <20180318102454.GB30164@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318102454.GB30164@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 11:24:54AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 16, 2018 at 04:22:29PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.28 release.
> > There are 109 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 18 15:22:53 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> 
> -rc2 is out to fix a build problem on some configs:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc2.gz

Ok, that sucked, let's try this again...

-rc3 is out, and this time it at least passed _my_ build tests:
  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.28-rc3.gz

thanks,

greg k-h
