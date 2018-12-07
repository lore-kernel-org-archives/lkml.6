Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9DC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4193720838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4193720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLGJ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:29:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47655 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbeLGJ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:29:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E1E2620D23; Fri,  7 Dec 2018 10:28:57 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id AEE9F20CC3;
        Fri,  7 Dec 2018 10:28:47 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:28:48 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: sun6i-rtc: Fix register range in
 example
Message-ID: <20181207092848.GF8952@piout.net>
References: <20181207084719.2009-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207084719.2009-1-wens@csie.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 16:47:19+0800, Chen-Yu Tsai wrote:
> The register range for the RTC extends beyond 0x54.
> Use the size from the user manual's memory map instead.
> 
> Fixes: 9765d2d94309 ("rtc: sun6i: Add sun6i RTC driver")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
