Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C403DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8504F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8504F20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbeGXHBE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:01:04 -0400
Received: from mout.perfora.net ([74.208.4.197]:52025 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388196AbeGXHBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:01:04 -0400
Received: from [10.48.17.206] ([178.197.226.224]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MI7NQ-1fiNT83yc2-003vjp;
 Tue, 24 Jul 2018 07:56:05 +0200
Date:   Tue, 24 Jul 2018 07:55:58 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <228cdf6fe37298223d77b52fd4cdb821b0da7d11.camel@lynxeye.de>
References: <20180720075515.26852-1-marcel@ziswiler.com> <228cdf6fe37298223d77b52fd4cdb821b0da7d11.camel@lynxeye.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] drm/tegra: hdmi: probe deferral error reporting
To:     Lucas Stach <dev@lynxeye.de>, linux-tegra@vger.kernel.org
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <537EF05F-3718-45F6-B536-11CAC5BE82C5@ziswiler.com>
X-Provags-ID: V03:K1:6PVdVe512v2joy73lk6OdAivIg3209wadA2UmbhvNFM+MiBU6zp
 vQgZhUVi1Lct9EQLGpO5SYRtLRQZarY16SHKNYHB+G2fwiSPlV8OL4JNfD/fm00HWoN8+yl
 NqAJy333xR50DgXJgaQqO4Gjv0X2XPyjBXveQE69qnDREr8R975Gr0bUPJqwq0uW5lZOHhi
 +OstZX7n4MHdLfVI+QJRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QE1sYYl0IPE=:Dnm7RHxfC+2AWnQKrkiaMe
 f9DBiNIpTbBNR4ewvJNJdP0fRbBLhdHONKmFvhjNN1UPu8kxRC8iqcsO7d6IxGtqu+j43h4ev
 GrfrPXgp6UMo+95RqHHjjLLL0lKB0A8DRVGC3hyaKYXAsvm+Vqmeh7JI45XjPT7rSzy1RrjGI
 IjyoFlGGDMrISBoXj6JE8HLyK8M1ZtyQ4D+fUS0TW7jSQxLg4GFKJIarRzMynie/UGATQxwwy
 OLYQVt7iQ1qO6IfVB6hm+rA/FO2zblCwU42LFrk50bwa96tilhi3WWMVL6RdLRcoXDSjLF6W9
 gkxpJBHYFkq3JJ0eK/MgkdcquKtJgi72q4ZqSD+AVnTjTzUWsY9B8ZUJ0NgdxrG8QiOp3A+eJ
 LemnPEVZLOETUcwt37cpiLfE738HIrztLyb6M4mDrB33EHpDbx1K1LjJgne6tzi50XzJjwmXW
 wW5/OzlngWFCP8Z5Z9BAdWFkIBYQ8cdjPCVfULjQ1JNjwHeuly8B5SpRy60p7CMHkjTKoR63h
 KfyA/hJ6AGg97XN+GMpGiKuk41EB0siKjmUaCdRqIpdHvFhPoXeCTyp37ds2e06uXNkp17ewU
 dXhTDdKHIEFYnoYbDUEeyW3YA3oq3M3K0TsZ6H4Q5QBPd6LGIKXvm65rP40WroxQbD8GVrFG3
 6gVQy5zp4+gBeYYW9QnpufmRxp6QKRj8LyL3FtICJiooMQGHgbvDu8//nxKFGfcobg0UgCZ2C
 LUgh1Z/bUlRzMw3M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 23, 2018 10:49:15 PM GMT+02:00, Lucas Stach <dev@lynxeye.de> wrote:
>Am Freitag, den 20.07.2018, 09:55 +0200 schrieb Marcel Ziswiler:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> 
>> Actually report the error code from devm_regulator_get() which may as
>> well just be a probe deferral.
>
>This is still noisy, so while you are changing this I would prefer if
>this wouldn't print the error message if it's a simple probe deferral.

Yeah, trust me, I'm not the inventor of this probe deferral disaster!

>Suppressing the log message in that case gets us much cleaner kernel
>logs, where real errors stand out.

Ok, agreed. Will send a v2.

>Regards,
>Lucas
>
>> 
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> 
>> ---
>> 
>>  drivers/gpu/drm/tegra/hdmi.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/tegra/hdmi.c
>b/drivers/gpu/drm/tegra/hdmi.c
>> index 0082468f703c..94c182dbb6d0 100644
>> --- a/drivers/gpu/drm/tegra/hdmi.c
>> +++ b/drivers/gpu/drm/tegra/hdmi.c
>> @@ -1693,14 +1693,16 @@ static int tegra_hdmi_probe(struct
>platform_device *pdev)
>>  
>>  	hdmi->hdmi = devm_regulator_get(&pdev->dev, "hdmi");
>>  	if (IS_ERR(hdmi->hdmi)) {
>> -		dev_err(&pdev->dev, "failed to get HDMI regulator\n");
>> -		return PTR_ERR(hdmi->hdmi);
>> +		err = PTR_ERR(hdmi->hdmi);
>> +		dev_err(&pdev->dev, "failed to get HDMI regulator: %d\n", err);
>> +		return err;
>>  	}
>>  
>>  	hdmi->pll = devm_regulator_get(&pdev->dev, "pll");
>>  	if (IS_ERR(hdmi->pll)) {
>> -		dev_err(&pdev->dev, "failed to get PLL regulator\n");
>> -		return PTR_ERR(hdmi->pll);
>> +		err = PTR_ERR(hdmi->pll);
>> +		dev_err(&pdev->dev, "failed to get PLL regulator: %d\n", err);
>> +		return err;
>>  	}
>>  
>>  	hdmi->vdd = devm_regulator_get(&pdev->dev, "vdd");
