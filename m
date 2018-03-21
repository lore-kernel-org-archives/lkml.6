Date: Wed, 21 Mar 2018 14:32:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Shuah Khan <shuahkh@osg.samsung.com>, lkft-triage@lists.linaro.org,
	patches@kernelci.org, linux- stable <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.9 00/86] 4.9.88-stable review
Message-ID: <20180321133256.GB21153@kroah.com>
References: <20180316152317.167709497@linuxfoundation.org>
 <CA+G9fYth+j=QNYM-6OBnxncfBruy6W7hXuw-Srt_RMSTqXQ=XQ@mail.gmail.com>
 <20180318102738.GF32470@kroah.com>
 <1521589759.23626.120.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521589759.23626.120.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:49:19PM +0000, Ben Hutchings wrote:
> On Sun, 2018-03-18 at 11:27 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Mar 17, 2018 at 03:48:24PM +0530, Naresh Kamboju wrote:
> [...]
> > > Results from Linaro’s test farm.
> > > No regressions on arm64, arm, qemu_x86_64 and x86_64.
> > > 
> > > NOTE:
> > > CONFIG_LEGACY_VSYSCALL_EMULATE=y is enabled from config as default.
> > > Enabled vsyscall=native and vsyscall=none from kernel command line for testing
> > > selftests/x86/test_vsyscall test case on x86_64 and qemu_x86_64.
> > > 
> > > test_vdso_64 failed on x86_64 device when vsyscall=none is enabled.
> > > We will investigate this new test failure.
> > 
> > I think vsyscall=none just went away :)
> 
> No, vsyscall=native went away upstream.  vsyscall=none should still
> work everywhere.

Ah, sorry, got that wrong, thanks for the correction.

> However, test_vdso_64 isn't able to detect what the current
> configuration is and it will crash with vsyscall=none (or the
> equivalent default in kconfig).

That's good to know.  Naresh, does that help out?

thanks,

greg k-h
