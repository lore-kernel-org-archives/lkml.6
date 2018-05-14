Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeENVoR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:44:17 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:11585 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeENVoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:44:13 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514214410epoutp01c67fde4db623c06105f0bbdd6c970773~uoOoNFizN3270432704epoutp01U
X-AuditID: b6c32a47-bc7ff70000001011-42-5afa0328ae3d
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFA0327.2080204@samsung.com>
Date: Tue, 15 May 2018 06:44:07 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Lin Huang <hl@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/10] devfreq: rockchip-dfi: Move GRF definitions
 to a common place.
In-reply-to: <20180514211610.26618-2-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmha4G868og9uLFCx6z51ksni1eQ+b
        xZWv79ks1tw+xGjx/9FrVou5k2otfmw4xWyx+VwPq8XZpjfsFpseX2O1+Nhzj9Xi8q45bBaf
        e48wWnx68J/Z4uIpV4vbjSvYLFr3HmG3+HdtI4vF3Q1nGS1efjzB4iDisWbeGkaP9zda2T1m
        N1xk8dhxdwmjx6ZVnWwe2789YPW4332cyWPzknqPv7P2s3j0bVnF6LH92jxmj8+b5AJ4olJt
        MlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4D+VFIoS8wp
        BQoFJBYXK+nb2RTll5akKmTkF5fYKkUbGhrpGRqY6xkZAWnjWCsjU6CShNSM/Wc+sxWclKzY
        eG4eWwPjB5EuRk4OCQETiXULt7F1MXJxCAnsYJRYdHICG0hCSOA7o8T37zEwRe82TYEq2sAo
        8ertGiaQBK+AoMSPyfdYuhg5OJgF5CWOXMoGCTMLaEps3b2eHaL+LqPE+gnz2SHqtSSaZq1g
        BbFZBFQl9rbtYwax2YDi+1/cAFvML6AocfXHY0YQW1QgQmLn/G9gg0QE+pklPnc2M4E4zAIn
        mSSOz5sHNlVYIF5ievM2dpArOAWcJF41pIHUSAg8Ypf4c6WVDSQuIeAi0fo+GeIbYYlXx7ew
        Q9jSEs9WbWSEqG9nlGjfO48ZwpnCKHHu+j0miCpjiWcLu5ggfuOT6Dj8lx1iKK9ER5sQRImH
        xMaTz5khbEeJphnnGSHeP8soseLKftYJjHKzkEJsFiLEZiGF2AJG5lWMYqkFxbnpqcVGBcZ6
        xYm5xaV56XrJ+bmbGMFJW8t9B+O2cz6HGAU4GJV4eBOm/YwSYk0sK67MPcQowcGsJMK72wgo
        xJuSWFmVWpQfX1Sak1p8iNEUGOATmaVEk/OBGSWvJN7Q1MjY2NjC1NzS2MBSSZx3jdLXKCGB
        9MSS1OzU1ILUIpg+Jg5OqQZGr7CikIV1b1MeJKlv6vszOWtCa8aShuuix+LCWPJmVbsc28LD
        4+r2RPWj28frRQdj92TWGKyz/fjl6UH979wr3dtrLgUzzth0utwv+ZHnK0W1/ytrX/0uLnT7
        uP3RU/mbwgcKA9NjmZrfPtUom3xwtyTfnthr+7YofG9Nv6wmb2b67nD/i7AIJZbijERDLeai
        4kQAsSorgfADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t9jQV115l9RBu8vmFr0njvJZPFq8x42
        iytf37NZrLl9iNHi/6PXrBZzJ9Va/Nhwitli87keVouzTW/YLTY9vsZq8bHnHqvF5V1z2Cw+
        9x5htPj04D+zxcVTrha3G1ewWbTuPcJu8e/aRhaLuxvOMlq8/HiCxUHEY828NYwe72+0snvM
        brjI4rHj7hJGj02rOtk8tn97wOpxv/s4k8fmJfUef2ftZ/Ho27KK0WP7tXnMHp83yQXwRHHZ
        pKTmZJalFunbJXBl7D/zma3gpGTFxnPz2BoYP4h0MXJySAiYSLzbNIWti5GLQ0hgHaNER1cX
        M0iCV0BQ4sfkeyxdjBwczALyEkcuZYOEmQXUJSbNW8QMUX+fUeLshjYmiHotiaZZK1hBbBYB
        VYm9bfvA5rABxfe/uMEGYvMLKEpc/fGYEWSmqECERPeJSpA5IgL9zBLTrp1hBHGYBU4ySazo
        PA42SFggXqLrzXuo684ySqycMocNpJtTwEniVUPaBEaBWUhunYVw6ywkty5gZF7FKJlaUJyb
        nltsVGCUl1quV5yYW1yal66XnJ+7iREYr9sOa/XvYHy8JP4QowAHoxIPb8K0n1FCrIllxZW5
        hxglOJiVRHh3GwGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJx
        cEo1ME6f+oHLWfSw+bnf0nvkbq6+3Ozbuv1qXvyKBW9Dr/fyJ7J82XTJVm3j/RnxTzjfFaQ4
        Ga3xyeS68NZzXvSvM2dbfv/pP/sqatsV9SeB+ukTvi24N3/ms4k7332QcbxournOenLbFs+O
        Kh5jt8x9UcVODe89Z9w94LlF5HlTysZLXtUrlx9WL9yjxFKckWioxVxUnAgApchzM9MCAAA=
