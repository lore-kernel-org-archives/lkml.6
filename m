Date: Thu, 8 Mar 2018 09:27:46 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Shuah Khan <shuahkh@osg.samsung.com>, lkft-triage@lists.linaro.org,
	patches@kernelci.org, linux- stable <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
Message-ID: <20180308172746.GD22996@kroah.com>
References: <20180307191729.190879024@linuxfoundation.org>
 <CA+G9fYvm-xDT-B0TgGX4R7V5pmO5J6ZUZ8SbaxtAc+YP+fCjSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvm-xDT-B0TgGX4R7V5pmO5J6ZUZ8SbaxtAc+YP+fCjSw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 12:42:05PM +0530, Naresh Kamboju wrote:
> On 8 March 2018 at 01:06, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.15.8 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
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
> qemu_x86_64 LTP syscalls and fs tests failed (due to infrastructure issues) have
> been resubmitted and updated results summary.

Thanks for testing both of these and letting me know.

greg k-h
