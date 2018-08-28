Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47B3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ACE2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3ACE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeH1Rtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:49:33 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45038 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbeH1Rtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:49:33 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SDsNsn026209;
        Tue, 28 Aug 2018 08:57:35 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2m33hnksuq-1;
        Tue, 28 Aug 2018 08:57:35 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 98B80611C8B4;
        Tue, 28 Aug 2018 08:59:14 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 28 Aug 2018
 14:57:34 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7SDvWip018530;        Tue, 28 Aug 2018 14:57:32 +0100
Subject: Re: [PATCH] MAINTAINERS: Move entry for Cirrus Logic Madera codecs
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20180828133320.1831-1-geert+renesas@glider.be>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <57cafda5-d7f4-61a3-7169-38cc2d34abf6@opensource.cirrus.com>
Date:   Tue, 28 Aug 2018 14:57:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180828133320.1831-1-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808280140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/18 14:33, Geert Uytterhoeven wrote:
> To preserve alphabetical sort order.
> 
> Fixes: 97c2b5cba2044f1c ("mfd: madera: Add register definitions for Cirrus Logic Madera codecs")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   MAINTAINERS | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ad052aeac39be98..4b0ce55dd7c2413d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3557,6 +3557,22 @@ L:	netdev@vger.kernel.org
>   S:	Maintained
>   F:	drivers/net/ethernet/cirrus/ep93xx_eth.c
>   
> +CIRRUS LOGIC MADERA CODEC DRIVERS
> +M:	Charles Keepax <ckeepax@opensource.cirrus.com>
> +M:	Richard Fitzgerald <rf@opensource.cirrus.com>
> +L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> +L:	patches@opensource.cirrus.com
> +T:	git https://github.com/CirrusLogic/linux-drivers.git
> +W:	https://github.com/CirrusLogic/linux-drivers/wiki
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mfd/madera.txt
> +F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
> +F:	include/linux/mfd/madera/*
> +F:	drivers/gpio/gpio-madera*
> +F:	drivers/mfd/madera*
> +F:	drivers/mfd/cs47l*
> +F:	drivers/pinctrl/cirrus/*
> +
>   CISCO FCOE HBA DRIVER
>   M:	Satish Kharat <satishkh@cisco.com>
>   M:	Sesidhar Baddela <sebaddel@cisco.com>
> @@ -3584,22 +3600,6 @@ M:	Christian Benvenuti <benve@cisco.com>
>   S:	Supported
>   F:	drivers/infiniband/hw/usnic/
>   
> -CIRRUS LOGIC MADERA CODEC DRIVERS
> -M:	Charles Keepax <ckeepax@opensource.cirrus.com>
> -M:	Richard Fitzgerald <rf@opensource.cirrus.com>
> -L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -L:	patches@opensource.cirrus.com
> -T:	git https://github.com/CirrusLogic/linux-drivers.git
> -W:	https://github.com/CirrusLogic/linux-drivers/wiki
> -S:	Supported
> -F:	Documentation/devicetree/bindings/mfd/madera.txt
> -F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
> -F:	include/linux/mfd/madera/*
> -F:	drivers/gpio/gpio-madera*
> -F:	drivers/mfd/madera*
> -F:	drivers/mfd/cs47l*
> -F:	drivers/pinctrl/cirrus/*
> -
>   CLANG-FORMAT FILE
>   M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>   S:	Maintained
> 

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

A maintainer for MAINTAINERS would help avoid these problems, which will
tend to happen when changes to the file go through many trees.

