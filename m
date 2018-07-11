Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9997FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B5F208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ponV/8z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B5F208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbeGKC3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:29:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34932 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732554AbeGKC3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:29:41 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6B2RdlI049867;
        Tue, 10 Jul 2018 21:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531276059;
        bh=VTZNirqojFu1X0O7mXNIA2aU2722MvJOvDrKep5TkTE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ponV/8z94BDO7CeynZ8cm9JInO4bkw17ky7d/vpnjCGs3Aeoz7Z//2zNxvHcujy9M
         59sfhEhupWvlne83q4W4Lv/TDT16tMR5IvulJ2rktmSNLUciuVVnvF1TyJ88wkoskJ
         hek5Kpe1LNYFHn2zxBwu4yNMUdVdDIXwz8Zc3wW0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B2RdA9016324;
        Tue, 10 Jul 2018 21:27:39 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 21:27:39 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 21:27:39 -0500
Received: from [172.22.218.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B2RZ7C024308;
        Tue, 10 Jul 2018 21:27:36 -0500
Subject: Re: [PATCH 03/14] thermal: ti-soc-thermal: fix comments in
 omap4-thermal-data.c
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
CC:     Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180514114312epcas1p19fffd35baae3018f47df0fe31ca1b1b0@epcas1p1.samsung.com>
 <1526298141-14045-4-git-send-email-b.zolnierkie@samsung.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <1cc91b04-bcec-29bc-490d-058d37a21999@ti.com>
Date:   Wed, 11 Jul 2018 07:57:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526298141-14045-4-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> The comments about ADC code values are incorrect. Fix them.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/thermal/ti-soc-thermal/omap4-thermal-data.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
> index c12211e..85ba9dc 100644
> --- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
> @@ -46,7 +46,7 @@
>   
>   /*
>    * Temperature values in milli degree celsius
> - * ADC code values from 530 to 923
> + * ADC code values from 0 to 127
>    */
>   static const int
>   omap4430_adc_to_temp[OMAP4430_ADC_END_VALUE - OMAP4430_ADC_START_VALUE + 1] = {
> @@ -136,7 +136,7 @@
>   
>   /*
>    * Temperature values in milli degree celsius
> - * ADC code values from 530 to 923
> + * ADC code values from 530 to 932
>    */
>   static const int
>   omap4460_adc_to_temp[OMAP4460_ADC_END_VALUE - OMAP4460_ADC_START_VALUE + 1] = {
> 
