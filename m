Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDMBMH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:12:07 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:43212 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753309AbeDMBMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:12:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180413011202epoutp0416a22d5120a69ff04239b506a4a5a896~k2a_7qyA60693406934epoutp041
X-AuditID: b6c32a47-0e3ff70000000fe8-08-5ad001c6e0c6
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AD001C5.2040406@samsung.com>
Date: Fri, 13 Apr 2018 10:03:01 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
In-reply-to: <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmme4xxgtRBq8ahC2u9S5ktjjb9Ibd
        4vKuOWwWn3uPMFrcblzB5sDqsXPWXXaPvi2rGD0+b5ILYI5KtclITUxJLVJIzUvOT8nMS7dV
        8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqmkUJaYUwoUCkgsLlbSt7Mpyi8tSVXI
        yC8usVWKNjQ00jM0MNczMjLSMzGOtTIyBSpJSM1ommVbMJ27Ys/MdWwNjE2cXYwcHBICJhJP
        WxW7GLk4hAR2MEr8WbuDCcL5zihx6+AHti5GTrCi7vUrWCASuxklFrw5wQiS4BUQlPgx+R4L
        yCRmAXmJI5eyQcLMApoSL75Mgqq/yyhxfMl/sBpeAS2JJ4utQGpYBFQlzpxpYwax2YDC+1/c
        ANvFL6AocfXHY7DxogIREjvnf2MHaRURSJZom6UJMd5KYtejPrASYQE3iR93e8FaOQWSJH68
        a2YEWSshsIZNYvWrRnaI+10krqxdBvWLsMSr41ug4tISz1ZthGpoZ5Ro3zuPGcKZwihx7vo9
        JogqY4lnC7uYIFbzSXQc/ssOCTpeiY42IYgSD4ln8+4wQ9iOEg1rF7JDPL+ZUWLqtscsExjl
        ZiGF1yxEeM1CCq8FjMyrGMVSC4pz01OLjQqM9YoTc4tL89L1kvNzNzGCk5iW+w7Gbed8DjEK
        cDAq8fAqVJ6PEmJNLCuuzD3EKMHBrCTCO/0xUIg3JbGyKrUoP76oNCe1+BCjKTC8JzJLiSbn
        AxNsXkm8oYmlgYmZmZG5mQUweYnzNvieiRISSE8sSc1OTS1ILYLpY+LglGpgXJTOX/ppa9ee
        1k7VFyVWFyJfPJI59e5i+uOQd21bK3vueEWtOGjgFDqB9wLfNP7vn7rqg9K1os6nPDH+NvPx
        Q659/C2husvsn7Aryjl+OMZUrab6LGK99v5PleWaW90yZ/yq9DofuzByyzLR69Kf4vPVVtVa
        zpq/89eXjsXFH+OPsc0UY28KVGIpzkg01GIuKk4EAMB/Y6Z4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t9jAd2jjBeiDCa/tbC41ruQ2eJs0xt2
        i8u75rBZfO49wmhxu3EFmwOrx85Zd9k9+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK6Nplm3B
        dO6KPTPXsTUwNnF2MXJySAiYSHSvX8HSxcjFISSwk1GibctBVpAEr4CgxI/J94ASHBzMAvIS
        Ry5lQ5jqElOm5IJUCAncByrfJwUS5hXQkniy2AokzCKgKnHmTBsziM0GFN7/4gYbiM0voChx
        9cdjRpByUYEIie4TlSBhEYFkiSnbu9lBbGYBK4ldj/oYQWxhATeJH3d72SAO28oosenkRWaQ
        Xk6BJIlrU3QmMArMQnLmLIQzZyGcuYCReRWjZGpBcW56brFRgVFearlecWJucWleul5yfu4m
        RmDYbjus1b+D8fGS+EOMAhyMSjy8CpXno4RYE8uKK3MPMUpwMCuJ8E5/DBTiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXA6BTTc+7NbFU+Htu3djdzo6q7
        yl1jHx00SZqcUGLQa9rjc/zTAk1rpaTmTQcf7ZixyFDqfNnl2hkzFvTMrkibXXFQTWzDxNlh
        klf2F93zjnu/4mFosvkdkTUWT913RMde/HueawmnTai3lYzDjbY8n5VXRb65H32fFuqyQ1Lt
        /JLqjDKOI7v+KbEUZyQaajEXFScCAEg5r5dXAgAA
X-CMS-MailID: 20180413010302epcas2p35b2181417682089d7a1046fd3559ac43
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
X-RootMTR: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
References: <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcas5p1.samsung.com>
        <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry for the late reply.

On 2018년 03월 30일 20:44, Arvind Yadav wrote:
> Never directly free @dev after calling device_register() or
> device_unregister(), even if device_register() returned an error.
> Always use put_device() to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/devfreq/devfreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6a..a225b94 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	err = device_register(&devfreq->dev);
>  	if (err) {
>  		mutex_unlock(&devfreq->lock);
> -		goto err_dev;
> +		put_device(&devfreq->dev);
> +		goto err_out;

why do you change the goto postion?
err_out is correct to free the memory of devfreq instance.

>  	}
>  
>  	devfreq->trans_table =	devm_kzalloc(&devfreq->dev,
> @@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	device_unregister(&devfreq->dev);
> +	devfreq = NULL;

It is wrong. If you initialize the devfreq as NULL,
never free the 'devfreq' instance.

>  err_dev:
>  	if (devfreq)
>  		kfree(devfreq);
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
