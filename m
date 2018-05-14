Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeENWUs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 18:20:48 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:37720 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752290AbeENWUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 18:20:35 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180514222033epoutp02bb3d69f9f3739a0f6970b4a0e15292b6~uouY6bgTW2989929899epoutp02c
X-AuditID: b6c32a46-145ff70000001024-f3-5afa0bae8c88
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFA0BAD.1050005@samsung.com>
Date: Tue, 15 May 2018 07:20:29 +0900
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 02/10] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
In-reply-to: <20180514211610.26618-3-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbVRz23Dcb1WvH8AQNj5v4BywU2rvKwQwf25xX5Q+SZXNhLuUGbgBp
        b2tvIWJQO80ePDZgksVU7WZkcUOyRztHJ5LFrpGxSAWnDOUxsAsZMEIYg+ED8LaXxf11fr/v
        fN/5ne/LOQyun6SSmHLZJTll0cpR64hLV9NR5tn1fxdmr4bWoyPhHgxN+b+n0IlQmES/LsxS
        qH0oCNDqn9Mk+uLY+2jp/HUc+cMNJOr96C6NfJEBEs01jJLoxnefU2j+SAige2OrODp1sx9D
        /ddfQUP7T1PoQFeIRisDFwg0cr4XoMm5a8RLiUK7tx0Is4MHaOEzdz8hBEZageBrq6WEjsUx
        UrhV340J/tYPhWXPFUI4erENCB0DXlyY9yUXxBdKW8oksURypkpysb2kXC7N497YadlmMT+X
        bcw05qIcLlUWbVIetz2/IHNHuVV1zKVWidZKFSoQFYXLemGL017pklLL7Iorj9trNJoMxuwc
        g8mkrvy+501mlVIklS02e2nHD3HvRlbuYG4wQ9eBOAaym+FwpAvUgXWMng0AODu+RGjNAwDP
        +iaIh6wezyqpbXQC+M+tWjK6oWOfhEufjKokhsHZFBj6pSIK42w6/LbzHK3xRwA8/e8opfEz
        4JTbHxtNsM/CcCQQqykVv3JnMMZ5gk2Dvy1FQLTeyO6Bl08sxg5KYBtxOF/7MaZNaFCbn2O3
        28C+BRu7/TFxHLsVfrNyn4oKIDtDw/0985hmYTus72sGWr0BTnVfXAvgaTjRdgFogkMAHury
        4lrTAmD45uiamocTX9atjX4cHr66TEc9Q1YHDx/UaxQB/tH5Fa7VL8O62xOY5r8XQM9QE94E
        kj2PROb5PzLPI5GdBHgbSJQciq1UUkwOk0ERbUqlXGoottt8IPbMM3YEQGs4PwhYBnDxuqLj
        fxXqSbFKqbYFAWRwLkHXaVIhXYlY/Z7ktFuclVZJCQKzmngznrSx2K5+GtllMZpNPM8jc04u
        n53LPaVr5xYK9Wyp6JIqJMkhOR/qMCYuyQ2yQg3mY7bhbdZx+tXJxI53hn8/+iPzuoW91HS7
        pqU8eeHT9Bf7xmueSe9TItWb3VVZI/rdfELGmfgHgZz8N83+Dzok7/B95etryz9NDvbcTUiR
        /ZeDKZuwvS1VMy38nEyc1N8Yn16491hF/e5TBzdN8zNvp+0a22c44y/a2uhIq3mNI5Qy0ZiB
        OxXxP85dvd78AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t9jAd213L+iDJ6t1bToPXeSyeLV5j1s
        FvOPnGO1uPL1PZvFmtuHGC3+P3rNajF3Uq3Fjw2nmC02n+thtTjb9IbdYtPja6wWH3vusVpc
        3jWHzeJz7xFGi08P/jNbLL1+kcni4ilXi9uNK9gsWvceYbf4d20ji8XdDWcZLV5+PMHiIOax
        Zt4aRo/3N1rZPWY3XGTx2HF3CaPHplWdbB7bvz1g9bjffZzJY/OSeo+/s/azePRtWcXosf3a
        PGaPz5vkAniiuGxSUnMyy1KL9O0SuDK+TZzHXnCQs+LxvxdMDYxv2bsYOTkkBEwkTs76z9rF
        yMUhJLCTUeL0x0dMIAleAUGJH5PvsXQxcnAwC8hLHLmUDRJmFlCXmDRvETNE/X1Gicl79kPV
        a0m8atgMNpRFQFXi3OMdYDYbUHz/ixtsIDa/gKLE1R+PGUFmigpESHSfqASZIyLQzywx7doZ
        RogFPcwSM5bLgtjCAjES/cc3s0EsO8sosWMmyKWcHJwCThKr/31hm8AoMAvJrbMQbp2F5NYF
        jMyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECY3jbYa3+HYyPl8QfYhTgYFTi4U2Y
        9jNKiDWxrLgy9xCjBAezkgjvbiOgEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp
        2ampBalFMFkmDk6pBkZ3tqt7TG6K+S9RdJkjlKG9Xb70bvH7Z5uLuvJ8Pm97kOuwTjXh/kbj
        E2IP7H6G65usfRL1cUbldMvLPLwWD6R0s5XjU1zkNgXr+wi0rrfzrula4TTvQda1R4mT+UJK
        HiYoGs/ROWPSZ5/cYxa/NfyYswRH7HFNiUOHW17qfT/oM6P99OTvvkosxRmJhlrMRcWJAGKj
        yTXdAgAA
X-CMS-MailID: 20180514222029epcas2p40ecb3802b0bd1cf2416b4d39fcd7ba7b
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180514211906epcas4p2a4f34ce55a219a102e11de32be23e511
X-RootMTR: 20180514211906epcas4p2a4f34ce55a219a102e11de32be23e511
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
        <CGME20180514211906epcas4p2a4f34ce55a219a102e11de32be23e511@epcas4p2.samsung.com>
        <20180514211610.26618-3-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 15일 06:16, Enric Balletbo i Serra wrote:
> The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
> general register files to know the DRAM type, so add a phandle to the
> syscon that manages these registers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index 0ec68141f85a..951789c0cdd6 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -12,6 +12,8 @@ Required properties:
>  			 for details.
>  - center-supply:	 DMC supply node.
>  - status:		 Marks the node enabled/disabled.
> +- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
> +			 files".
>  
>  Optional properties:
>  - interrupts:		 The CPU interrupt number. The interrupt specifier
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
