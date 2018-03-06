Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbeCFKQC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:16:02 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57601 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753075AbeCFKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:15:57 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180306101555euoutp01f133f9769ad8813669ca4703e7018a51~ZTVAP1tQ60836308363euoutp01K
X-AuditID: cbfec7f2-1c1ff70000011644-a9-5a9e6a5a59d6
Subject: Re: [PATCH v4 00/38] DRM Rockchip rk3399 (Kevin)
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <568969f3-0b93-05ef-953d-af1eebdac87e@samsung.com>
Date: Tue, 06 Mar 2018 11:15:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180305222324.5872-1-enric.balletbo@collabora.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH973nucfDuvZ0yCea6latmciq7SuyUtqz+iN/9Mut1OGJyq/u
        HFHpljshmchqh6vkjkxm7oZssjvKUtGlWEn6KYXVMr/6Qe6HzX+vz/f93vfzfn/3pQnhEN+d
        PhGfxEnjJbEiyomsfzTdtV58UiPeoP2wCl/pfMzDF7NG+fiZzkjhl+M/KFzdZ0J49uMwH5cW
        nMdTtR0EvmT4yMMFA/kk7m4qofCv97MEfqBvJXF/7TOEx1QzFJ5u0pA4s3fptiVstaYascUK
        M8l2513hsY395Yi9r+53YBsm3vPZgcvtPFZffoH9p24h2TxDFWIbejQEO1bnGbpI7BQYxcWe
        SOakvkHHnGJUFV+oRJX3mZt3jZQCdYtykCMNzCboKdcROciJFjKVCBq00/ZhDEHLzy5y3tVm
        UNoFHQJjxw0H2/AVQe2bYr7F5cz4w+zEVZ5FcGG+zQkPh60DwTxHcLnvKWVxUYwf5IzmWFnA
        BMHF31M8C5PMGujUKueYpl2ZwzD8d5fNsgSmCt9ZYzgy26FRN2hdRjBbYHBGZecVoK8eJWzs
        Bhmq1/bYJgcw67faeCdk1UzYz53he7vBwcbLITvLyLPxBcibbLNmBiYXQbOyyC4EQGu72b5s
        MRTUXycsOYERQFam0GZh4far+fu3g+5TPd/2QtcQmCd/onzkqV7QR72gg3pBB/WCDrcQWYXc
        OLksLpqT+cVzKT4ySZxMHh/tE5kQV4fm/t+TmfZfjWj8RYQJMTQSLRLQe0rFQr4kWZYaZ0JA
        EyIXwSFfjVgoiJKkpnHShKNSeSwnMyEPmhS5CcLXpYuFTLQkiTvFcYmcdF7l0Y7uCgT+g7Ry
        KiW4eajIu9hriN6sDK8kg82k9usa9zCDxz5uoqWqL/GPJKOkrPCAoTIi5GyI/ODaM4FE4Mjq
        3NyX/Xt7DRkjKlVQiaIi9O+5AX0G+t680lB2b1BxZ0fkslTaS3rE1bixxi8tYH92yPGUFw+0
        NzW7Q2b2h+Wmn/78+/ZbESmLkfh5EVKZ5D9ejuQzewMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xy7pRWfOiDH49Y7ToPXeSyaKp4y2r
        xdllB9ksrnx9z2ax5vYhRov/j16zWsydVGvxY8MpZov2LY+YLCbdn8BicXnXHDaLTw/+M1vs
        23yYxeLuhrOMFp9b/7FZ/Nw1j8Wi7bqYg6DHmnlrGD1mN1xk8bjc18vksePuEkaPnbPusnts
        //aA1eN+93Emj81L6j3+ztrP4tG3ZRWjx/Zr85g9Pm+SC+CJ4rJJSc3JLEst0rdL4MpoXf6U
        raBVp2L+yoNsDYyXlboYOTkkBEwkjmxpYe5i5OIQEljCKDH3/z12COc5o8T8v7PZQKqEBSwl
        /n+byASSEBF4yShxsvcVWBWzwDlGidst69kgWqYxSvTcnMoC0sImYCjR9bYLrJ1XwE6i6dcP
        JhCbRUBV4tzSFjBbVCBGYurHjawQNYISPybfA+vlFHCU2LHsGVicWcBM4svLw1C2vMTmNW+Z
        IWxxiebWmywTGAVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM
        023Hfm7ewXhpY/AhRgEORiUe3g0ec6OEWBPLiitzDzFKcDArifBG6M+LEuJNSaysSi3Kjy8q
        zUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cCYzuXRVLa9L/dO9OsfKzm17/3M
        n9E/Pf2jo9cKpQAvvWdPrUos/DXDLd/+73QNTZiQXPmw7Mj58E/TD/tPmZM7UevOneB6r9t8
        oqXm/zwa9kgyHlsyxae1dLdTd+/NiXarLLq3u9dsm2r3zaV79XW3DvWdJa2Pc+wDb6dHbBOL
        fSYTw1jil6HEUpyRaKjFXFScCAD+1pnVzwIAAA==
X-CMS-MailID: 20180306101554eucas1p17691d725e9860795c122f57c70c5cbdb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180305222337epcas3p22a4f5c32c5622d89f6e649b26c0a6043
X-RootMTR: 20180305222337epcas3p22a4f5c32c5622d89f6e649b26c0a6043
References: <CGME20180305222337epcas3p22a4f5c32c5622d89f6e649b26c0a6043@epcas3p2.samsung.com>
        <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018-03-05 23:22, Enric Balletbo i Serra wrote:
