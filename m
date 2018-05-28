Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940277AbeE1Qg4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940264AbeE1Qgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:36:50 -0400
X-Google-Smtp-Source: ADUXVKL+EAlOcgpqyABEpLxHRTjQ3T/tyPpdX97nZMaGTVCZzxmfo8kNTn1aGYj+eepld/6MHnY0Kx3Os4sqnLpymrs=
MIME-Version: 1.0
In-Reply-To: <1527501272-16365-1-git-send-email-m.purski@samsung.com>
References: <CGME20180528095444eucas1p222e4054b8fb8997258182e501f37a10b@eucas1p2.samsung.com>
 <1527500833-16005-1-git-send-email-m.purski@samsung.com> <1527501272-16365-1-git-send-email-m.purski@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 28 May 2018 18:36:47 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdO1aTSvtHthyaMEjwURKn-FXUzhAr-N7ta0+DmUUr1vg@mail.gmail.com>
Message-ID: <CAJKOXPdO1aTSvtHthyaMEjwURKn-FXUzhAr-N7ta0+DmUUr1vg@mail.gmail.com>
Subject: Re: [PATCH 10/12] ARM: dts: exynos5250: add DSI node
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:54 AM, Maciej Purski <m.purski@samsung.com> wrote:
> The patch adds common part of DSI node for Exynos5250 platforms.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)


This should be squashed with previous patch because it is logically
the same feature. The purpose of PHY is this DSI node so splitting it
is slightly too much.

Best regards,
Krzysztof
