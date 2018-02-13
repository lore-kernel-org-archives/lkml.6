Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933598AbeBMH1N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbeBMH1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:27:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B864217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x224crwiGlbl1R+Aybxo+87YTid8VwCdozEVuCfKcaBbhn4eQXqpVtlSyUCDMaIZc8cUWjBMH3++Mv4lVIs2UcgY=
MIME-Version: 1.0
In-Reply-To: <20180212161538.22669-7-s.nawrocki@samsung.com>
References: <CGME20180212161705epcas1p379d012575d9ffb52d8ec7c4d49d79102@epcas1p3.samsung.com>
 <20180212161538.22669-1-s.nawrocki@samsung.com> <20180212161538.22669-7-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Feb 2018 08:27:09 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfMKH2d+c2tg2GZUAQGs7K=NUoQvh2yzFB=P80d4AUv_A@mail.gmail.com>
Message-ID: <CAJKOXPfMKH2d+c2tg2GZUAQGs7K=NUoQvh2yzFB=P80d4AUv_A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ASoC: samsung: Add support for HDMI audio on TM2 board
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 5:15 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This patch defines I2S1 - HDMI DAI link and implements related
> hw_params callback. The AUD PLL frequency is configured through
> the CLK_SCLK_I2S1 leaf clock, the exynos5433 clock tree
> definitions are updated in a separate patch.
>
> The device tree parsing part is changed is a way it supports older
> DTBs with just a single CPU DAI specified, without the HDMI link.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - dropped the AUD PLL frequency adjustments, only 48k, 96k,
>    192k sample rates will be supported.
> ---
>  sound/soc/samsung/tm2_wm5110.c | 152 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 129 insertions(+), 23 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