> Hi,
>
> This patchset includes cleanups, improvements, and bug fixes for
> Rockchip DRM driver and PSR support.
>
> This new version is the same as before but rebased on top of
> drm-misc-next plus the Marek patches that fixes Chromebook2 Peach-Pit [1]
> and the latest series of Rockchip rk3399 eDP support [2].
>
> [1] https://www.spinics.net/lists/dri-devel/msg167804.html
> [2] https://www.spinics.net/lists/dri-devel/msg167770.html

Thanks for v4 of this patchset.

After fixing the issue pointed in the patch 15/38, everything works fine on
Exynos5250-based Chromebook Snow and Exynos5420-based Chromebook2 Peach-Pit
boards. You can add my:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Regards,
>   Enric
>
> Changes in v4:
> - Rebased all on top of drm-misc-next
> - Removed the following patches as are already applied.
>    [PATCH v3 01/43] drm/rockchip: Get rid of unnecessary struct fields
>    [PATCH v3 02/43] drm/rockchip: support prime import sg table
>    [PATCH v3 03/43] drm/rockchip: Respect page offset for PRIME mmap
>    calls
> - Removed the following patches as now are part of another patchset
>    [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in
>    analogix_dp_bind
>    [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp lq123p1jx31
>
> Changes in v3:
> - Addressed some of the comments from Sean on the v2
>
> Changes in v2:
> - A few patches have been replaced by newer and cleaner versions from
>    the ChromeOS kernel gerrit, especially about disallowing PSR for the
>    whole atomic commit.
>
>
> Douglas Anderson (4):
>    drm/bridge: analogix_dp: Reorder plat_data->power_off to happen sooner
>    drm/bridge: analogix_dp: Properly log AUX CH errors
>    drm/bridge: analogix_dp: Properly disable aux chan retries on rockchip
>    drm/bridge: analogix_dp: Split the platform-specific poweron in two
>      parts
>
> Kristian H. Kristensen (1):
>    drm/rockchip: Disable PSR on input events
>
> Lin Huang (6):
>    drm/bridge: analogix_dp: Move enable video into config_video()
>    drm/bridge: analogix_dp: Check AUX_EN status when doing AUX transfer
>    drm/bridge: analogix_dp: Ensure edp is disabled when shutting down the
>      panel
>    drm/bridge: analogix_dp: Extend hpd check time to 100ms
>    drm/bridge: analogix_dp: Check dpcd write/read status
>    drm/bridge: analogix_dp: Reset aux channel if an error occurred
>
> Mark Yao (1):
>    drm/rockchip: pre dither down when output bpc is 8bit
>
> Sean Paul (2):
>    drm/rockchip: Don't use atomic constructs for psr
>    drm/rockchip: Remove analogix psr worker
>
> Tomasz Figa (7):
>    drm/rockchip: analogix_dp: Do not call Analogix code before bind
>    drm/rockchip: Cancel PSR enable work before changing the state
>    drm/rockchip: psr: Avoid redundant calls to .set() callback
>    drm/rockchip: psr: Sanitize semantics of allow/disallow API
>    drm/rockchip: Disable PSR from reboot notifier
>    drm/rockchip: Disallow PSR for the whole atomic commit
>    drm/rockchip: psr: Remove flush by CRTC
>
> Yakir Yang (1):
>    drm/bridge: analogix_dp: detect Sink PSR state after configuring the
>      PSR
>
> zain wang (16):
>    drm/bridge: analogix_dp: set psr activate/deactivate when
>      enable/disable bridge
>    drm/bridge: analogix_dp: Don't change psr while bridge is disabled
>    drm/rockchip: add mutex vop lock
>    drm/bridge: analogix_dp: add fast link train for eDP
>    drm/rockchip: Only wait for panel ACK on PSR entry
>    drm/bridge: analogix_dp: Don't use fast link training when panel just
>      powered up
>    drm/bridge: analogix_dp: Retry bridge enable when it failed
>    drm/bridge: analogix_dp: Wait for HPD signal before configuring link
>    drm/bridge: analogix_dp: Set PD_INC_BG first when powering up edp phy
>    drm/bridge: analogix_dp: Fix incorrect usage of enhanced mode
>    drm/bridge: analogix_dp: Fix AUX_PD bit for Rockchip
>    drm/rockchip: Restore psr->state when enable/disable psr failed
>    drm/bridge: analogix_dp: Don't use ANALOGIX_DP_PLL_CTL to control pll
>    drm/bridge: analogix_dp: Fix timeout of video streamclk config
>    drm/bridge: analogix_dp: Fix incorrect operations with register
>      ANALOGIX_DP_FUNC_EN_1
>    drm/bridge: analogix_dp: Move fast link training detect to set_bridge
>
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 452 ++++++++++++++++-----
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  14 +-
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 274 ++++++++-----
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.h  |   7 +
>   drivers/gpu/drm/exynos/exynos_dp.c                 |   2 +-
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    |  73 ++--
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   3 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c         |  61 ++-
>   drivers/gpu/drm/rockchip/rockchip_drm_psr.c        | 361 ++++++++++------
>   drivers/gpu/drm/rockchip/rockchip_drm_psr.h        |   7 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  47 ++-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   1 +
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   1 +
>   include/drm/bridge/analogix_dp.h                   |   5 +-
>   15 files changed, 915 insertions(+), 395 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
