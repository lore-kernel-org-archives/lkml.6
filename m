Date: Thu, 8 Mar 2018 09:27:23 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
Message-ID: <20180308172723.GC22996@kroah.com>
References: <20180307191729.190879024@linuxfoundation.org>
 <20180308103539.GA3409@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308103539.GA3409@calabresa>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 07:35:41AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Wed, Mar 07, 2018 at 11:36:52AM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.8 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> 
> Merged, built on amd64, arm64, armhf, i386, ppc64el, s390x.

What do you mean by "merged"?

And what are the results of the builds, do you boot them as well?  If
you boot, are you running any tests on them?  Is this QEMU only or "real
hardware"?

thanks,

greg k-h
