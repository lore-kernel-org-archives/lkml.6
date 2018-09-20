Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67299C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124B921522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124B921522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbeIUDqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:46:51 -0400
Received: from muru.com ([72.249.23.125]:56764 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbeIUDqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:46:51 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E105E8105;
        Thu, 20 Sep 2018 22:05:29 +0000 (UTC)
Date:   Thu, 20 Sep 2018 15:01:11 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        linux-omap@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 08/11] arm: dts: omap: Update coresight bindings for
 hardware ports
Message-ID: <20180920220111.GZ5662@atomide.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-9-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912135352.19722-9-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suzuki K Poulose <suzuki.poulose@arm.com> [180912 06:58]:
> Switch to the new coresight bindings for hardware ports
> 
> Cc: linux-omap@vger.kernel.org
> Cc: "Benoît Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts | 17 ++++++++++-------
>  arch/arm/boot/dts/omap3-beagle.dts    | 17 ++++++++++-------
>  2 files changed, 20 insertions(+), 14 deletions(-)

Thanks applying this into omap-for-v4.20/dt.

Tony
