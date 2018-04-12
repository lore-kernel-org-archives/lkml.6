Date: Thu, 12 Apr 2018 14:31:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/190] 4.4.128-stable review
Message-ID: <20180412123111.GA20501@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411205240.GA26799@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411205240.GA26799@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 01:52:40PM -0700, Nathan Chancellor wrote:
> On Wed, Apr 11, 2018 at 08:34:06PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.128 release.
> > There are 190 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Apr 13 18:34:54 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.128-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.
> 
> Ever since switching to Clang on the OP5 back in December, I haven't
> been compiling with GCC at all which was a mistake. So I have started
> compiling with Google's GCC 4.9.4, Bootlin's GCC 7.3.0, Google's Clang
> 5.0, and my own Clang 6.0 and 7.0. All builds completed successfully
> with -Werror.
> 
> No initial issues in dmesg or general usage.

Great! Thanks for testing and letting me know.

greg k-h
