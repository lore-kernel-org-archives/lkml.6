Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4146CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95DA208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QGCC6tke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95DA208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbeGKCXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:23:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48496 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732284AbeGKCXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:23:10 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6B2LApU004865;
        Tue, 10 Jul 2018 21:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531275670;
        bh=G49KSl4cLNUc6Q/nDqaLV+YjcSvE9F1jKhjkjOeOHSQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QGCC6tkeHJI6Fig3mVCSyf3rKkzw6po1T2zpLyFYS5ARc0cQ+rIK3ppjEcmBoyxEe
         FjXzlX2eGB+rOGLPx4L14FQOKbuVZadkU7j34aoVMadKBH+5hAYPBBibLe6CO2Jfbr
         EUD6HrWJQ5DvGvAdKbbndb8wwa9fgaZbIAoJm4CY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B2LAxl001207;
        Tue, 10 Jul 2018 21:21:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 10
 Jul 2018 21:21:10 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 10 Jul 2018 21:21:09 -0500
Received: from [172.22.218.21] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6B2L6CQ012816;
        Tue, 10 Jul 2018 21:21:07 -0500
Subject: Re: [PATCH 02/14] thermal: ti-soc-thermal: fix comment in
 omap5xxx-bandgap.h
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
CC:     Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180514114308epcas2p3bba580c5500889f22d50549994b227db@epcas2p3.samsung.com>
 <1526298141-14045-3-git-send-email-b.zolnierkie@samsung.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <65f3e868-976d-7568-f452-e28af691df17@ti.com>
Date:   Wed, 11 Jul 2018 07:51:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526298141-14045-3-git-send-email-b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> The comment for OMAP5430.CORE register offsets is incorrect. Fix it.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>   drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> index 9096403..dcbf903 100644
> --- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
> @@ -55,7 +55,7 @@
>   #define OMAP5430_BGAP_DTEMP_MPU_1_OFFSET		0x1E4
>   #define OMAP5430_BGAP_DTEMP_MPU_2_OFFSET		0x1E8
>   
> -/* OMAP5430.MPU register offsets */
> +/* OMAP5430.CORE register offsets */
>   #define OMAP5430_FUSE_OPP_BGAP_CORE			0x8
>   #define OMAP5430_TEMP_SENSOR_CORE_OFFSET		0x154
>   #define OMAP5430_BGAP_THRESHOLD_CORE_OFFSET		0x1AC
> 
