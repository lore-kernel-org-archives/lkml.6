Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCNKc5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 06:32:57 -0400
Received: from gloria.sntech.de ([95.129.55.99]:44174 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeCNKcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 06:32:55 -0400
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
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: Re: [PATCH v5 02/36] drm/rockchip: Remove analogix psr worker
Date: Wed, 14 Mar 2018 11:32:42 +0100
Message-ID: <3214934.ZBQRvzMx2H@diego>
In-Reply-To: <20180309222327.18689-3-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com> <20180309222327.18689-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 9. März 2018, 23:22:53 CET schrieb Enric Balletbo i Serra:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Now that the spinlocks and timers are gone, we can remove the psr
> worker located in rockchip's analogix driver and do the enable/disable
> directly. This should simplify the code and remove races on disable.
> 
> Cc: 征增 王 <wzz@rock-chips.com>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


applied to drm-misc-next

Thanks
Heiko
