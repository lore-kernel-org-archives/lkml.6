Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756307AbeDXGnT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:43:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35040 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932684AbeDXGnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:43:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180424064307euoutp02fb1d0d4e0b052d33d4ade214e4db8528~oTCM0BYb52928829288euoutp02f
X-AuditID: cbfec7f5-f95739c0000028a9-05-5aded1fab635
Subject: Re: [RESEND PATCH v6 00/27] DRM Rockchip rk3399 (Kevin)
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, wzz@rock-chips.com,
        hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <cc4955f0-961b-f852-fc0d-1e1c9e8b5708@samsung.com>
Date: Tue, 24 Apr 2018 08:43:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xTVxjGPfeee3vbrHipbn11g80yIi4BNPPDSdyIS1x2P5ltMZnpB7Gb
        N4i0wHqtm1twXU3544AhTAcF2ZTKGJZACoIjSmeZdqyptXFS3VbKlA2QdRoBlSE62jszvv3e
        53nOed/35HC0Jsyu5vIL94rmQoNRx6pw78W5YOY/oRH9+iN/ppOqS0MUsZXHGBJoPc+Sn2dv
        s8T1qxeRxzemGHKstoQ86PqJJmU9NyhSG63B5P61AEvaZhoUZGIkhEn3pUqGfH5ziibBYJeC
        XPb4KRKw/aUgFYedCuK+OcyQK/1NLLk7+pgm9cEBinT8EFGQge5BTH68d5Qika4AIvV1kyyZ
        tj9iyVx/MyZlB1spUhp+ZvMLgqvZhYTp9luM0GgNYeFKdRUlnIk4kfCdI6IQGssbGMHdXsEK
        ffdGGSH6mY8Sup2fCAsODxaqe9qR0DfcTAvT7tQ3l+tVr+wSjfn7RHN2zk7V7vGKKqo4lPlh
        8KAVW1Hbi4eQkgN+I3x6uhIdQipOw7ch6OjtZOOGhp9BcHKUkY1pBJ47LvTkRKujhpKNbxCc
        /d3LykUMQVPfXSqeWsFvhtLJsURqJT+JoOvCVKKg+TCG6PGribtYfh0sdF9PNFTzOXB7MJo4
        jfl0GOoZTGSe5reDbXxOIWeSYahhDMdZyb8GvilbQqf556Ev1kTLrIVfxr6i5FkbldD2d5rM
        W+D+ty0KmVfALV/Pf/wc+Osqscwfw/UJG44PCnw5guh8GSsbm2DQF1p8DW6xwTro7M+W5Veh
        IzCM4zLwSXAtliyPkAS1vV/SsqyG8lKNnF4D0cBpWmYtnLw8y9agNMeSxRxLlnEsWcbxf9+v
        EW5HWtEimfJE6eVC8YMsyWCSLIV5We8Vmdxo8bv7H/lmz6CBh+96Ec8h3VPqB/MRvYYx7JP2
        m7wIOFq3Un0udUSvUe8y7P9INBflmi1GUfKiZzms06p3ZBzQa/g8w16xQBSLRfMTl+KUq60o
        ef2B0a1D9pKChTr6RMqWhRy3wKjyx3f4Xs9620WH51PTPWUPc5Lesnyx9eIdx/tHsjv9xe/k
        TlQtLzj/hnHTqYwLaypD2/7Qtsx02GfSbb9tzD2102kqkrZrlZ6rh1PsKcesG763NKdplmXU
        2/1rhT3Vzsy8EljVvywcM7ZMHl2lw9Juw4aXaLNk+Bejv8hN6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z/rlEanZfnPDxWjCwXOptleu0h9OwRFFEEtuiw7aOS22tkq
        g0qMSq3VulA6bRbNC6Zgm3gpzNLQ1HRZYTc2uxilywuZuuUtdQZ++8Hz/Hh44ZWQMi8dJjms
        MwoGnSZRzgRTTWP1nnB/q0e9Kr+KAXNLAwEpqd00NOc9Y+DtQC8DRZ9qEIx/9dJw5/pp8JU0
        knCx9CsB19stFAy9b2ag4E8mCz89rRQ4Wy7TcPWblwSXq4SFV9VNBDSn/GIh7ZqdBce3Nhre
        PMpm4PfncRIyXE8IKH7uZuGJs5aCF4O3CHCXNCPIuNHJQP/5MQb8j2wUXDyXR8CFd/M3LuaL
        bEWI7y/sovms5FaKf3PFTPAVbjviK61uls9KzaR5R2Eaw5cPfqb59kv1BO+0n+VHrdUUf6W0
        EPHlbTaS73cs3DZbrVhv0JuMwuIEvWjcIN+jhEiFMgYUkatjFMoo1d61kdHyiNj1h4TEw8cF
        Q0TsAUXCjzQzcbQ1/KTrXDKVjAqWpKMgCeZW4zyrhUhHwRIZl4uw3+IhAkEofpzTTQZ4Lh5p
        S2cCJS/CxX4fNRnM5TbiC50dU3YI14lwg7mLnQxI7h2FXw5HBYybCF+tr5wKGG4FHnV+YCZZ
        ysXi3tr2qTmKW4obSmvRJM/jdmGP6/d0Zw5uyOyYWgviNuF6b8r0wHI8YntNBngRLu/OnuZQ
        /LEjh7AgmXWGbp2hWGco1hnKXUQVohDBJGrjtWKkQtRoRZMuXhGn1zrQxKOV1flLK1B6z44a
        xEmQfJbUN+xWy2jNcTFJW4OwhJSHSKsWetQy6SFN0inBoN9vMCUKYg2KnjjuGhk2L04/8bY6
        435ltFIFMUpVlCpqDchDpa5VSWoZF68xCkcE4ahg+O8RkqCwZHQi/2ZEauXmttBT8+10i23I
        tOX20KenOb7vsbgs917XmcwD0VnHlm23+YK/FxRzu829rNPw8tmCvvwH+wZ2jiZZLH2/7i6g
        xrUjGQMrtur2nHjQvcX+5a/TXaeVNj3u2Wft+eBVOdiDD28M/qze+1bfN9ZYVREe5Outdt/f
        Obw5e52cEhM0ypWkQdT8AzcLxU9+AwAA
