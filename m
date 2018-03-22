Date: Thu, 22 Mar 2018 09:18:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Shuah Khan <shuahkh@osg.samsung.com>, lkft-triage@lists.linaro.org,
	patches@kernelci.org, linux- stable <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
Message-ID: <20180322081809.GB30498@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org>
 <20180320074945.GA10034@kroah.com>
 <20180321132005.GB27151@kroah.com>
 <CA+G9fYvS0TvPOWv-u_ykZnC2X=xoTecLKF4-BNZstv=goA+LFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvS0TvPOWv-u_ykZnC2X=xoTecLKF4-BNZstv=goA+LFg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 11:36:23PM +0530, Naresh Kamboju wrote:
> On 21 March 2018 at 18:50, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Mar 20, 2018 at 08:49:45AM +0100, Greg Kroah-Hartman wrote:
> >> On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> >> > This is the start of the stable review cycle for the 4.9.89 release.
> >> > There are 241 patches in this series, all will be posted as a response
> >> > to this one.  If anyone has any issues with these being applied, please
> >> > let me know.
> >> >
> >> > Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> >> > Anything received after that time might be too late.
> >> >
> >> > The whole patch series can be found in one patch at:
> >> >     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> >> > or in the git tree and branch at:
> >> >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> >> > and the diffstat can be found below.
> >>
> >> -rc2 is out to fix a bunch of arm32 build errors:
> >>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc2.gz
> >>
> >
> > And -rc3 is out to fix some more arm32 build errors, as well as an x86
> > one I noticed showed up in the build tests:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc3.gz
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.9.89-rc3
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.9.y
> git commit: 369cbfd2394b6ea1d767813ffa7fb01f6e5fc68c
> git describe: v4.9.88-238-g369cbfd2394b
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.88-238-g369cbfd2394b
> 
> 
> No regressions (compared to build v4.9.88-239-g393003b009f8)

Great, thanks for testing and letting me know.

greg k-h
