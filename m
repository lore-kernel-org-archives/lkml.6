Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeC2KY0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:24:26 -0400
Received: from 8bytes.org ([81.169.241.247]:45710 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeC2KYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:24:24 -0400
Date: Thu, 29 Mar 2018 12:24:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, jcliang@chromium.org,
        robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org,
        Romain Perier <romain.perier@collabora.com>,
        Yakir Yang <kuankuan.y@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Liang Chen <cl@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Wu <david.wu@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, Jacob Chen <jacob-chen@iotwrt.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rocky Hao <rocky.hao@rock-chips.com>,
        Will Deacon <will.deacon@arm.com>,
        Nickey Yang <nickey.yang@rock-chips.com>, devicetree@vger.kernel.org,
        Mark Yao <markyao0591@gmail.com>, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        iommu@lists.linux-foundation.org, Caesar Wang <wxt@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 00/14] iommu/rockchip: Use OF_IOMMU
Message-ID: <20180329102422.GG11365@8bytes.org>
References: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323073814.5802-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 03:38:00PM +0800, Jeffy Chen wrote:
> 
> This series fixes some issues in rockchip iommu driver, and add of_iommu
> support in it.
> 
> Changes in v8:
> Rebase on newest for-next.
> Don't introduce the additional return.
> Rename startup()/shutdown() to enable()/disable().
> Do runtime PM suspend in .shutdown().
> Modify pm_runtime_get_if_in_use()/pm_runtime_put() as Tomasz suggested.

Applied, thanks.
