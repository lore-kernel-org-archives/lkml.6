Date: Thu, 22 Mar 2018 09:21:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
Message-ID: <20180322082123.GE30498@kroah.com>
References: <20180319171827.899658615@linuxfoundation.org>
 <20180321110405.GD24810@kroah.com>
 <20180321174711.GC6008@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321174711.GC6008@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 10:47:11AM -0700, Guenter Roeck wrote:
> On Wed, Mar 21, 2018 at 12:04:05PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 19, 2018 at 07:05:38PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 3.18.101 release.
> > > There are 68 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> > > and the diffstat can be found below.
> > 
> > -rc2 is out to fix a build problem with -rc1:
> >  	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc2.gz
> > 
> 
> For v3.18.100-67-g5a9e460:
> 
> Build results:
> 	total: 137 pass: 137 fail: 0
> Qemu test results:
> 	total: 119 pass: 117 fail: 2
> Failed tests: 
> 	powerpc:mpc8544ds:mpc85xx_defconfig 
> 	powerpc:mpc8544ds:mpc85xx_smp_defconfig
> 
> drivers/mtd/nand/fsl_ifc_nand.c: In function 'fsl_ifc_chip_init':
> drivers/mtd/nand/fsl_ifc_nand.c:995:10: error: 'struct fsl_ifc_ctrl' has no member named 'version'
> drivers/mtd/nand/fsl_ifc_nand.c:995:23: error: 'FSL_IFC_VERSION_2_0_0' undeclared

Patch causing this is now dropped, thanks.

greg k-h
