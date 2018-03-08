Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbeCHWo0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:44:26 -0500
Received: from gloria.sntech.de ([95.129.55.99]:34092 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeCHWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:44:25 -0500
From: Heiko Stuebner <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, hshi@chromium.org, wzz@rock-chips.com,
        hl@rock-chips.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dianders@chromium.org,
        linux-rockchip@lists.infradead.org, orjan.eide@arm.com,
        m.szyprowski@samsung.com,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: Re: [PATCH v4 01/38] drm/bridge: analogix_dp: set psr activate/deactivate when enable/disable bridge
Date: Thu, 08 Mar 2018 23:44:15 +0100
Message-ID: <1656609.JibIPNoNVJ@phil>
In-Reply-To: <20180305222324.5872-2-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com> <20180305222324.5872-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. März 2018, 23:22:53 CET schrieb Enric Balletbo i Serra:
> From: zain wang <wzz@rock-chips.com>
> 
> There's a race between when bridge_disable and when vop_crtc_disable
> are called. If the flush timer triggers a new psr work between these,
> we will operate eDP without power shutdowned by bridge_disable. In this
> case, moving activate/deactivate to enable/disable bridge to avoid it.
> 
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

adapted the subject to drm/rockchip, as it only touches the rockchip
glue driver for the analogix_dp and applied to drm-misc-next after
checking on both pinky (rk3288) and kevin (rk3399).


Heiko
