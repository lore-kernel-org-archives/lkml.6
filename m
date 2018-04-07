Date: Sat, 7 Apr 2018 19:54:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.16 00/31] 4.16.1-stable review
Message-ID: <20180407175427.GA23053@kroah.com>
References: <20180406084340.999820380@linuxfoundation.org>
 <CA+G9fYsbMhN_h8d7QGpEXwG9RZRg0otP9DZHfO8CtQo2tv4Vag@mail.gmail.com>
 <20180407122815.GA2399@kroah.com>
 <CA+G9fYvim=o4cc0PtM1UMKznThkX0C7RqVr370GiK8J7Bb9ceg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvim=o4cc0PtM1UMKznThkX0C7RqVr370GiK8J7Bb9ceg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 10:37:33PM +0530, Naresh Kamboju wrote:
> >> Results from Linaro’s test farm.
> >> No regressions on arm64, arm and x86_64.
> >>
> >> Summary
> >> ------------------------------------------------------------------------
> >>
> >> kernel: 4.16.1-rc1
> >> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >> git branch: linux-4.16.y
> >> git commit: 30380aa579224caf6a737160802151f466fe3953
> >> git describe: v4.16-32-g30380aa57922
> >> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/build/v4.16-32-g30380aa57922
> >>
> >> No regressions (compared to build )
> >
> > Compared to what build?  :)
> 
> There is no previous build to compare.
> stable-rc 4.16 is the new build in our system.
> This build results will act as base line for coming up 4.16 builds.

Why were you all not testing 4.16-rc releases and the final 4.16.0
release?  For some reason I thought you all were doing that.

thanks,

greg k-h
