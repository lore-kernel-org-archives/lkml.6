Date: Thu, 8 Mar 2018 09:51:33 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
Message-ID: <20180308175133.GA28889@kroah.com>
References: <20180307191729.190879024@linuxfoundation.org>
 <20180308103539.GA3409@calabresa>
 <20180308172723.GC22996@kroah.com>
 <20180308174202.GB3303@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308174202.GB3303@calabresa>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 02:42:03PM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Mar 08, 2018 at 09:27:23AM -0800, Greg Kroah-Hartman wrote:
> > On Thu, Mar 08, 2018 at 07:35:41AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > On Wed, Mar 07, 2018 at 11:36:52AM -0800, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.15.8 release.
> > > > There are 122 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.8-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > > -------------
> > > 
> > > Merged, built on amd64, arm64, armhf, i386, ppc64el, s390x.
> > 
> > What do you mean by "merged"?
> 
> That I merged it with Ubuntu changes as in
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/bionic.

Ah, that makes sense, testing the sum is a good idea.  And I want to
know that type of result, thanks.  I get that type of report from other
companies as well, and it's nice to see the testing spread to more,
thanks.

> > And what are the results of the builds, do you boot them as well?  If
> 
> All builds succeeded. I was planning on reporting it if they failed, but
> thought it would be useful to report that they succeeded just as well.

Sure, that's valid, just want to know what you are reporting :)

> > you boot, are you running any tests on them?  Is this QEMU only or "real
> > hardware"?
> > 
> 
> We run tests on some (mostly virtual) machines for those different
> architectures before they (the Ubuntu kernels) are released, but not on this
> phase. In fact, we only merge them or do any build testing after they (your
> stable releases) are tagged and pushed.
> 
> By my own account, I decided I would contribute somehow doing those build
> tests, but might push for those tests to be run earlier, so we can report back
> its results, if you find it would be useful.

I would, thanks.  Look at how the Linaro results are displayed as an
example (maybe a bad one, it's a messy report) about what actually runs
and what is testing, to make it a bit more obvious as to what is going
on for anyone who might be curious.

thanks again for doing this, much appreciated.

greg k-h
