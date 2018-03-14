Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeCNMvh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:51:37 -0400
Received: from gloria.sntech.de ([95.129.55.99]:46518 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeCNMvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:51:35 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, a.hajda@samsung.com, ykk@rock-chips.com,
        kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        linux-input@vger.kernel.org, orjan.eide@arm.com, wxt@rock-chips.com,
        jeffy.chen@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        mark.yao@rock-chips.com, wzz@rock-chips.com, hl@rock-chips.com,
        jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [PATCH v5 06/36] drm/rockchip: Only wait for panel ACK on PSR entry
Date: Wed, 14 Mar 2018 13:51:20 +0100
Message-ID: <217296292.AN06WKDqZv@diego>
In-Reply-To: <20180309222327.18689-7-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com> <20180309222327.18689-7-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 9. März 2018, 23:22:57 CET schrieb Enric Balletbo i Serra:
> From: zain wang <wzz@rock-chips.com>
> 
> We currently wait for the panel to mirror our intended PSR state
> before continuing on both PSR enter and PSR exit. This is really
> only important to do when we're entering PSR, since we want to
> be sure the last frame we pushed is being served from the panel's
> internal fb before shutting down the soc blocks (vop/analogix).
> 
> This patch changes the behavior such that we only wait for the
> panel to complete the PSR transition when we're entering PSR, and
> to skip verification when we're exiting.
> 
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Cc: Sonny Rao <sonnyrao@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

applied to drm-misc-next with the subject fixed.


Thanks
Heiko
