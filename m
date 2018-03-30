Date: Fri, 30 Mar 2018 11:08:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Shuah Khan <shuahkh@osg.samsung.com>, lkft-triage@lists.linaro.org,
	patches@kernelci.org, linux- stable <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.15 00/47] 4.15.15-stable review
Message-ID: <20180330090801.GC13125@kroah.com>
References: <20180329175729.225211114@linuxfoundation.org>
 <CA+G9fYtMMOerU8sbKuxM=mNnq-ZDEwSbmTZTQ=ukPKEsD0qY4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtMMOerU8sbKuxM=mNnq-ZDEwSbmTZTQ=ukPKEsD0qY4A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 01:41:30PM +0530, Naresh Kamboju wrote:
> On 29 March 2018 at 23:29, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.15.15 release.
> > There are 47 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Mar 31 17:57:05 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.15-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> NOTE:
> LTP test case clock_nanosleep02 is an intermittent failure on qemu_x86_64.
> libhugetlbfs truncate_above_4GB-2M-32 is still fails on arm32 x15 device.

Thanks for testing these and letting me know.

greg k-h
