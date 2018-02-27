Date: Tue, 27 Feb 2018 19:37:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/64] 4.15.7-stable review
Message-ID: <20180227183745.GG20601@kroah.com>
References: <20180226202153.453363333@linuxfoundation.org>
 <ce53b79c-3881-0998-0ec1-291cd1ed9d3f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce53b79c-3881-0998-0ec1-291cd1ed9d3f@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 06:58:03AM -0800, Guenter Roeck wrote:
> On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.7 release.
> > There are 64 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 28 20:21:30 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 144 fail: 3
> Failed builds:
> 	microblaze:mmu_defconfig
> 	microblaze:nommu_defconfig
> 	microblaze:allnoconfig
> Qemu test results:
> 	total: 127 pass: 127 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

microblaze fix now queued up.

thanks,

greg k-h
