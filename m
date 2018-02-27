Date: Tue, 27 Feb 2018 14:10:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	shuahkh@osg.samsung.com, stable@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/13] 3.18.97-stable review
Message-ID: <20180227131021.GF32493@kroah.com>
References: <20180226201527.242286068@linuxfoundation.org>
 <CALpmF+F8D=BpTP+Z3Vh+6JTLR+y07bDQ+jEtOo+OoQ37D=k65Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+F8D=BpTP+Z3Vh+6JTLR+y07bDQ+jEtOo+OoQ37D=k65Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 02:17:15AM +0000, Harsh Shandilya wrote:
> On Tue 27 Feb, 2018, 1:47 AM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
> wrote:
> 
> > This is the start of the stable review cycle for the 3.18.97 release.
> > There are 13 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Feb 28 20:15:12 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >
> > https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.97-rc1.gz
> > or in the git tree and branch at:
> >         git://
> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-3.18.y
> > and the diffstat can be found below.
> >
> 
> No regressions noticed on the OnePlus 3T. CAF's msm-3.18 tree requires
> reverting commit
> https://source.codeaurora.org/quic/la/kernel/msm-3.18/commit?id=1278f001ef9bf1329bc2aa123f6038ad9f8a65ee
> to avoid conflicting with the patch titled "usb: gadget: f_fs: Process all
> descriptors during bind", kernel-common has no merge problems. Thanks for
> the update.

Thanks for testing this and letting me know.

greg k-h