X-CMS-MailID: 20180424064305eucas1p2f3a725a420641b5ec2887a75fecb34c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180424064305eucas1p2f3a725a420641b5ec2887a75fecb34c0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423105022epcas3p442289343ea272f0722802b4746871fba
X-RootMTR: 20180423105022epcas3p442289343ea272f0722802b4746871fba
References: <CGME20180423105022epcas3p442289343ea272f0722802b4746871fba@epcas3p4.samsung.com>
        <20180423105003.9004-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.04.2018 12:49, Enric Balletbo i Serra wrote:
> Hi Andrzej,
>
> This is the rebased version of v6 series. This patchset includes cleanups,
> improvements, and bug fixes for Rockchip DRM driver and PSR support.
>
> This version is a RESEND of v6 with few changes. The following two
> patches are not included and will be send in a separate patchset for
> further discussion.
>
> - [PATCH v6 24/30] drm/rockchip: Disable PSR on input events
> - [PATCH v6 25/30] drm/rockchip: Cancel PSR enable work before changing
>                    the state
>
> The following patch was remove as is not needed.
>
> - [PATCH v6 28/30] drm/rockchip: Disable PSR from reboot notifier
>
> I think that the other patches have the required tags and are ready to
> be merged.

Queued to drm-misc-next.

Regards
Andrzej


