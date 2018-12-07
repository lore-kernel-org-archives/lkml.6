Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9389C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F9220868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F9220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLGQZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:25:41 -0500
Received: from muru.com ([72.249.23.125]:56718 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeLGQZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:25:41 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AEED480C0;
        Fri,  7 Dec 2018 16:25:43 +0000 (UTC)
Date:   Fri, 7 Dec 2018 08:25:37 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, hns@goldelico.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap5: Fix dual-role mode on Super-Speed port
Message-ID: <20181207162537.GO6707@atomide.com>
References: <1544030864-22842-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544030864-22842-1-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [181205 17:28]:
> OMAP5's Super-Speed USB port has a software mailbox register
> that needs to be fed with VBUS and ID events from an external
> VBUS/ID comparator.
> 
> Without this, Host role will not work correctly.
> 
> Fixes: 656c1a65ab55 ("ARM: dts: omap5: enable OTG role for DWC3 controller")
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> 
> Tony,
> 
> Please included this in v4.20-rc cycle. Thanks.

Applying into omap-for-v4.20/fixes.

Thanks,

Tony
