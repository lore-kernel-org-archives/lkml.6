Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbeESQI6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 12:08:58 -0400
Received: from gloria.sntech.de ([95.129.55.99]:58344 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752370AbeESQI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 12:08:56 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 24/26] drm/bridge: remove the .of_node member
Date: Sat, 19 May 2018 18:08:30 +0200
Message-ID: <5194502.mIuqRB9jFM@phil>
In-Reply-To: <20180516101510.13215-25-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se> <20180516101510.13215-25-peda@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Mai 2018, 12:15:08 CEST schrieb Peter Rosin:
> It is unused.
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Peter Rosin <peda@axentia.se>

> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 557e0079c98d..e77d4c909582 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  	}
>  	if (lvds->panel)
>  		remote = lvds->panel->dev->of_node;
> -	else if (lvds->bridge->of_node)
> -		remote = lvds->bridge->of_node;
>  	else
>  		remote = lvds->bridge->odev->of_node;
>  	if (of_property_read_string(dev->of_node, "rockchip,output", &name))

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
