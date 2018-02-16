Date: Fri, 16 Feb 2018 11:33:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.15 000/202] 4.15.4-stable review
Message-ID: <20180216103345.GB8867@kroah.com>
References: <20180215151712.768794354@linuxfoundation.org>
 <CA+G9fYtF3woXJ9jLLcyEESZT6VynLrtzcGq0SwCT4YWQZ45VEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtF3woXJ9jLLcyEESZT6VynLrtzcGq0SwCT4YWQZ45VEg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:31:34AM +0530, Naresh Kamboju wrote:
> On 15 February 2018 at 20:45, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.15.4 release.
> > There are 202 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Feb 17 15:16:28 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.4-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Thanks for testing all of these and letting me know.

greg k-h
