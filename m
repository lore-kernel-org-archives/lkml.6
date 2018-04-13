Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeDMBMi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:12:38 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23093 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbeDMBMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:12:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180413011235epoutp021d2890c9de93ee8373311531798da86d~k2bdEzHWk0473504735epoutp02Y
X-AuditID: b6c32a47-0e3ff70000000fe8-e7-5ad0032f4eb9
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AD0032E.6020103@samsung.com>
Date: Fri, 13 Apr 2018 10:09:02 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] extcon: int3496: use proper GPIO include
In-reply-to: <20180410124302.29932-1-wsa+renesas@sang-engineering.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjH9+5sx2mtTvPSm4qtA0Ebbe2i8xQZRWajjAwhahF60Bcn7iI7
        m6R+WVEpVjNLlGamQqFpatlmZvdpRWJ2EV1R+UVYaVcy1KKynR2jvv2fP7/nyiPCJBPCWFG+
        xY5sFtpE4hGC7j6ZTrEGe2pQjVVKqeqfzXxquPcsTnknPvGpVwdbcMo1tHWjUP969Caud3la
        gT7Q1CnQT3UlZAgMaL0R0bnIJkWWHGtuviUvhdyembU5K0mnUivUa6lkUmqhzSiFTE3PUKTl
        m4JtSWkRbXIErQyaYcg1G9bbrA47khqtjD2F3KdWa5RqVbJSo9EoE7X712mSgkg2MvraL+GF
        NeEH/M8u4k7gC6sA4SJIJMKWujZBBYgQSYgeAB/5a8K4YAbAKfcwvwKIQtRnr4zzLwNYOzLL
        Z7PFxBI4e3pMwDIYsRz2Py9gbYyQQe+Nzvk6bwC88PFqGMuICTnsua9mGQGxEjqbu4WsxoP2
        nXcvcFYvJlbAkdlxwOpoYg+83jAdGjSKyIT+gQeAq18Cq76fCvGRRArsPe8BbPlwIg3676Sx
        bSHhweFvTwPgxk+FhzpWc/tGwsmHnvnd42Cg9Qrg+DIAy26dw7igGsAh/xifo7Qw0FTB5xov
        guV9v8K4omJYflTCIXo4ebtWyOlNsPZr1fzuZwD0/bqHnwQJ7v/O5f53Lvd/52oEWCuIQYWM
        OQ8xmkKtkqHNjMOSp8yxmrtA6M3kW3tA91C6DxAiQC4US4ufGCRCuogpNvsAFGFklLh2PGiJ
        c+niEmSzZtkcJsT4QFLw3FVYbHSONfi0FnuWOnGtKlGn0yTrqOB7LRU7dwwaJEQebUcFCBUi
        2988vig81glcq2fwu3O3AwOZbby9vEh53ds+7bUvCS9dlfHustLsBfH+HEp2wj83vHngWKf3
        8WD64W8N0dZd2olR64cmmRNgjxS8z/3Lru/c0rht5NN7FHfyrtzkW5W6LI6Kf7zpfv0Pd4xh
        dLBud810n+Y4KTzCc+/t5S1Mri8dAx1Jc9XtpIAx0mo5ZmPoPxMyu1F8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQV095gtRBr9vallM+bOcyeLyrjls
        FltfvmOyuN24gs2i75y7A6vHnWt72Dz6tqxi9Hi2cD2Lx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        h9auYSuYxllx/eJKtgbGQ+xdjBwcEgImEu+3anYxcnEICaxjlPh+7zJrFyMnB6+AoMSPyfdY
        QGqYBeQljlzKBgkzC6hLTJq3iBmi/j6jROfN+8wgNbwCWhI7jhqC1LAIqEo0LN8GNoYNKLz/
        xQ02EJtfQFHi6o/HjCDlogIREt0nKkHCIgLBEs86m1ghxtdI7Dh7BMwWFrCV2LVkCyOILSQw
        m1HiVmcaSCungJvE9f1uExgFZiG5cxbCnbOQ3LmAkXkVo2RqQXFuem6xUYFRXmq5XnFibnFp
        Xrpecn7uJkZgCG87rNW/g/HxkvhDjAIcjEo8vAqV56OEWBPLiitzDzFKcDArifBOfwwU4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwJgv2vDIfxPztqCJ
        OXqhNz9P+HmT3cR0/+pDq3mZBDzmrbnv/8vRyV7nnKtt4lmbDbdnFi+I3Jta5Hck50p7wNH2
        eTFKSk1VIZ+sj/dc+sqxkZH7qv787fmFgd/Wl+8pr8ub3l/VNif2hctNkRNsMplrWQT3FuvO
        3DfvU7l50rS6Kcn/ohmKE5RYijMSDbWYi4oTAbq/NnZdAgAA
X-CMS-MailID: 20180413010902epcas2p2fc3b7fc70a1bebbf1980309826ef8f19
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180410124315epcas5p39971522b55337b5c1369883f128ff43c
X-RootMTR: 20180410124315epcas5p39971522b55337b5c1369883f128ff43c
References: <CGME20180410124315epcas5p39971522b55337b5c1369883f128ff43c@epcas5p3.samsung.com>
        <20180410124302.29932-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 10일 21:43, Wolfram Sang wrote:
> Since commit eca0f13c836a ("extcon: int3496: Ignore incorrect
> IoRestriction for ID pin"), the driver doesn't use GPIOF_* flags
> anymore. We can thus now drop the deprecated include file for GPIO and
> use the new one.

Looks good to me. But, you need to send stable mailing list
and add 'Fixes' tag on v2.

> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Compile tested only.
> 
> @linusw: one more gone
> 
>  drivers/extcon/extcon-intel-int3496.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index acaccb128fc4..fd24debe58a3 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -20,7 +20,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/extcon-provider.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
