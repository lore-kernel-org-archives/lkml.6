Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2340313F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D2220881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D2220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeG3K2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:28:00 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:56212 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbeG3K17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:27:59 -0400
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="14263165"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 01:53:45 -0700
Received: from localhost.localdomain (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Mon, 30 Jul 2018 01:53:44 -0700
Subject: Re: [PATCH v2 0/3] add support to non-uniform SFDP SPI NOR flash
 memories
To:     <marek.vasut@gmail.com>, <cyrille.pitchen@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>
References: <20180712173235.7901-1-tudor.ambarus@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
Message-ID: <1a3a29a7-abdd-cfb4-b955-48dad6417cca@microchip.com>
Date:   Mon, 30 Jul 2018 11:53:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180712173235.7901-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a side note, the SFDP code increases its size, it would make sense to move
all SFDP logic into a spi-nor-sfdp.c file. I'm volunteering to do this after
this patch set gets applied.

Best,
ta
