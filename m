Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeEBIwm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbeEBIwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:52:38 -0400
Date: Wed, 2 May 2018 16:52:22 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 50/61] thermal: simplify getting .drvdata
Message-ID: <20180502085221.GH3443@dragon>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419140641.27926-51-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:06:20PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/thermal/rockchip_thermal.c | 8 +++-----
>  drivers/thermal/spear_thermal.c    | 8 +++-----
>  drivers/thermal/zx2967_thermal.c   | 6 ++----
>  3 files changed, 8 insertions(+), 14 deletions(-)

For zx2967_thermal,

Acked-by: Shawn Guo <shawnguo@kernel.org>
