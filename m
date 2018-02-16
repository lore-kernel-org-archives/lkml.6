Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeBPHEZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 02:04:25 -0500
Received: from gloria.sntech.de ([95.129.55.99]:41288 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753428AbeBPHET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 02:04:19 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, p.zabel@pengutronix.de,
        hjc@rock-chips.com
Subject: Re: [PATCH v5 05/12] drm/bridge/synopsys: dw-hdmi: don't clobber drvdata
Date: Fri, 16 Feb 2018 08:03:59 +0100
Message-ID: <5806685.TbOkgmbs60@phil>
In-Reply-To: <20180214200906.31509-6-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net> <20180214200906.31509-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. Februar 2018, 21:08:59 CET schrieb Jernej Skrabec:
> dw_hdmi shouldn't set drvdata since some drivers might need to store
> it's own data there. Rework dw_hdmi in a way to return struct dw_hdmi
> instead to store it in drvdata. This way drivers are responsible to
> store and pass structure when needed.
> 
> Idea was taken from the following commit:
> 8242ecbd597d ("drm/bridge/synopsys: stop clobbering drvdata")
> 
> Cc: p.zabel@pengutronix.de
> Cc: narmstrong@baylibre.com
> Cc: Laurent.pinchart@ideasonboard.com
> Cc: hjc@rock-chips.com
> Cc: heiko@sntech.de
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

For the Rockchip-part
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>
