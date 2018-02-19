Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752858AbeBSNty (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:49:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46513 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752753AbeBSNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:49:53 -0500
Message-ID: <1519048168.3408.13.camel@pengutronix.de>
Subject: Re: [PATCH v5 05/12] drm/bridge/synopsys: dw-hdmi: don't clobber
 drvdata
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jernej Skrabec <jernej.skrabec@siol.net>,
        maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com,
        hjc@rock-chips.com, heiko@sntech.de
Date: Mon, 19 Feb 2018 14:49:28 +0100
In-Reply-To: <20180214200906.31509-6-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
         <20180214200906.31509-6-jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-14 at 21:08 +0100, Jernej Skrabec wrote:
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

For i.MX:
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
