Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6B0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728B820842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728B820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933779AbeGIPzL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:55:11 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:29636 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbeGIPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:55:08 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="16823143"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 09 Jul 2018 08:55:07 -0700
Received: from [10.145.4.77] (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Mon, 9 Jul 2018
 08:55:06 -0700
Subject: Re: [PATCH v5 2/5] clk: at91: add I2S clock mux driver
To:     Stephen Boyd <sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
        <alsa-devel@alsa-project.org>, <boris.brezillon@bootlin.com>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <robh+dt@kernel.org>
CC:     <Cristian.Birsan@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-3-codrin.ciubotariu@microchip.com>
 <153090076533.143105.11588903392800697432@swboyd.mtv.corp.google.com>
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Message-ID: <b7a379b3-0cfe-7a8e-fa13-3d152beb5e32@microchip.com>
Date:   Mon, 9 Jul 2018 18:55:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153090076533.143105.11588903392800697432@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.2018 21:12, Stephen Boyd wrote:
> Quoting Codrin Ciubotariu (2018-06-18 07:12:36)
>> This driver is a simple muxing driver that controls the
>> I2S's clock input by using syscon/regmap to change the parent.
>> The available inputs can be peripheral clock and generated clock.
>>
>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>> ---
> 
> Applied to clk-next
> 
> But I had to fix:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #56: FILE: drivers/clk/at91/clk-i2s-mux.c:1:
> +/* SPDX-License-Identifier: GPL-2.0 */
> 
> so I did. Please run checkpatch next time.
> 

Sorry about that. I did run checkpatch, but I saw some files that 
commented the License-Identifier the same way I did. Didn't notice back 
then that were only the headers...
Thank you for applying my patches.

Best regards,
Codrin
