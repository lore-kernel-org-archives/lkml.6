Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A84C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FF020989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfA2Qy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:54:58 -0500
Received: from muru.com ([72.249.23.125]:36608 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbfA2Qy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:54:56 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 18B71804F;
        Tue, 29 Jan 2019 16:55:04 +0000 (UTC)
Date:   Tue, 29 Jan 2019 08:54:52 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Variable "reg" in function
 omap4_dsi_mux_pads() could be uninitialized
Message-ID: <20190129165452.GB5720@atomide.com>
References: <20190126063221.8257-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126063221.8257-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yizhuo <yzhai003@ucr.edu> [190125 22:32]:
> In function omap4_dsi_mux_pads(), local variable "reg" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the later context, which
> is potentially unsafe.

Thanks applying into omap-for-v5.0/fixes-v2.

Regards,

Tony
