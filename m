Date: Thu, 22 Mar 2018 09:17:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180322081756.GA30498@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org>
 <20180320074945.GA10034@kroah.com>
 <20180321132005.GB27151@kroah.com>
 <20180321173605.GA6008@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321173605.GA6008@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:36:05AM -0700, Guenter Roeck wrote:
> On Wed, Mar 21, 2018 at 02:20:05PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 20, 2018 at 08:49:45AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.89 release.
> > > > There are 241 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > > > and the diffstat can be found below.
> > > 
> > > -rc2 is out to fix a bunch of arm32 build errors:
> > >  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc2.gz
> > > 
> > 
> > And -rc3 is out to fix some more arm32 build errors, as well as an x86
> > one I noticed showed up in the build tests:
> >   	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc3.gz
> > 
> 
> For v4.9.88-238-g369cbfd:
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 137 pass: 137 fail: 0

Yeah, finally!  :)

thanks for the testing, much appreciated.

greg k-h
