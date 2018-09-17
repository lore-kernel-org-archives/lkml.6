Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E13ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FA4214DC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FA4214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIQWbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:31:37 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24947 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeIQWbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:31:37 -0400
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="17300667"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Sep 2018 10:03:24 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Mon, 17 Sep 2018 10:03:23 -0700
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
To:     <boris.brezillon@bootlin.com>
CC:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <cyrille.pitchen@microchip.com>,
        <nicolas.ferre@microchip.com>, <Cristian.Birsan@microchip.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <9953d6e5-1049-5645-31e3-7c05071c09aa@microchip.com>
Date:   Mon, 17 Sep 2018 20:03:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180911154007.17195-2-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris,

On 09/11/2018 06:40 PM, Tudor Ambarus wrote:
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c

[cut]

>  /*
I missed to use the opening comment mark for kernel-doc comments: "/**". This
observation applies to all newly introduced function descriptions, in this patch
and in the next as well.
> + * spi_nor_div_by_erase_size() - calculate remainder and update new dividend
> + * @erase:	pointer to a structure that describes a SPI NOR erase type
> + * @dividend:	dividend value
> + * @remainder:	pointer to u32 remainder (will be updated)
> + *
> + * Returns two values: remainder and the new dividend

I should have used "Return: describe the return value" in order to be aligned
with the example from kernel-doc. This also applies to most of the function
descriptions.

[cut]

> +/*
> + *spi_nor_init_uniform_erase_map() - Initialize uniform erase map

add a space after that "*"

I will gladly submit a new version if there are no other comments. Please let me
know.

Cheers,
ta
