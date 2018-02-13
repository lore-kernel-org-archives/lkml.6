Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966021AbeBMWVv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:21:51 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:38293 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965935AbeBMWVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:21:48 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180213222146epoutp02f2b7c2cab29f40c57043565d0cab9acd~TArwczJ4N1706317063epoutp02b
X-AuditID: b6c32a45-3ebff70000001023-25-5a8364f91229
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A8364F8.8050801@samsung.com>
Date: Wed, 14 Feb 2018 07:21:44 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: Delete an error message for
 a failed memory allocation in exynos_ppmu_probe()
In-reply-to: <e4d3a870-f420-5a06-1665-59152c1924a3@users.sourceforge.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3a2szNt9TUtPxaYHQpJ2tqWzmNlFK5YJCREEEbZUQ86dBd2
        pqQEm+syXXlJQ8SGXVS8EGjTbiuttAsEtajMsNDMMkuD0O4Zdo4nqf9+78PzPt/3vrwEpijB
        lYTJ4mDsFjqXxEPEl3pXUaofmYdSNU0fJVSwpAmjLg4spcpHxjEqGGyXUg/cE1LKP/JMQj0J
        +HBqqvQ2oGqC3SLqRVEzvinE6G8twY0dDU5jWWcrMLrveyTGKX9kiiSV2ZDN0JmMPYqxZFgz
        TZasRHL7zrSktDi9RqvSJlDxZJSFNjOJpCE5RbXVlMv9iYzKp3PzOCmFZllyzcYNdmueg4nK
        trKORHKPVqtTazXxap1Op45du3edLo6z7GeyL/9wiWyTsgONX/tELlBJeIGMQDAW+RqeYl4Q
        QijgFYCOVU+IheIbV7z6ic25ai62zbICtgM0OhzOsxwuQt+rBrkGgsDgMnT7cQ4vY3AVGvtc
        +TdnEKAL3ueY4I9B7tGghGcxXImuXT8j4hnn9Btjz3GeF8LlqO/7COB5MdyNrp7+KuWDwmFA
        hNonv4iFF4zINRyYDQ2DTlT0a2Y2VAa3odePpiV8A4IjOCo/3QCECQzomOeWWOAw9OFep1Tg
        pWi09QIQGjwAebrqMKE4CdDD/kGR4FqLRs96RcLTC1Bx728pPzOCclR8VCGgEbUdCRHcm1HH
        QO/f8X0AVT2YxipAZO1/G6v9t7Ha/zZ2BmCtYAljY81ZDKuzadUsbWbzLFnqDKvZD2bPMGbL
        FVDzMLkHQAKQ8+XER3eqQkLnswXmHoAIjAyX7x/iJHkmXVDI2K1p9rxchu0BcdzCT2DKxRlW
        7qgtjjRtbIImVq/Xxesp7sIi5EdTDKkKmEU7mByGsTH2uT4RIVO6wJqu6nRfdJnzTUdcz4qD
        UBxhGO8Odqmax0Lfybr2nS8vzVAmnepvUTpol9FRMbPaFfo2EHQfDns/dG7r+l2GmsAQrqvQ
        FHvrNU8KVHeoef3pJv2BppicopbCcduA567z5/3mm766831m53FV8GVboymaHnhTnGDY8WnY
        X4+mSDGbTWtjMDtL/wH4X8ManAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQd0fKc1RBi8WSluc71zObLH1lrRF
        /+PXzBbnz29gtzjb9IbdYtPja6wWl3fNYbP43HuE0WLG+X1MFrcbV7A5cHlsWtXJ5rF5Sb1H
        35ZVjB5Np9pZPT5vkgtgjeKySUnNySxLLdK3S+DK2P6zgangE2fF0m9XmRoYJ3F0MXJySAiY
        SMzYup65i5GLQ0hgHaPE5Ieb2UESvAKCEj8m32PpYuTgYBaQlzhyKRvCVJeYMiUXovwBo8TX
        q58YIcq1JJqenWcFsVkEVCV271nABGKzAcX3v7jBBmLzCyhKXP3xmBFkjqhAhET3iUqQOSIC
        u5gkFp+aClbPLOAh0fBwFzNIjbBAvcSasy4Qu+YxSjydOJcFpIZTwFPi0YU/rBMYBWYhuXQW
        wqWzEC5dwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMAK2Hdbq38H4eEn8IUYB
        DkYlHl6Ot01RQqyJZcWVuYcYJTiYlUR4E+4DhXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+L
        FBJITyxJzU5NLUgtgskycXBKNTA6if32SyuOqDzFPulAMveK26dOGjGf/vLDXqTlsPaT1SZ+
        a71sdaW3vH/WXN99/JH+ZO7yBMWg6sMm0yemvfr5847EQt/QHX6uR6dfez95efpCV+3rvgUR
        hv4/Vrr9L+Q2r/SMvLrn4QRGUZcehZ0n9BrD3qwK0G3/tugQl2Wc7Hc5u7Krf+KVWIozEg21
        mIuKEwEyM1+IfAIAAA==
X-CMS-MailID: 20180213222144epcas2p10804eec2e1831336794bae101599f831
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78
X-RootMTR: 20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78
References: <CGME20180213211754epcas1p12c743dac97dbc187c46206bc2fa16c78@epcas1p1.samsung.com>
        <e4d3a870-f420-5a06-1665-59152c1924a3@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 14일 06:17, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Feb 2018 22:10:42 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index d96e3dc71cf8..72ac9113500d 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -627,11 +627,9 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>  
>  	size = sizeof(struct devfreq_event_dev *) * info->num_events;
>  	info->edev = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> -	if (!info->edev) {
> -		dev_err(&pdev->dev,
> -			"failed to allocate memory devfreq-event devices\n");
> +	if (!info->edev)
>  		return -ENOMEM;
> -	}
> +
>  	edev = info->edev;
>  	platform_set_drvdata(pdev, info);
>  
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
