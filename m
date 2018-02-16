Date: Fri, 16 Feb 2018 20:13:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/45] 3.18.95-stable review
Message-ID: <20180216191350.GB5080@kroah.com>
References: <20180215144115.863307741@linuxfoundation.org>
 <e1b45b6a-87f4-89db-0652-4bb9924d5b56@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1b45b6a-87f4-89db-0652-4bb9924d5b56@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 06:11:44AM -0800, Guenter Roeck wrote:
> On 02/15/2018 07:16 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.95 release.
> > There are 45 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb 17 14:40:54 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 136 pass: 135 fail: 1
> Failed builds:
> 	arm:axm55xx_defconfig
> Qemu test results:
> 	total: 112 pass: 112 fail: 0
> 
> Build failure:
> 
> Building arm:axm55xx_defconfig ... failed
> --------------
> Error log:
> arch/arm/kvm/handle_exit.c: In function 'handle_hvc':
> arch/arm/kvm/handle_exit.c:48:3: error: implicit declaration of function 'vcpu_set_reg'

Oops, I backported an arm kvm patch too far back, sorry about that.
I'll go drop that patch now.

greg k-h
