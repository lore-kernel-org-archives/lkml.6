Date: Thu, 8 Mar 2018 17:09:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: "kernelci.org bot" <bot@kernelci.org>, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org, kernelci@free-electrons.com
Subject: Re: [PATCH 4.14 000/110] 4.14.25-stable review
Message-ID: <20180309010913.GA24548@kroah.com>
References: <20180307191039.748351103@linuxfoundation.org>
 <5aa0b9c4.f8aedf0a.117e1.748d@mx.google.com>
 <7h4llqf70y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7h4llqf70y.fsf@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 04:05:01PM -0800, Kevin Hilman wrote:
> kernelci.org bot <bot@kernelci.org> writes:
> 
> > stable-rc/linux-4.14.y boot: 148 boots: 4 failed, 133 passed with 7 offline, 3 untried/unknown, 1 conflict (v4.14.24-111-g66060ac1dfa0)
> >
> > Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
> > Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.14.y/kernel/v4.14.24-111-g66060ac1dfa0/
> >
> > Tree: stable-rc
> > Branch: linux-4.14.y
> > Git Describe: v4.14.24-111-g66060ac1dfa0
> > Git Commit: 66060ac1dfa02f02646a55f6ed888c0f2001623e
> > Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > Tested: 76 unique boards, 23 SoC families, 17 builds out of 182
> 
> TL;DR; All is well.
> 
> > Boot Regressions Detected:
> >
> > arm:
> >
> >     davinci_all_defconfig:
> >         da850-evm:
> >             lab-baylibre-seattle: failing since 1 day (last pass: v4.14.4-76-gf91a57b206e0 - first fail: v4.14.24)
> 
> Operator error in my lab.
> 
> >     multi_v7_defconfig:
> >         armada-375-db:
> >             lab-free-electrons: new failure (last pass: v4.14.24)
> >         sun8i-h3-orangepi-pc:
> >             lab-free-electrons: failing since 1 day (last pass: v4.14.18-23-g8d861f5b27b0 - first fail: v4.14.24)
> >
> >     sunxi_defconfig:
> >         sun8i-h3-orangepi-pc:
> >             lab-free-electrons: failing since 5 days (last pass: v4.14.18-23-g8d861f5b27b0 - first fail: v4.14.23-116-g0ae11358b0bd)
> 
> These three are also not kernel issues.  Seems the lab having problems
> connecting to the boards.  Cc'd Free Electrons team for closer look.

Thanks for letting me know, much appreciated.

greg k-h
