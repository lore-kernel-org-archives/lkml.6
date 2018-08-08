Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DBEC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDC121708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDC121708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeHHJfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:35:18 -0400
Received: from muru.com ([72.249.23.125]:52954 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbeHHJfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:35:18 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BA764805C;
        Wed,  8 Aug 2018 07:20:27 +0000 (UTC)
Date:   Wed, 8 Aug 2018 00:16:52 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Huang Shijie <sjhuang@iluvatar.ai>,
        Alexandre Bailon <abailon@baylibre.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.jiang@intel.com, radhey.shyam.pandey@xilinx.com,
        appana.durga.rao@xilinx.com, jmkrzyszt@gmail.com,
        gomonovych@gmail.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org
Subject: Re: [PATCH 09/46] dmaengine: cppi41: use
 dmaenginem_async_device_register to simplify the code
Message-ID: <20180808071652.GP99251@atomide.com>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-10-sjhuang@iluvatar.ai>
 <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
 <20180806032847.GA4452@hsj-Precision-5520>
 <0f35be3f-24c0-f7e4-66c8-e9b7e5c01590@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f35be3f-24c0-f7e4-66c8-e9b7e5c01590@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [180807 07:05]:
> But does the removed three lines worth over the clarity of how the
> module removal is proceeding?
> 
> Alexandre and Tony put lots of effort to the cppi4 driver, I let them
> decide.

Up to you guys as far as I'm concerned.

Tony
