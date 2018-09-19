Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA94C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1852150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1852150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbeISWuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:50:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57332 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbeISWuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:50:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A33F3207D4; Wed, 19 Sep 2018 19:11:32 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id E3B242000E;
        Wed, 19 Sep 2018 19:11:21 +0200 (CEST)
Date:   Wed, 19 Sep 2018 19:11:20 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: sama5d27_som1_ek: add adc regulators
Message-ID: <20180919171120.GE2479@piout.net>
References: <1537360793-10264-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537360793-10264-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2018 15:39:53+0300, Eugen Hristev wrote:
> Add fixed regulators for the ADC. This board does not have
> a programmable PMIC, but fixed regulators.
> Adding them to DT so the ADC can probe correctly.
> 
> Tested-by: Swapna Gurumani <swapna.gurumani@microchip.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 42 +++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
