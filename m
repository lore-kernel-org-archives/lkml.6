Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbeCLR1U convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:27:20 -0400
Received: from gloria.sntech.de ([95.129.55.99]:39976 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932560AbeCLR1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:27:19 -0400
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
        hshi@chromium.org
Subject: Re: [PATCH v5 00/36] DRM Rockchip rk3399 (Kevin)
Date: Mon, 12 Mar 2018 18:27:03 +0100
Message-ID: <2145089.N3HHEgGPyY@diego>
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 9. März 2018, 23:22:51 CET schrieb Enric Balletbo i Serra:
> Hi,
> 
> This patchset includes cleanups, improvements, and bug fixes for
> Rockchip DRM driver and PSR support.
> 
> This new version is the same as before removing some of the patches
> already applied and fixing the Exynos issue due patch '[v4 15/38]
> drm/bridge: analogix_dp: Ensure edp is disabled when shutting down
> the panel' reported by Marek.

The series on both rk3288 (without psr) and rk3399 (with psr)
Tested-by: Heiko Stuebner <heiko@sntech.de>


I've tried reviewing at least the Rockchip parts, so if  bridge-
maintainers are going to apply patches to drm-misc they could
pick up the interlinked Rockchip patches as well.

I don't think it's necessary to wait for the full series to be mergeable
and before I just picked things from the beginning that looked ready
and worked, so I guess continuing this way could help making that
chunk of patches smaller :-) .


Heiko
