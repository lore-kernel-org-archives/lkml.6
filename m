Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeBQAKf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 19:10:35 -0500
Received: from gloria.sntech.de ([95.129.55.99]:52370 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeBQAKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 19:10:34 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>, dianders@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, William wu <wulf@rock-chips.com>,
        hl@rock-chips.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 5/6] phy: rockchip-typec: support DP phy switch
Date: Sat, 17 Feb 2018 01:10:27 +0100
Message-ID: <2116429.ju84df7Jza@phil>
In-Reply-To: <20180216120956.19034-5-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com> <20180216120956.19034-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 16. Februar 2018, 13:09:55 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
> only one PHY can connect to DP controller at one time, the other should
> be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
> set this bit means enable PHY 1, clear this bit means enable PHY 0.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
