Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeBWAaM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:30:12 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:55081 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751723AbeBWAaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:30:09 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180223003007epoutp012c11726d8123aa2416f27d7fe900e649~VzPY006_b0299502995epoutp01o
X-AuditID: b6c32a48-9adff70000000ff0-f3-5a8f608e99c2
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A8F608E.4030509@samsung.com>
Date: Fri, 23 Feb 2018 09:30:06 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] ARM: dts: exynos: Fix address of PPMU ACP on
 Exynos4210
In-reply-to: <20180222191111.23747-1-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nOjpfZaVp9Wdk8EKHgcmvTY2oUSQ0MsvojK1knPWzLXWRn
        s/SPItLmyEsUYWZaogWT8DrL7KqrTEIxMy/lMgYWKWVIOgWjzbPIf8/7vs/zXh5eDBFeRiMx
        rcFMmwyUjkCDuV19MfK4irOVyvifXwmyrbqFR9a7BnlkpWcWIYeGWvlku+cDjxx5VIuS1UNP
        OeR91xSfbLm+zCP75qy8g8GK7popvqLdUYYqOhqLFBWdDqBYaI/K4CnpFA1N5dAmEW3INuZo
        DepUIv2U6rBKnhAviZMkkYmEyEDp6VQi7VhG3BGtzrcUIcqndBZfKoNiGGLvgRST0WKmRRoj
        Y04lTkskUrEkPlEslUrFsn1Z+6VyH+UsrSn/YEPypsMuziyNg2IwG2IHQRjEZXDk01OOHQRj
        QvwhgD2tAygbLAH44msT8o9VPP2AzxZaAaz9VY36CwJ8E/RedXPtAMMQfBd0vcv1pxE8Bjp7
        WgJ8N4Du/iouy4+Fqwt1HD/m4rvh8J8vfD9Gffln38bXem7Eo+Go1wP8eDOeCbvrF9caReAT
        HNjWOsFhJ5DQ6WxeE4fjJ+EPazPPj4NwOfw46uL6BRD3oPBt+S3AnpAGX/Y7+SwOh99fdwbw
        djjjaAOswAqg9UkdwgbXABwcc3NY1j44c8ceGB0GbX2rfP/NEBdA2yUhS1FAt2MhQD8Elxvs
        ASNtAE41VIAqEFWzzrKa/5bVrLPsNkAcYAudx+jVNCPNk4kZSs9YDGpxtlHfDtY+MVbxEDwf
        PNYLcAwQoYJMc7lSyKPymQJ9L4AYQkQIHgsrlUJBDlVQSJuMKpNFRzO9QO5z/AoSuTnb6Ptr
        g1klkSXFyxISpIkJpO/HtgouZaQphbiaMtO5NJ1Hm/7pOFhQZDFIW3J6u7usaru0VFkyVlI0
        N8Bt2nA69mjTHmJHqSr9zWI46k3e+VtXqEq2FbTNzRadx1bOeA6f8JZZNArkuBkdndQ2EKtR
        k5njjRrTe7tI21SbJZ93LYdmR29ZQp3no0cbZ+fNG0Nibp67EXmua/p59Wfu8LZ7Kx3jcXdf
        XWgmuIyGksQiJob6C5NNQNOfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t9jQd2+hP4og/87uS02zljPajH/yDlW
        i/7Hr5ktzp/fwG6x6fE1VovLu+awWcw4v4/JYu2Ru+wW66f9ZLU4/Kad1YHLY+esu+wem1Z1
        snlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBm91zqYCx7wVTz7foOxgfE1dxcjJ4eE
        gIlEw4Pt7F2MXBxCAusYJVacPcEMkuAVEJT4MfkeSxcjBwezgLzEkUvZIGFmAXWJSfMWMUPU
        P2CUODn3OTtEvZbE38/zmEBsFgFViYv/HoLF2YDi+1/cYAOx+QUUJa7+eMwIMlNUIEKi+0Ql
        yBwRgdtMEl+uTGKGWGAhsXXrarBeYYEAib33l0Id18UoMe1xI1gRp4CpxO2rR1gmMArMQnLr
        LIRbZyG5dQEj8ypGydSC4tz03GKjAqO81HK94sTc4tK8dL3k/NxNjMBI2HZYq38H4+Ml8YcY
        BTgYlXh4I0p6o4RYE8uKK3MPMUpwMCuJ8O4R6o8S4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsuf
        fyxSSCA9sSQ1OzW1ILUIJsvEwSnVwJjB5LmFR2jl16PMqikHHsa5Pcnq1kqZp858lKd5Et9K
        jtIlFVOu/msz5FgTf/vVcfOJizSnhMztbUhn0nhQplVl2KHo7iN34XOkuJq3JfctHSmbxcu0
        wg7cPqtYHK+YzXHhgfJpg/Ysm8e9wTddnk2+Ii15bvtPdc0yzW2FC0WcSgPtemMNlViKMxIN
        tZiLihMBye/A5IACAAA=
X-CMS-MailID: 20180223003006epcas2p193e4a09e17d6c5611941d17ecaf586ed
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180222191146epcas2p1e0fc10e3f8b278f0c3671d32e2d76350
X-RootMTR: 20180222191146epcas2p1e0fc10e3f8b278f0c3671d32e2d76350
References: <CGME20180222191146epcas2p1e0fc10e3f8b278f0c3671d32e2d76350@epcas2p1.samsung.com>
        <20180222191111.23747-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 23일 04:11, Krzysztof Kozlowski wrote:
> Typo in unit address of PPMU ACP caused DTC warnings:
> 
>     arch/arm/boot/dts/exynos4412-odroidu3.dtb:
>         Warning (simple_bus_reg): Node /soc/ppmu_acp@10ae0000 simple-bus unit address format error, expected "106e0000"
> 
> PPMU ACP (under 0x10ae0000 address) is present only in Exynos4210 so
> move this node to exynos4210.dtsi with fixing the reg address to proper
> one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4.dtsi    | 6 ------
>  arch/arm/boot/dts/exynos4210.dtsi | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 967cd02401c5..909a9f2bf5be 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -821,12 +821,6 @@
>  			status = "disabled";
>  		};
>  
> -		ppmu_acp: ppmu_acp@10ae0000 {
> -			compatible = "samsung,exynos-ppmu";
> -			reg = <0x106e0000 0x2000>;
> -			status = "disabled";
> -		};
> -
>  		ppmu_rightbus: ppmu_rightbus@112a0000 {
>  			compatible = "samsung,exynos-ppmu";
>  			reg = <0x112a0000 0x2000>;
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 853604d91158..88fb47cef9a8 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -162,6 +162,12 @@
>  			iommus = <&sysmmu_g2d>;
>  		};
>  
> +		ppmu_acp: ppmu_acp@10ae0000 {
> +			compatible = "samsung,exynos-ppmu";
> +			reg = <0x10ae0000 0x2000>;
> +			status = "disabled";
> +		};
> +
>  		ppmu_lcd1: ppmu_lcd1@12240000 {
>  			compatible = "samsung,exynos-ppmu";
>  			reg = <0x12240000 0x2000>;
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
