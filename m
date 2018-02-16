Date: Fri, 16 Feb 2018 07:51:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/108] 4.4.116-stable review
Message-ID: <20180216065125.GB26224@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180216024508.GA18379@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216024508.GA18379@flashbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 07:45:08PM -0700, Nathan Chancellor wrote:
> On Thu, Feb 15, 2018 at 04:15:57PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.116 release.
> > There are 108 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb 17 15:11:36 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.116-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> >
> 
> Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.
> 
> The v4l2-ioctl32 commits were interesting to sift through merging... I
> think I got everything correct though, the changes are in my trees under
> temporary tags if anyone cares to check them out:
> 
> https://github.com/nathanchance/wahoo/commits/queue-2.17
> https://github.com/nathanchance/op5/commits/queue-3.10

Thanks for that, yes, those are going to be an "interesting" merge :(

> So far, there have been no visible regressions in dmesg or general
> usage (I focused pretty heavily in the video area since those were the
> biggest changes).

thanks for testing and letting us know.

greg k-h
