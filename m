Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933513AbeCHQij convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:38:39 -0500
Received: from gloria.sntech.de ([95.129.55.99]:53174 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932087AbeCHQig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:38:36 -0500
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Archit Taneja <architt@codeaurora.org>, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCH v9 2/5] drm/rockchip: inno_hdmi: Fix error handling path.
Date: Thu, 08 Mar 2018 17:38:30 +0100
Message-ID: <3005091.N6bvNJytYr@diego>
In-Reply-To: <20180302175757.28192-3-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com> <20180302175757.28192-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 2. März 2018, 18:57:54 CET schrieb Enric Balletbo i Serra:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Add missing error handling in bind().
> 
> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> [moved clk_disable_unprepare reordering in unbind to separate patch]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc-next

Thanks
Heiko
