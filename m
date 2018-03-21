Date: Wed, 21 Mar 2018 14:31:54 +0100
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
Message-ID: <20180321133154.GA21153@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org>
 <20180320074945.GA10034@kroah.com>
 <CA+G9fYuVfSjGRu+w4knc=cAZ-aocdpezKRbBxt1cGuZLzridAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuVfSjGRu+w4knc=cAZ-aocdpezKRbBxt1cGuZLzridAw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 08:40:26PM +0800, Naresh Kamboju wrote:
> On 20 March 2018 at 15:49, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 4.9.89 release.
> >> There are 241 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc1.gz
> >> or in the git tree and branch at:
> >>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> >> and the diffstat can be found below.
> >
> > -rc2 is out to fix a bunch of arm32 build errors:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.89-rc2.gz
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Thanks for testing and letting me know.

greg k-h
