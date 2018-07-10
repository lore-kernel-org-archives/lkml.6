Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE5120881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE5120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeGJFoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:44:44 -0400
Received: from muru.com ([72.249.23.125]:50866 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeGJFom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:44:42 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4C14D8022;
        Tue, 10 Jul 2018 05:47:44 +0000 (UTC)
Date:   Mon, 9 Jul 2018 22:44:38 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com,
        mark.rutland@arm.com, sboyd@kernel.org
Subject: Re: [PATCH v5 2/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
Message-ID: <20180710054438.GE99251@atomide.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
 <20180709164841.14182-3-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709164841.14182-3-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180709 16:50]:
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver

I'll apply patches 2 to 5 to omap-for-v4.19/ti-sysc. The clock
patch is trivial enough to not have to wait for Tero to be back
online.

And I'll apply the dts changes into omap-for-v4.19/dt-mcan based
on omap-for-v4.19/ti-sysc because of the dependency to the clocks.

Regards,

Tony
