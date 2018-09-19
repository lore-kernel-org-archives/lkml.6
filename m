Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7414C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1F12150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1F12150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbeISWvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:51:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57448 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731056AbeISWvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:51:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 72E2D20798; Wed, 19 Sep 2018 19:12:43 +0200 (CEST)
Received: from localhost (unknown [15.65.243.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id B175C2000E;
        Wed, 19 Sep 2018 19:12:42 +0200 (CEST)
Date:   Wed, 19 Sep 2018 19:12:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v2 10/11] arm: dts: sama5d2: Update coresight bindings
 for hardware ports
Message-ID: <20180919171241.GF2479@piout.net>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-11-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912135352.19722-11-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2018 14:53:51+0100, Suzuki K Poulose wrote:
> Switch to the new coresight bindings for hardware ports
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
