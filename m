Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB26C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2996624899
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2996624899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeGCHFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:05:01 -0400
Received: from muru.com ([72.249.23.125]:49738 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754651AbeGCHE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:04:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 818DB8047;
        Tue,  3 Jul 2018 07:07:55 +0000 (UTC)
Date:   Tue, 3 Jul 2018 00:04:56 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ARM: dts: dra7/am7xx: USB fixes and enhancements
Message-ID: <20180703070456.GF112168@atomide.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
 <e6e22046-e784-9cf6-3882-5a7f6ac66f2c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e22046-e784-9cf6-3882-5a7f6ac66f2c@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [180702 09:00]:
> Hi Tony,
> 
> On 29/05/18 12:00, Roger Quadros wrote:
> > Hi Tony,
> > 
> > These are some fixes and enhancements for USB ports on dra7 and am57xx-idk EVMs.
> > If OK, please queue these for v4.18. Thanks.
> > 
> 
> Gentle reminder.
> Could you please pick the first patch for 2018-rc, and the rest for -next. Thanks.

Applying patches 2 to 5 into omap-for-v4.19/dt thanks.

Tony
