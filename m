Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbeCHLkA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:40:00 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:26201 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935072AbeCHLjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:39:53 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180308113950epoutp013168edb3c6913f26d91b0c115748063c~Z7w2VucTv0592305923epoutp010
X-AuditID: b6c32a45-3ebff70000001023-04-5aa12105576d
Subject: Re: [PATCH 4/4] ARM: dts: Enable HDMI audio on Snow Chromebook
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <00f84b39-3272-72ca-5991-bc0f839a0324@samsung.com>
Date: Thu, 08 Mar 2018 12:39:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180307172711.15697-4-s.nawrocki@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7bCmmS6r4sIog9ktGhYbZ6xntZh/5Byr
        Rf/j18wW589vYLfY9Pgaq8XlXXPYLGac38dksfbIXXYHDo9NqzrZPDYvqffo27KK0ePzJrkA
        ligum5TUnMyy1CJ9uwSujN7eGawFC5grJl9axtbAeJCpi5GTQ0LARGLWnE+MXYxcHEICOxgl
        Hn1tYoFwvjNKPJj9FMjhAKva+SUDIr6BUaJl11WojvuMEhMe9LGBFAkLuEvs2SkBMlVEQFji
        3tLl7CA1zAIXGSXO3b7BDJJgEzCU6D3axwhi8wrYSexesJ0VpJdFQFViw95akLCoQITEwqlP
        oUoEJX5Mvgd2A6eAjcT0i3IgYWYBTYkXXyaxQNjiEsfu32SEsOUlNq95ywyyVkLgMpvE1DXP
        2CG+dJE4vWUz1MfCEq+Ob4GKS0s8W7WREcKuluhs62KHaG5hlPgz7RIbRMJa4vDxi6wQG/gk
        Og7/ZYcECq9ER5sQRImHxIe9Z1khbEeJi8f2gs0UEjjIKHHvjNUERrlZSN6ZheSHWUh+mIXk
        hwWMLKsYxVILinPTU4uNCgz1ihNzi0vz0vWS83M3MYLTiZbrDsYZ53wOMQpwMCrx8Er8mR8l
        xJpYVlyZe4hRgoNZSYQ3RHZhlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHetgCXKCGB9MSS1OzU
        1ILUIpgsEwenVAOjcm6f1/3daYn7u1a96zre9TZd79pqrkPN6lekQk4I7GGznno+mJvj+Un1
        Yzf5S8wmMNzITOo8ytDYVMe+4PD/a6L5Eru/v7eQVYhevESxsWD2ke/rC6uu+XXyPZvSt3Pz
        mXfv/st4PGn/Nt/cMeD49ibR/lcOAeUOn8pMG5bvcnh/brHJjJ3TlFiKMxINtZiLihMBxjZT
        +SMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t9jQV0WxYVRBqs2K1lsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9kdODw2repk89i8pN6jb8sqRo/Pm+QC
        WKK4bFJSczLLUov07RK4Mnp7Z7AWLGCumHxpGVsD40GmLkYODgkBE4mdXzK6GLk4hATWMUrc
        7lvN2MXICeQ8ZJRobmABqREWcJfYs1MCJCwiICxxb+lydpB6ZoGLjBJfL7ezQzQfZJTovrSO
        BaSKTcBQovdoH9ggXgE7id0LtrOCDGIRUJXYsLcWJCwqECHRuXI+C0SJoMSPyffAdnEK2EhM
        vygHYjILqEtMmZILUsEsIC5x7P5NRghbXmLzmrfMExgFZiFpnoXQMQtJxywkHQsYWVYxSqYW
        FOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgSG/rbDWv07GB8viT/EKMDBqMTDK/FnfpQQa2JZ
        cWXuIUYJDmYlEd4Q2YVRQrwpiZVVqUX58UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQW
        wWSZODilGhiFdIr/Htg/hb3cRyJXe0KrYOvzNob/Wems71Y/SVjGf23pSt2vE6taJ/ybzHhy
        qcKN9WYLpuzTW2q19XWZZqn8SuaPNz+53JVbcl8mw7bwzvZz1/kWbttamT2pbJ2U0aq2DRFr
        gx6+nHB/hWb9Bf4FKzl6JzCcauASCzrX0jF/leq5zwyTuFYJKbEUZyQaajEXFScCAJ5gaTN5
        AgAA
X-CMS-MailID: 20180308113948epcas2p20694cc9eea65530163c76b3b8a6b6a26
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420
X-RootMTR: 20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420
References: <20180307172711.15697-1-s.nawrocki@samsung.com>
        <CGME20180307172742epcas2p2c0ef2394412da71b6d0ee172c47c3420@epcas2p2.samsung.com>
        <20180307172711.15697-4-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 06:27 PM, Sylwester Nawrocki wrote:
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -18,6 +18,14 @@

> +		cpu {
> +			sound-dai = <&i2s0 0>;
> +		};
> +
> +		codec {
> +			sound-dai = <&hdmi>, <&max98095 0>;

Oops, I need to change order of codecs on the list, so it matches
documentation. Will post v2 shortly.

-- 
Thanks,
Sylwester
