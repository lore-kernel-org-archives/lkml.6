Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BDEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7C020851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7C020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeLKQSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:18:00 -0500
Received: from muru.com ([72.249.23.125]:57420 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbeLKQRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:17:55 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 813548027;
        Tue, 11 Dec 2018 16:17:58 +0000 (UTC)
Date:   Tue, 11 Dec 2018 08:17:52 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: fix USB configuration for device-only setups
Message-ID: <20181211161752.GR6707@atomide.com>
References: <20181204175742.2634-1-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204175742.2634-1-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [181204 09:58]:
> Currently we do USB configuration only if the host mode (CONFIG_USB)
> is enabled. But it should be done also in the case of device-only setups,
> so change the condition to CONFIG_USB_SUPPORT. This allows to use
> omap_udc on Palm Tungsten E.

I'll apply this into omap-for-v4.21/omap1 as it seems that it's
been broken for ages :) Let me know if there is urgent need for
the -rc cycle.

Regards,

Tony