X-CMS-MailID: 20180514214407epcas2p2d4300a6eb6033e56b077d5f1de5fa674
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180514211637epcas4p4017318fec5b9d7ace763d72e35216449
X-RootMTR: 20180514211637epcas4p4017318fec5b9d7ace763d72e35216449
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
        <CGME20180514211637epcas4p4017318fec5b9d7ace763d72e35216449@epcas4p4.samsung.com>
        <20180514211610.26618-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 05월 15일 06:16, Enric Balletbo i Serra wrote:
> Some rk3399 GRF (Generic Register Files) definitions can be used for
> different drivers. Move these definitions to a common include so we
> don't need to duplicate these definitions.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
>  include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
>  2 files changed, 28 insertions(+), 16 deletions(-)
>  create mode 100644 include/soc/rockchip/rk3399_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 22b113363ffc..2fbbcbeb644f 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,6 +26,8 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  
> +#include <soc/rockchip/rk3399_grf.h>
> +
>  #define RK3399_DMC_NUM_CH	2
>  
>  /* DDRMON_CTRL */
> @@ -43,18 +45,6 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>  
> -/* pmu grf */
> -#define PMUGRF_OS_REG2	0x308
> -#define DDRTYPE_SHIFT	13
> -#define DDRTYPE_MASK	7
> -
> -enum {
> -	DDR3 = 3,
> -	LPDDR3 = 6,
> -	LPDDR4 = 7,
> -	UNUSED = 0xFF
> -};
> -
>  struct dmc_usage {
>  	u32 access;
>  	u32 total;
> @@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  	u32 ddr_type;
>  
>  	/* get ddr type */
> -	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
> +	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
>  
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>  
>  	/* set ddr type to dfi */
> -	if (ddr_type == LPDDR3)
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type == LPDDR4)
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>  
>  	/* enable count, use software mode */
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
> new file mode 100644
> index 000000000000..0f94034e2e9a
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip Generic Register Files definitions
> + *
> + * Copyright (c) 2018, Collabora Ltd.
> + * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> + */
> +
> +#ifndef __SOC_RK3399_GRF_H
> +#define __SOC_RK3399_GRF_H
> +
> +/* PMU GRF Registers */
> +#define RK3399_PMUGRF_OS_REG2		0x308
> +#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> +#define RK3399_PMUGRF_DDRTYPE_MASK	7
> +#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +
> +#endif
> 

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
