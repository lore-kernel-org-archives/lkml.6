Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeCICkd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:40:33 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42215 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeCICka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:40:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180309024028epoutp043883183f1ada87c907844e60fdba6e01~aIDMbTw_e0062000620epoutp04b
X-AuditID: b6c32a35-891ff70000001031-cf-5aa1f41b3fdd
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AA1F41B.5080104@samsung.com>
Date: Fri, 09 Mar 2018 11:40:27 +0900
From: Inki Dae <inki.dae@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH 1/4] ARM: dts: exynos5250: Add #sound-dai-cells property
 to hdmi device node
In-reply-to: <20180307172711.15697-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO7v3zjtpcZuPDkalN/wjy7k7X1fTMBq1SGMQhCxCb9thE92j
        3S3SnkTplPBNikRmjh5CVNPCmVhNwyza6B1o9qIYFmVlWUjR3W5R/33P73x+53x/X34kppgh
        EsgyqxM5rFwFLY3GrwyvUKYununSq4JPVrGX2i8QbOdIgGAbXr/D2GDwYhTrff2YYB8MHJey
        7cEhCXt+5FkUO/y+hiiQab09tVJtr+eAtr6vB2i/eJfqcD3KMyPOiByJyGqwGcuspnx605aS
        dSWZWSomlclhs+lEK2dB+bSmUJe6vqxCsEIn7uIqXEJJx/E8nbYmz2FzOVGi2cY78+ltDKNW
        MqpspVqtVmakb89VZwpIKTJ3N4dw+0dyty8QwA+C1qg6ICMhlQFD7hpBR5MKqh/Ar7OnCfEw
        C2DPLx/2lzpy6jMmXlwFMNTuA+ELObUQfm+ZxOsASWLUMjhyvzxcxqgVMDTTjIv8JIDumqdE
        mJFTKXDyYXyYwalkeLn5hSSspYJuOvtcGtZxVDH0dX6LuIulCuDoz9rIOxh1D8DA+NOIoRhq
        B5x+1RnRMioPdk20RSBI3ZLC6kE3LrrWwEPX+ghRx8Cp0b6osAlILYb3b+aLfA2AA3efSMXD
        UQDPdJ/6E0w6fNtVJxHHWQA/fD1KiM1y6K5WiIgW1t+48+evtbBx/JNEnLgBwPG79XgjWNLx
        X0gd/0Lq+C+kkwDrAfHIzltMiGfsjJLnLLzLalIabBYviGxcSmY/aA0U+gFFAnq+nNV06RUE
        t4uvtPgBJDE6Vn77nFCSG7nKKuSwlThcFYj3g0wh5CYsIc5gE/bX6ixhMnJUGVlqYadyGIZe
        JNfpNHoFZeKcqBwhO3L87ZOQsoSDYIvHn1V7+Fh9Q65+7s1bQ+tcXvVQUtyE8fqeyv1FJ8b3
        Fg+OuV/tbKnaPDyvIDf2hjnF55pSWZZ/QJ+3rj45k7Qhzj7teWQcC2pNyT+KmtpaQpy/9Etz
        74Crkd/oNbzvzJ3d53EvOrz+R9XzubSVhQMe1Vj/S//kgQ2yfa6ifs02GufNHJOCOXjuN+SW
        WvqHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t9jAV3pLwujDH5/krXYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vFpsfXWC0u75rDZjHj/D4mi7VH7rJbHH7TzurA6bFpVSebx+Yl9R59W1Yx
        enzeJBfAEsVlk5Kak1mWWqRvl8CVsXjSC5aC9xwVO8+dY2lgnMLexcjJISFgItG66BNzFyMX
        h5DATkaJf2uvsIEkeAUEJX5MvsfSxcjBwSwgL3HkUjaEqS4xZUouRPkDRomd7ZuZQOK8AloS
        966IgXSyCKhKbJ30gAnEZgOyJ664zwZSIioQIdF9ohIkLCLgIHH8bycLyBhmgYuMEl8vt4Od
        IyyQJNH7agobxPyJjBKNB2+wgCQ4BWwkFt6ZzjKBkX8WkutmIVw3C+G6BYzMqxglUwuKc9Nz
        i40KDPNSy/WKE3OLS/PS9ZLzczcxAsN622Gtvh2M95fEH2IU4GBU4uG1cFkYJcSaWFZcmXuI
        UYKDWUmE99RKoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe23nHIoUE0hNLUrNTUwtSi2CyTByc
        Ug2MGjunNGnd8Pn+eB3z++Yg3puBHaUfZGv1fRMLsiVjF2Wf7d8n9ygzKbHs5szCK5uzzLZ+
        KnXx/y0l8zG2foNrWvO0PY497O2ptjG2va8W3tkgsOb0sue1PYr3b7YdP7NTaHLbL56FKp6H
        T/bIL9NwWr/oj3fQNJPkT7Pc0m8/WMBhVrHGuVhciaU4I9FQi7moOBEABAINE2cCAAA=
X-CMS-MailID: 20180309024027epcas1p1f2ded854d7a0119913fdb64172f3c451
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
X-RootMTR: 20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56
References: <CGME20180307172723epcas1p1b8879bb555737cab7406a172b7d13a56@epcas1p1.samsung.com>
        <20180307172711.15697-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

2018년 03월 08일 02:27에 Sylwester Nawrocki 이(가) 쓴 글:
> This property is required for specifying link between the HDMI IP block
> and the SoC's audio subsystem.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 56626d1a4235..71d2ede118e3 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -700,6 +700,7 @@
>  					"sclk_hdmiphy", "mout_hdmi";
>  			samsung,syscon-phandle = <&pmu_system_controller>;
>  			phy = <&hdmiphy>;
> +			#sound-dai-cells = <0>;

This patch adds this property to hdmi device node which is bound by HDMI driver of Exynos DRM. As we talked about this at other email thread, seems this property is required mandatorily for Odroid XU3/4 board which uses Exynos5422.
There may be something I'm missing so could you let me know how this property is required?

Thanks,
Inki Dae

>  			status = "disabled";
>  		};
>  
> 
