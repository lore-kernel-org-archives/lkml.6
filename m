Date: Tue, 20 Mar 2018 09:12:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] thunderbolt: Changes for v4.17 merge window
Message-ID: <20180320081225.GA12683@kroah.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:26:44PM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> Here are Thunderbolt changes for v4.17 merge window as a patch series and
> there is also a signed tag that you may choose pull directly.
> 
> New features:
> 
>   - Intel Titan Ridge Thunderbolt 3 controller support
>   - Preboot ACL supported, allowing more secure way to boot from
>     Thunderbolt devices
>   - New "USB only" security level
> 
> In addition there are a couple of fixes for increasing timeout when
> authenticating the ICM firmware and reading root switch config space.
> Preventing a crash on certain Lenovo systems where ICM firmware for some
> reason is not always properly starting up.
> 
> Thanks!
> 
> The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:
> 
>   Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v4.17

Thanks, all pulled in now.

greg k-h
