Date: Tue, 20 Mar 2018 10:12:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] phy: for 4.17
Message-ID: <20180320091243.GA4140@kroah.com>
References: <20180320083426.25404-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320083426.25404-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 02:04:26PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 4.17 merge window below.
> 
> This adds 5 new phy drivers (mostly USB) apart from adding support for
> 3 PHYs in existing PHY drivers. This also adds USB speed related PHY
> modes in PHY core like PHY_MODE_USB_HOST_LS, PHY_MODE_USB_HOST_FS etc.,
> in order for the USB controller driver to be able to use set_mode ops
> to indicate the enumerated speed modes. This is apparently required
> to enable appropriate DP/DM wakeup interrupts polarity in suspend state
> in Qualcomm SoC. For the detailed list of changes, please see the tag
> message below.
> 
> Let me know If I have to make any changes.
> 
> Thanks
> Kishon
> 
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-4.17

Pulled in now, thanks.

greg k-h
