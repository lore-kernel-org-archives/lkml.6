Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeBHHjb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:39:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50066 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeBHHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:39:29 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180208073927euoutp0194e8a6f4775fdfc8d7ebfe6cd410efca~RSa9nKNTM1064310643euoutp01_
X-AuditID: cbfec7f2-f793b6d000003243-42-5a7bfead477a
Subject: Re: [PATCH v2] drm/bridge/synopsys: dsi: Add 1.31 version support
To: Philippe Cornu <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-id: <bbe3ffeb-2e93-f36f-a8be-0319e16572e5@samsung.com>
Date: Thu, 08 Feb 2018 08:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180206084251.303-1-philippe.cornu@st.com>
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXcuOw4nx2n5qpE18ENBmqziaCYVBSeR6ktUktnI44W8talo
        Vi6vm6ampuHUUDSLDMUz0+ziPafOtGEKgjdKl5fWSlOsUNs8Bn77Pc/z/78P/4eXQERGzIkI
        i4xhZJHScDEuQBu7fw8eqF1P9D9YG0BlD/TyqPppHaCSlUaMSu7ow6nFiVycYn+aMOrTsgmn
        Nj4vYFRZ/h1KlVfFp9gvIxg19LrULJvaQKip1FmM6h9uQ6kMVRp+nKRLFHqUHsrJ5tHN6nE+
        XaIsxuixkbc43bQyhdGTWVoeralKotfUrSjdNPIYoWdW3yH0Erv7vLW/wDuICQ+LY2TuPtcE
        oeULM1h0GRrfqh/HFKASyQRWBCQPwWRWw+N4J/w4UYdnAgEhIp8AONz+B+OKJQCXu+vMKmLT
        ocvzshhEZDWAhcabnMYAoLGlArMM7Ehf+K2tjG8Z2JPJKByZLkUsBUIqADSUFeEWFU7ug2ua
        0U0Wkj5wuLho042SrnCAXeFbeAd5CVYUzgBOYwtXCyZQC1uRnrBYlbuZATG/M/srH+XYBWpe
        GLf6DjAlbRS1LIZkHx/m6Lq2Qp+Cc91FW2wH57UNfI53QZWynccZsgDsa1EhXPEQwMH5oa0z
        HYWdWj3GrbCB+Y2PEO4wQqhMF3ESGk7Ut6Acn4C1mhQ+d6T7ADb3lvAeABf1tkTqbSnU21Ko
        t6UoB+hzYM/EyiNCGLnETS6NkMdGhrhdj4pggfkT6ta1i6/Aco9XByAJILYW/vBM9Bdh0jh5
        QkQHgAQithee8TO3hEHShFuMLCpQFhvOyDuAM4GKHYTH/NMvi8gQaQxzg2GiGdn/KY+wclIA
        4WR/keezVElhQicik5x2XDi7pGA9DDk1h9/71vQ2lZ6rGTPcdnW56hwTsOg3Gxivi4/dc9Gn
        8sLJ8Ko36gJJQ1flPXDXxiU74Yh7xrytMDj7r0bygWd6yTr2qAq+pybVR3t7E2Bv1xxRPXvl
        q7XdU6VuxqRV2tTou1kbNjhMjMpDpR77EZlc+g+GBP60gAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xa7pr/1VHGfS85rfoPXeSyWLjk9OM
        Fk0db1ktmg6dYrP4dK+fzWLTx/esFle+vmez+P/oNavF3Em1Fp0Tl7BbbHp8jdXi8q45QGUP
        /jNbPGh5wWpx5uoBFov2zlY2BwGP2Q0XWTwu9/UyeeycdZfdY3bHTFaPO9f2sHls//aA1eN+
        93Emj81L6j3+ztrP4rH92jxmj6c/9jJ7fN4kF8ATxWWTkpqTWZZapG+XwJWx4PVT1oK5LBX7
        L95lbWBczNzFyMEhIWAicXqiVRcjJ5ApJnHh3nq2LkYuDiGBJYwSnU2ToJxnjBKr/h1hBKkS
        FvCSeHNgLjtIQkSghUVi79ObYFXMAk2MEle+7mKHaOljlPi2cz8zSAubgKbE380gVZwcvAJ2
        EldnTmMFsVkEVCXObfrGDmKLCkRIdK6czwJRIyjxY/I9MJtTwFJiZmc/2K3MAuoSU6bkgoSZ
        BeQlNq95ywxhi0s0t95kmcAoOAtJ9yyEjllIOmYh6VjAyLKKUSS1tDg3PbfYUK84Mbe4NC9d
        Lzk/dxMjMGK3Hfu5eQfjpY3BhxgFOBiVeHg/WFZHCbEmlhVX5h5ilOBgVhLh9fQBCvGmJFZW
        pRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl4uCUamD0mt5R9IutIzzxYci5
        O3uMTTwkPLgv/vsTm7568TPL3dku+V7qD1yXT5XLbhFssn5fHTHnYaqfnJRTgNPJgJfVslIq
        h2/9nzxtUcjGUnn7J1UHAkXt5blMf+p9WzxjlsyUg7cy3yrm5Hp5bXjeobjCr397ud9DdWb9
        ChGxdb7ZxZfj/wgt/6HEUpyRaKjFXFScCADfNIQ51AIAAA==
X-CMS-MailID: 20180208073925eucas1p182e0fbcd5959c28f4d0eb08fd65bf0fe
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf
X-RootMTR: 20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf
References: <CGME20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf@epcas1p3.samsung.com>
        <20180206084251.303-1-philippe.cornu@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.02.2018 09:42, Philippe Cornu wrote:
> Add support for the Synopsys DesignWare MIPI DSI version 1.31
> Two registers need to be updated/added for supporting 1.31:
> * PHY_TMR_CFG 0x9c (updated)
>   1.30 [31:24] phy_hs2lp_time
>        [23:16] phy_lp2hs_time
>        [14: 0] max_rd_time
>
>   1.31 [25:16] phy_hs2lp_time
>        [ 9: 0] phy_lp2hs_time
>
> * PHY_TMR_RD_CFG 0xf4 (new)
>   1.31 [14: 0] max_rd_time
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
Queued to drm-misc-next.
--
Regards
Andrzej
