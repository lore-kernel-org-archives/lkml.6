Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7653C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5639720898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5639720898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH1UMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:12:54 -0400
Received: from muru.com ([72.249.23.125]:54814 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeH1UMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:12:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 67CCB8081;
        Tue, 28 Aug 2018 16:24:22 +0000 (UTC)
Date:   Tue, 28 Aug 2018 09:20:27 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Olof Johansson <olof@lixom.net>, arm@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        t-kristo@ti.com
Subject: Re: [PATCH] arm64: defconfig: Enable TI's AM6 SoC platform
Message-ID: <20180828162027.GO7523@atomide.com>
References: <20180828004650.2184-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828004650.2184-1-nm@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [180828 00:50]:
> Enable K3 SoC platform for TI's AM6 SoC.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Ref: https://www.spinics.net/lists/arm-kernel/msg667805.html
> 
> Unfortunately, Kconfig changes did'nt hit v4.19-rc1 window.
> So, as promised, patch based off v4.19-rc1 tag.

Acked-by: Tony Lindgren <tony@atomide.com>
