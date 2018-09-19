Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FACEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B352151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="by96WXAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B352151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbeISM5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:57:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47396 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeISM5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:57:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8J7L1Zo079054;
        Wed, 19 Sep 2018 02:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537341661;
        bh=25p24FjkmOE6uvJXY3oowg2gnAdoLIluqikoWwN6L90=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=by96WXAhZ8vldn6C0LL66vVpGoSXqbNAeFAcCOikaQz5We56vBllD1Pbf0bmCYkQg
         eO4qZbO03/fRC5xpIrryBgb2rChr+CW0jBoxBvMrevJFXj55Lq5P15zysYIKCUgZeb
         HaOMk+mjoGaFszSIJkqk6E8cfJzRuoaYO/vB5n8Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J7L1wZ008505;
        Wed, 19 Sep 2018 02:21:01 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 19
 Sep 2018 02:21:00 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 19 Sep 2018 02:21:00 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8J7Kxn6015944;
        Wed, 19 Sep 2018 02:21:00 -0500
Subject: Re: [PATCH 1/2] phy: berlin-usb: switch to SPDX identifier
To:     Antoine Tenart <antoine.tenart@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20180713154704.16769-1-antoine.tenart@bootlin.com>
 <20180919071331.GA599@kwain>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <71e45b52-a622-5ee3-3f19-fb5a4f2e8d81@ti.com>
Date:   Wed, 19 Sep 2018 12:50:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919071331.GA599@kwain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,

On Wednesday 19 September 2018 12:43 PM, Antoine Tenart wrote:
> Hello Kishon,
> 
> Any update about these two patches?

Looks like patches for this from Jisheng Zhang has already made into the 4.19
kernel.

Thanks
Kishon
> 
> Thanks!
> Antoine
> 
> On Fri, Jul 13, 2018 at 05:47:03PM +0200, Antoine Tenart wrote:
>> Use the appropriate SPDX license identifier and drop the license text.
>> This patch is only cosmetic.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>> ---
>>  drivers/phy/marvell/phy-berlin-usb.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
>> index 8f2b5cae360f..a43df63007c5 100644
>> --- a/drivers/phy/marvell/phy-berlin-usb.c
>> +++ b/drivers/phy/marvell/phy-berlin-usb.c
>> @@ -1,12 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0
>>  /*
>>   * Copyright (C) 2014 Marvell Technology Group Ltd.
>>   *
>>   * Antoine Tenart <antoine.tenart@free-electrons.com>
>>   * Jisheng Zhang <jszhang@marvell.com>
>> - *
>> - * This file is licensed under the terms of the GNU General Public
>> - * License version 2. This program is licensed "as is" without any
>> - * warranty of any kind, whether express or implied.
>>   */
>>  
>>  #include <linux/io.h>
>> -- 
>> 2.17.1
>>
> 
