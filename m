Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D351AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861DD20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NJzVbMqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861DD20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbeGWPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:20:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40308 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388157AbeGWPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:20:16 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6NEIS44069150;
        Mon, 23 Jul 2018 09:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532355508;
        bh=mlwsG3k57BYhKbc6nAxn/fWLfCm8JAzPrEcsmb7YOH8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NJzVbMqndl4lus4nPqZ0W+/OE9NC8v2hPFZ2XgnmN1V4/YxTbTMjgwFCXkp9hGJCd
         jfdLadVxc4MJFnwFBcyUpC0Ug6CmJxPrmy+CwaMkWC7hgt6apjed4CusOhAibpmEjM
         ScNEGUZrETCkri7VOWhjDOYRUzLM0cF5mM6it2o0=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NEIRLN008008;
        Mon, 23 Jul 2018 09:18:27 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 23
 Jul 2018 09:18:27 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 23 Jul 2018 09:18:27 -0500
Received: from [172.22.141.227] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6NEIRjB021588;
        Mon, 23 Jul 2018 09:18:27 -0500
Subject: Re: [PATCH] power: supply: bq27xxx: Update comments
To:     Liu Xiang <liu.xiang6@zte.com.cn>
CC:     <pali.rohar@gmail.com>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuxiang_1999@126.com>
References: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <22d140c9-6947-9b7a-68dd-7d859620fa99@ti.com>
Date:   Mon, 23 Jul 2018 09:18:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/2018 04:58 AM, Liu Xiang wrote:
> The URL of bq27441-g1 and bq27426 are missing and bq27520-g4 is duplicated.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---


Acked-by: Andrew F. Davis <afd@ti.com>


>  drivers/power/supply/bq27xxx_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index d44ed8e..f022e1b 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -26,7 +26,6 @@
>   * http://www.ti.com/product/bq27510-g1
>   * http://www.ti.com/product/bq27510-g2
>   * http://www.ti.com/product/bq27510-g3
> - * http://www.ti.com/product/bq27520-g4
>   * http://www.ti.com/product/bq27520-g1
>   * http://www.ti.com/product/bq27520-g2
>   * http://www.ti.com/product/bq27520-g3
> @@ -40,7 +39,9 @@
>   * http://www.ti.com/product/bq27545-g1
>   * http://www.ti.com/product/bq27421-g1
>   * http://www.ti.com/product/bq27425-g1
> + * http://www.ti.com/product/bq27426
>   * http://www.ti.com/product/bq27411-g1
> + * http://www.ti.com/product/bq27441-g1
>   * http://www.ti.com/product/bq27621-g1
>   */
>  
> 
