Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeBBAcq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:32:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39010 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeBBAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:32:39 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180202003238epoutp017eec8b52289936f49a46f42c1c08111c~PWumKT9kR1957119571epoutp01D
X-AuditID: b6c32a46-3c1ff70000001029-ad-5a73b1a6c70b
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A73B1A5.5000907@samsung.com>
Date: Fri, 02 Feb 2018 09:32:37 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: int3496: process id-pin first so that we start
 with the right status
In-reply-to: <20180125193919.1084-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmhe6yjcVRBsfa2CzeHJ/OZHF51xw2
        i9uNK9gcmD3e77vK5tG3ZRWjx+dNcgHMUak2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2StGGhkZ6
        hgbmekZGRnomxrFWRqZAJQmpGd37P7MVzOarOPY2oIHxDHcXIyeHhICJxM7WWWxdjFwcQgI7
        GCVa9k2Dcr4zSsxtXMQEU9U34ykrRGIDo0R36zkWkASvgKDEj8n3gGwODmYBeYkjl7JBwswC
        mhJbd69nh6i/xyhx6dwFRpAaXgEtiYOLGUFqWARUJd5snAE2hg0ovP/FDTYQm19AUeLqj8dg
        NaICERI7539jB7FFBIIkbnxfwQoxX0Hi171NYLawQLJE3/N1bCDjOQUsJObcUwFZKyGwgE3i
        0uRTbBD3u0hsv7WNHcIWlnh1fAuULS3xbNVGRoiGdkaJ9r3zmCGcKYwS567fg/reWOLZwi4m
        iM18Eh2H/7KDbJMQ4JXoaBOCMD0kLnQpQFQ7Smxb0wgNq25Gid5zK9knMMrNQgquWYjgmoUU
        XAsYmVcxiqUWFOempxYbFRjpFSfmFpfmpesl5+duYgQnLC23HYxLzvkcYhTgYFTi4U2QLY4S
        Yk0sK67MPcQowcGsJMJ7pRsoxJuSWFmVWpQfX1Sak1p8iNEUGNwTmaVEk/OByTSvJN7QxNLA
        xMzMyNzMApi8xHlbA1yihATSE0tSs1NTC1KLYPqYODilGhhvyOqumqR286k12/2v9nsXFaa5
        RWrNVPVkS/705/CEaL/HAo8UvfVeC805x6AWbj19cp152KVMppCVQkLRV2d5Ob2aZnPKbe5x
        7vsbXc0sk/53fxIwyJ22b732ZOM3T7I8lUvFH99YtfHyq+7IFuEL+flil7fWTgv5JKP2SFrh
        v8JJP231k85KLMUZiYZazEXFiQBHUPcWbgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsVy+t9jQd2lG4ujDLZdN7Z4c3w6k8XlXXPY
        LG43rmBzYPZ4v+8qm0ffllWMHp83yQUwR3HZpKTmZJalFunbJXBldO//zFYwm6/i2NuABsYz
        3F2MnBwSAiYSfTOesnYxcnEICaxjlJjw5h4jSIJXQFDix+R7LF2MHBzMAvISRy5lg4SZBdQl
        Js1bxAxR/4BRYs3vy2A1vAJaEgcXg7WyCKhKvNk4gwXEZgMK739xgw3E5hdQlLj64zEjSLmo
        QIRE94lKkLCIQIDEz1P97BDjFSR+3dvECmILCyRL9D1fxwaxqpdR4tHlh+wgvZwCFhJz7qlM
        YBSYheTQWQiHzkJy6AJG5lWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIGBuu2wVv8O
        xsdL4g8xCnAwKvHwckgXRwmxJpYVV+YeYpTgYFYS4f26ASjEm5JYWZValB9fVJqTWnyIUZqD
        RUmclz//WKSQQHpiSWp2ampBahFMlomDU6qBcXFQesZRM5somT+xz6L1M2PO9UUIyH3le1Vg
        9mftC6X/83R2O5xQ8GoWu/+NsW8Kn0bW9NX985i+WHTXM59LMFrvoS/1IGHbZstjAVwVPpyN
        N4Pl+9KLZn/5ZHb782eBuL7+31XHusqffdzf9cht6zqzzr2d4jNiucuWyxab3Dq5q/DOr0P8
        SizFGYmGWsxFxYkAWBgDy1ACAAA=
X-CMS-MailID: 20180202003237epcas2p1d9a336d81b330158caf2fc6b2c431fc5
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180125193924epcas1p2d31c10f1552df00e572fe66ff9768591
X-RootMTR: 20180125193924epcas1p2d31c10f1552df00e572fe66ff9768591
References: <CGME20180125193924epcas1p2d31c10f1552df00e572fe66ff9768591@epcas1p2.samsung.com>
        <20180125193919.1084-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 01월 26일 04:39, Hans de Goede wrote:
> Some other drivers may be waiting for our extcon to show-up (exiting their
> probe methods with -EPROBE_DEFER until we show up).
> 
> These drivers will typically get the cable state directly after getting
> the extcon, this commit changes the int3496 code to process the id-pin
> before registering the extcon, so that other drivers see the correct state
> right away.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-intel-int3496.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index c8691b5a9cb0..b23ee9d993a3 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -131,6 +131,10 @@ static int int3496_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->gpio_usb_mux))
>  		dev_info(dev, "can't request USB MUX GPIO\n");
>  
> +	/* process id-pin first so that we start with the right status */
> +	queue_delayed_work(system_wq, &data->work, 0);
> +	flush_delayed_work(&data->work);
> +
>  	/* register extcon device */
>  	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
>  	if (IS_ERR(data->edev))
> @@ -153,9 +157,6 @@ static int int3496_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/* queue initial processing of id-pin */
> -	queue_delayed_work(system_wq, &data->work, 0);
> -
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
> 

Looks good to me.
How about adding the 'Fixes' commit id on patch description?
I think that your revert patch of axp288 and this patch
should be included in extcon-fixes branch.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
