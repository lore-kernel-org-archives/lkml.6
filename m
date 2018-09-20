Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E98C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F14F2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F14F2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbeIUDJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:09:25 -0400
Received: from muru.com ([72.249.23.125]:56698 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeIUDJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:09:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C18DA8105;
        Thu, 20 Sep 2018 21:28:12 +0000 (UTC)
Date:   Thu, 20 Sep 2018 14:23:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta-fiq: Use
 <linux/platform_data/gpio-omap.h>
Message-ID: <20180920212354.GT5662@atomide.com>
References: <20180910174722.15679-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910174722.15679-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 10:50]:
> Instead of defining symbols already defined in
> linux/platform_data/gpio-omap.h, use that header file.
> 
> Since we include the header into an assembler code, prevent C only bits
> from being read in.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks applying into omap-for-v4.20/omap1.

Regards,

Tony
