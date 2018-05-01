Date: Tue, 1 May 2018 08:03:00 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/44] 4.4.131-stable review
Message-ID: <20180501150300.GF14123@kroah.com>
References: <20180430190946.093694747@linuxfoundation.org>
 <20180430235504.GA4711@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430235504.GA4711@flashbox>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 04:55:04PM -0700, Nathan Chancellor wrote:
> On Mon, Apr 30, 2018 at 12:24:11PM -0700, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.131 release.
> > There are 44 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed May  2 19:09:34 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.131-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and installed onto my Pixel 2 XL and OnePlus 5.
> 
> No build warnings from GCC 4.9.4, GCC 7.3.0, and Clang 5 through 7.
> 
> No initial issues in dmesg or general usage.

Thanks for testing the two of these and letting me know.

greg k-h
