Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeDXD4n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:56:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47098 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeDXD4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:56:40 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180424035638epoutp049e8b3cd64c80be2d34a987fdb9147656~oQw1XkZaU0521505215epoutp04L
X-AuditID: b6c32a46-145ff70000001024-7f-5adeaaf29e34
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ADEAAF1.9030901@samsung.com>
Date: Tue, 24 Apr 2018 12:56:33 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4/6] dt-bindings: devfreq: rk3399_dmc: remove interrupts
 as is not required.
In-reply-to: <20180419104019.24406-5-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3d3utmr2trQOCrYuBCm53NbcNbJv7EIFUgaxKLvNi1r7kN0Z
        aRBTKuew6It+rFAjA1lWpFYrW8lcSljDDD/AtOhDo6wg6Ztl271G/Xqfc97nPOech6Mg1OfI
        ZEWJ3cU57ayVImdIb3ammTI++0fNmZMTQL9rvUvS9eGIjG4eDiF66uV7Gd0aqZXRj6sm5PTT
        O+dJevJYGNGXBp9I6OHKJpI+EgzLV89kmuuaEXPO/UTKBEYaEdPiryGZ421+xNwaqCOYyZbU
        PLmZW1HMsYWcU8PZLY7CEntRDrVxa8G6AmNWpi5Dl02bKI2dtXE51PpNeRm5JdbYkJRmP2st
        i6XyWJ6nlq5c4XSUuThNsYN35VA7dDq9Vpdp0ur1sdewc7neGKPs5oqnhq5ISxsSDjyv8krc
        qHumFykUgJfBiw6ZF81QqHEAwdjvfqkYfEMw2N5MepFSIH31VE6z2hH0PIwQ8Q8VngPfT49K
        40oEXgDhvn3xNIHT4Eb7NbnIH0HgD1ZLRH46jAydlcexFC+CoU+9AiZj+ftvh4Rms/FC6P/+
        CsVxEt4Ot+u/CkKJ+DCCj8GoJB4Q+B6CLzfeCFPMxXtg4NkjQUmJ10JNoEfYAfAUCTWfI1Jx
        h/XQHX09vc9ceNfdJhdxCoz5ryOxoBpBdbCOEIMzCCKDoxKRZYCxC16JuF0CeDqjctE+FXiO
        qkUKA4EPV6cbrIGj528JWI0fx0R9yhMo1fefZb5/lvn+s6wBEX40jyvlbUUcry/Va3nWxpfZ
        i7QWh60FCYeZnhtAjZFNIYQViJqlavgxYlbL2P18uS2EQEFQiapg6qhZrSpkyys4p6PAWWbl
        +BAyxhw/SSQnWRyxM7e7CnRGvcFgoI2mbENmNjVf5d78yKzGRayL28dxpZzzb51EoUx2o/qq
        lCTknY1/ec+saR0OdHQlHLtiWuxLXAJbTk0e3BZYdSGlb9HPRqbSktWS7tkwp3fLeKfygdZz
        qKmztqLrqiWlr4leNuGync3ZOxjKrx3ftcS+bWFjx8b+nc9WWQcqyqMvHVldmmjb+JeesPPS
        rq0Ph2szejfAG5QbvJxw0Z1PSfliVpdOOHn2Dz7fvXyuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t9jAd2Pq+5FGbxdb2HxavMeNov5R86x
        Wqy5fYjR4v+j16wWm8/1sFqcbXrDbnF51xw2i8+9Rxgtll6/yGRxu3EFm0Xr3iPsDtwea+at
        YfSY3XCRxWPH3SWMHptWdbJ59G1Zxeix/do8Zo/Pm+QC2KO4bFJSczLLUov07RK4Mv7fWMtS
        sICv4n5TF1MD43HuLkZODgkBE4lvHY2sXYxcHEICOxklZu9dxgiS4BUQlPgx+R5LFyMHB7OA
        vMSRS9kgYWYBdYlJ8xYxQ9TfZ5TYuusMO0S9lsTdG9PAbBYBVYkb7y+A2WxA8f0vbrCB2PwC
        ihJXfzxmBJkpKhAh0X2iEiQsItDCKHHunwvITGaBfYwSGzu/gPUKCyRJnFl3gQli2VlGiYsP
        ZoMlOAWcJDp3nGaZwCgwC8mtsxBunYXk1gWMzKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS
        83M3MQIjZdthrf4djI+XxB9iFOBgVOLhXfDzbpQQa2JZcWXuIUYJDmYlEd69cveihHhTEiur
        Uovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTA6WZ/jv5zPIjHt5WXb
        nOVsCvc2BCQ/vPbk4jZ11ZOV9S1nnlZssj7FK1+gEXJVZfbLo0rKa3y2BFqL3+2rSJ/GqeS+
        1ajuaXvdm5ipb+zdP0+yYmo7e2aV2mXfBeumW+lJTG3UjYz0FXZYtECslXGGqOtx/yV1wv0B
        6qsW1zzqbXS9/2OzWaMSS3FGoqEWc1FxIgBDt/QqkAIAAA==
X-CMS-MailID: 20180424035633epcas2p3adb15f0f9aa3795e43307eb599a3c4b0
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104138epcas2p3e6a9246fa4abddb1ef5e358e8f3e9ee6
X-RootMTR: 20180419104138epcas2p3e6a9246fa4abddb1ef5e358e8f3e9ee6
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104138epcas2p3e6a9246fa4abddb1ef5e358e8f3e9ee6@epcas2p3.samsung.com>
        <20180419104019.24406-5-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> In ATF we already wait for DDR dvfs finish, so don't need to do this in
> kernel, so remove the interrupts properties as is not longer required.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index d83ef821d282..e5307155e901 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -5,10 +5,6 @@ Required properties:
>  - devfreq-events:	 Node to get DDR loading, Refer to
>  			 Documentation/devicetree/bindings/devfreq/event/
>  			 rockchip-dfi.txt
> -- interrupts:		 The CPU interrupt number. The interrupt specifier
> -			 format depends on the interrupt controller.
> -			 It should be a DCF interrupt. When DDR DVFS finishes
> -			 a DCF interrupt is triggered.
>  - clocks:		 Phandles for clock specified in "clock-names" property
>  - clock-names :		 The name of clock used by the DFI, must be
>  			 "pclk_ddr_mon";
> @@ -172,7 +168,6 @@ Example:
>  	dmc: dmc {
>  		compatible = "rockchip,rk3399-dmc";
>  		devfreq-events = <&dfi>;
> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&cru SCLK_DDRCLK>;
>  		clock-names = "dmc_clk";
>  		operating-points-v2 = <&dmc_opp_table>;
> 

The patch3[1] removes the code related to irq. So, Looks good to me.
[1] "[PATCH 3/6] devfreq: rk3399_dmc: remove wait for dcf irq event."

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
