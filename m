Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE3621566
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE3621566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbeHOA33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:29:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41174 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbeHOA33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:29:29 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A2A4920877; Tue, 14 Aug 2018 23:40:18 +0200 (CEST)
Received: from localhost (unknown [37.169.151.69])
        by mail.bootlin.com (Postfix) with ESMTPSA id 002E820740;
        Tue, 14 Aug 2018 23:40:06 +0200 (CEST)
Date:   Tue, 14 Aug 2018 23:40:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: s5m: Add SPDX license identifier
Message-ID: <20180814214005.GS943@piout.net>
References: <20180807161919.7827-1-krzk@kernel.org>
 <20180807161919.7827-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807161919.7827-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 18:19:19+0200, Krzysztof Kozlowski wrote:
> Replace GPL v2.0+ license statement with SPDX license
> identifier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/rtc/rtc-s5m.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
