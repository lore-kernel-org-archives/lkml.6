Date: Sat, 24 Feb 2018 12:18:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
Message-ID: <20180224111815.GA15637@kroah.com>
References: <20180223170325.997716448@linuxfoundation.org>
 <0ad305e4-e73d-e325-1772-8c771479c73f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad305e4-e73d-e325-1772-8c771479c73f@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 03:11:45AM -0800, Guenter Roeck wrote:
> On 02/23/2018 10:23 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.118 release.
> > There are 193 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 25 17:02:20 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> m68k images in 3.18.96-rc and 4.4.118-rc fail to build with
> 
> m68k-linux-ld: cannot find SOFTIRQENTRY_TEXT
> 
> This is due to 'm68k: add missing SOFTIRQENTRY_TEXT linker section'.
> There is no definition for SOFTIRQENTRY_TEXT in v4.4.y or v3.18.y.

Ugh, I've now dropped this patch from both the 4.4.y and 3.18.y trees,
and pushed out a new git tree.

thanks for catching this,

greg k-h