>
> Regards,
>   Enric
>
> Changes in v6:
> - Removed the following patches as are already applied.
>   [PATCH v5 01/36] drm/bridge: analogix_dp: detect Sink PSR state after
>   configuring the PSR
>   [PATCH v5 02/36] drm/rockchip: Remove analogix psr worker
>   [PATCH v5 03/36] drm/bridge: analogix_dp: Don't change psr while
>   bridge is disabled
> - Explain in the commit message why we need to increase
>   the delay in the timeout loop in
>   [PATCH v5 07/36] drm/bridge: analogix_dp: Move enable video into
>   config_video()
> - Add Reviewed-by: Archit Taneja <architt@codeaurora.org> for the
>   drm/bridge parts
> - Add Reviewed-by: Heiko Stuebner <heiko@sntech.de> for
>   [PATCH v5 19/36] drm/rockchip: Restore psr->state when enable/disable
>   psr failed
>
> Changes in v5:
> - Removed the following patches as are already applied.
>   [PATCH v4 01/38] drm/bridge: analogix_dp: set psr activate/deactivate
>   when enable/disable bridge
>   [PATCH v4 02/38] drm/rockchip: Don't use atomic constructs for psr
> - Add Mareks tested-tag and including the missing people.
> - [PATCH v4 15/38] move analogix_dp_set_analog_power_down() before
>   phy_power_off() to fix Exynos issue.
>
> Changes in v4:
> - Rebased all on top of drm-misc-next
> - Removed the following patches as are already applied.
>   [PATCH v3 01/43] drm/rockchip: Get rid of unnecessary struct fields
>   [PATCH v3 02/43] drm/rockchip: support prime import sg table
>   [PATCH v3 03/43] drm/rockchip: Respect page offset for PRIME mmap
>   calls
> - Removed the following patches as now are part of another patchset
>   [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in
>   analogix_dp_bind
>   [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31
>
> Changes in v3:
> - Addressed some of the comments from Sean on the v2
>
> Changes in v2:
> - A few patches have been replaced by newer and cleaner versions from
>   the ChromeOS kernel gerrit, especially about disallowing PSR for the
>   whole atomic commit.
>
>
> Douglas Anderson (4):
>   drm/bridge: analogix_dp: Reorder plat_data->power_off to happen sooner
>   drm/bridge: analogix_dp: Properly log AUX CH errors
>   drm/bridge: analogix_dp: Properly disable aux chan retries on rockchip
>   drm/bridge: analogix_dp: Split the platform-specific poweron in two
>     parts
>
> Lin Huang (6):
>   drm/bridge: analogix_dp: Move enable video into config_video()
>   drm/bridge: analogix_dp: Check AUX_EN status when doing AUX transfer
>   drm/bridge: analogix_dp: Ensure edp is disabled when shutting down the
>     panel
>   drm/bridge: analogix_dp: Extend hpd check time to 100ms
>   drm/bridge: analogix_dp: Check dpcd write/read status
>   drm/bridge: analogix_dp: Reset aux channel if an error occurred
>
> Mark Yao (1):
>   drm/rockchip: pre dither down when output bpc is 8bit
>
> Tomasz Figa (5):
>   drm/rockchip: analogix_dp: Do not call Analogix code before bind
>   drm/rockchip: psr: Avoid redundant calls to .set() callback
>   drm/rockchip: psr: Sanitize semantics of allow/inhibit API
>   drm/rockchip: Disallow PSR for the whole atomic commit
>   drm/rockchip: psr: Remove flush by CRTC
>
> zain wang (11):
>   drm/bridge: analogix_dp: Don't use fast link training when panel just
>     powered up
>   drm/bridge: analogix_dp: Retry bridge enable when it failed
>   drm/bridge: analogix_dp: Wait for HPD signal before configuring link
>   drm/bridge: analogix_dp: Set PD_INC_BG first when powering up edp phy
>   drm/bridge: analogix_dp: Fix incorrect usage of enhanced mode
>   drm/bridge: analogix_dp: Fix AUX_PD bit for Rockchip
>   drm/rockchip: Restore psr->state when enable/disable psr failed
>   drm/bridge: analogix_dp: Don't use ANALOGIX_DP_PLL_CTL to control pll
>   drm/bridge: analogix_dp: Fix timeout of video streamclk config
>   drm/bridge: analogix_dp: Fix incorrect operations with register
>     ANALOGIX_DP_FUNC_EN_1
>   drm/bridge: analogix_dp: Move fast link training detect to set_bridge
>
>  .../drm/bridge/analogix/analogix_dp_core.c    | 331 +++++++++++++-----
>  .../drm/bridge/analogix/analogix_dp_core.h    |   5 +-
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 236 +++++++------
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.h |   7 +
>  drivers/gpu/drm/exynos/exynos_dp.c            |   2 +-
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  37 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |   1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c    |  61 +++-
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.c   | 158 ++++-----
>  drivers/gpu/drm/rockchip/rockchip_drm_psr.h   |   7 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  13 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   1 +
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   1 +
>  include/drm/bridge/analogix_dp.h              |   3 +-
>  14 files changed, 559 insertions(+), 304 deletions(-)
>
