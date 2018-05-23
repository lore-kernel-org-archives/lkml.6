Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeEWK5r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:57:47 -0400
Received: from gloria.sntech.de ([95.129.55.99]:43842 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932311AbeEWK5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:57:43 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v3 04/13] soc: rockchip: power-domain: Fix wrong value when power up pd
Date: Wed, 23 May 2018 12:57:38 +0200
Message-ID: <1782209.MGTIqozbO9@diego>
In-Reply-To: <1527058129-10260-5-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com> <1527058129-10260-5-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 23. Mai 2018, 08:48:40 CEST schrieb Elaine Zhang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Solve the pd could only ever turn off but never turn them on again,
> If the pd registers have the writemask bits.
> 
> Fix up the code error for commit:
> 	commit 79bb17ce8edb3141339b5882e372d0ec7346217c
> 	Author: Elaine Zhang <zhangqing@rock-chips.com>
> 	Date:   Fri Dec 23 11:47:52 2016 +0800
> 
> 	soc: rockchip: power-domain: Support domain control in hiword-registers
> 
> 	New Rockchips SoCs may have their power-domain control in registers
> 	using a writemask-based access scheme (upper 16bit being the write
> 	mask). So add a DOMAIN_M type and handle this case accordingly.
> 	Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> 	Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

I've already applied that patch from v2.


Heiko
