Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAE0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4720521874
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qUJZAb1J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfBDKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:00:06 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40036 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfBDKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:00:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14A02as106921;
        Mon, 4 Feb 2019 04:00:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549274402;
        bh=l/Qi79gb0/UqTKCD5NXWd4S2H2JF62RURYXAdl7Bz3g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qUJZAb1JCNNdddkZHKPrIB5ktdRSfHjAyAEaDdJ4o/T4PXd9PrWnBmUWyNMB6hQlS
         Wm2w1cBge7uqxiBjKPEY7jOABvd7WRkVlvAduOsrsGiO8O1KKPJdtG90qcqvT6M4qa
         qc2na5IBFcppFD6FfEOe2MdigS6jpCZEPPBkex/Y=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14A0202034367
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 04:00:02 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 04:00:01 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 04:00:01 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x149xx2n024113;
        Mon, 4 Feb 2019 04:00:00 -0600
Subject: Re: [PATCH] phy: armada375-usb2: switch to SPDX license identifier
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20190118150146.31590-1-gregory.clement@bootlin.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f50f5f47-5642-fd17-4c9b-e0ee99cd8f4e@ti.com>
Date:   Mon, 4 Feb 2019 15:29:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118150146.31590-1-gregory.clement@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/19 8:31 PM, Gregory CLEMENT wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

merged, thanks!

-Kishon
> ---
>  drivers/phy/marvell/phy-armada375-usb2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-armada375-usb2.c b/drivers/phy/marvell/phy-armada375-usb2.c
> index 1a3db288c0a9..362c0af71566 100644
> --- a/drivers/phy/marvell/phy-armada375-usb2.c
> +++ b/drivers/phy/marvell/phy-armada375-usb2.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * USB cluster support for Armada 375 platform.
>   *
> @@ -5,10 +6,6 @@
>   *
>   * Gregory CLEMENT <gregory.clement@free-electrons.com>
>   *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2 or later. This program is licensed "as is"
> - * without any warranty of any kind, whether express or implied.
> - *
>   * Armada 375 comes with an USB2 host and device controller and an
>   * USB3 controller. The USB cluster control register allows to manage
>   * common features of both USB controllers.
> 
