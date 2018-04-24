Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeDXDzO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:55:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:26822 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932729AbeDXDzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:55:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180424035509epoutp016f7faee70ba690bf8393bdb572690a7d~oQviWn1o33264632646epoutp017
X-AuditID: b6c32a39-8a5ff70000000fed-28-5adeaa9a86b9
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ADEAA99.1040903@samsung.com>
Date: Tue, 24 Apr 2018 12:55:05 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org,
        dbasehore@chromium.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lin Huang <hl@rock-chips.com>
Subject: Re: [PATCH 5/6] devfreq: rk3399_dmc: do not print error when get
 supply and clk defer.
In-reply-to: <20180419104019.24406-6-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOzlqr49T6sLB1QEjD5dlanqKF3Q8kYQQVq1gH/VDRbbIz
        u0JpF6sxw+jKstSKkCVp3lqmFdtSEhW8VohSWWmaQVRmidXZTlG/vvd93uf5eN6Hl8DUxXgU
        kWl1ILuVy6bwGdJ6f2x8vNszaEoYex7BjNY04kxJoEPGVPT7APPr9ZiMmaxqxZiaDpeMaT/6
        Qc50NxTjzOfCAGD688tx5kRTQJ6kZK/kdUpZ78BNwFZ7TuPstPuRlD1T6wHsvb5rGPu5OjpF
        bkIrMxCXhuwaZE21pWVa043Upq3mtWbDsgQ6nl7OJFIaK2dBRmpdckr8hsxswSSl2ctl5wpQ
        Csfz1JJVK+22XAfSZNh4h5HaSdM6LZ2QqNXphFe/e4XOIFD2oIySGhfIuavcX17ol+WB6won
        UBCQXAonGhqAE8wg1KQXwMAxPy423wBs9l/G/7LG6/Ik4qAKwKPN+VhwoCLD4OS5QakTEARG
        LoCBrqwgjJGxsO5BpVzkDwDY8eUsLvLj4Jj3dKiWkjHwk+spCNa4gD8aeR7CZ5MLYe/kUAiP
        JHfA+yUToY8iyOMAfmyaDrnAgl5fuYbkQVY4ycFjLeMhRwpyDex8VRZSQHIKhy9GujFxh3Vw
        fLRfItbhcLSlVh60Dcl5sOuJUeSfBPBk0zVMbM4Lvp8N/hHo4bsyp0Rcbhb8+NUlE8UqeKpA
        LVJYWNs49Ye+GrbduY2J+7cLTrunpUUg2v1fZO5/kbn/i6wUYB4wB+XwlnTE0zkGLc9Z+Fxr
        ujbVZqkGocuMW+4FzR3JPkASgJqpKv0+YFLLuL38AYsPQAKjIlRN0YMmtSqNO3AQ2W1me242
        4n3AICR+FouKTLUJd251mGmDTq/XM0vpZQaapuaq3ia3mdRkOudAWQjlIPtfnYRQROUBtvdI
        48YGRWuJH3RFxbyZKkqqMnQm/NjW/bCyrsd52VqRFN73tnToaf36l4erKS7mfItxfuKKF32w
        cMsF0mspQou/tN+IUf5Mqk+eDCtghjfzLcp2o89+qMwRt68sc8mvq5dGhrXFwwVPFm3pUb2/
        Ml9yMfbWD/NEgeZB/vZd3x5TUj6Do+MwO8/9Bthu0n+vAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t9jQd2Zq+5FGTy+Y2nxavMeNov5R86x
        Wqy5fYjR4v+j16wWPzacYrbYfK6H1eJs0xt2i8u75rBZfO49wmhxu3EFm0Xr3iPsDtwesxsu
        snjsuLuE0WPTqk42j7+z9rN49G1Zxeix/do8Zo/Pm+QC2KO4bFJSczLLUov07RK4MuZv7mEs
        2MhdsaL3MGsD4yLOLkZODgkBE4m3WxuYuhi5OIQE1jFKLL/czgKS4BUQlPgx+R6QzcHBLCAv
        ceRSNkiYWUBdYtK8RcwQ9fcZJe5uXs4KUa8l8XpHJxuIzSKgKvGx5yQjiM0GFN//4gZYnF9A
        UeLqj8eMIDNFBSIkuk9UgoRFBFoYJc79cwGZySywg1Hiz97ZYPXCAokSzcffQi07yyjx6NFz
        sGWcAk4SFx8uZJ/AKDALya2zEG6dheTWBYzMqxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLz
        czcxAiNl22Gtvh2M95fEH2IU4GBU4uFd8PNulBBrYllxZe4hRgkOZiUR3r1y96KEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYLQLL3pzhPGg1eok2d0P
        TZS239jz59D7y6x2D8o0s7612s0PWMV2IKvJL/DtS0ur/F71hEbTkAufA4SDDOv3X5/isECh
        Ujl0scrM340xW4u+xv93U8lYGxJ6X/W5VsCPRZ1vLwmwJ95MvDMl+KWj/E0bNoVPNxXe9vTs
        zbZLsD8cIGtQdZ57khJLcUaioRZzUXEiALxUZDaQAgAA
X-CMS-MailID: 20180424035506epcas1p25aa8d806e94532f671171905890cf3e6
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180419104226epcas4p42e5d6a66c909325cedcdc1e24bd9007d
X-RootMTR: 20180419104226epcas4p42e5d6a66c909325cedcdc1e24bd9007d
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104226epcas4p42e5d6a66c909325cedcdc1e24bd9007d@epcas4p4.samsung.com>
        <20180419104019.24406-6-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> We just return -EPROBE_DEFER error code to caller and do not
> print error message when try to get center logic regulator
> and DMC clock defer.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/devfreq/rk3399_dmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 44a379657cd5..5bfca028eaaf 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -308,12 +308,18 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  	data->vdd_center = devm_regulator_get(dev, "center");
>  	if (IS_ERR(data->vdd_center)) {
> +		if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
>  		dev_err(dev, "Cannot get the regulator \"center\"\n");
>  		return PTR_ERR(data->vdd_center);
>  	}
>  
>  	data->dmc_clk = devm_clk_get(dev, "dmc_clk");
>  	if (IS_ERR(data->dmc_clk)) {
> +		if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
>  		dev_err(dev, "Cannot get the clk dmc_clk\n");
>  		return PTR_ERR(data->dmc_clk);
>  	};
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
