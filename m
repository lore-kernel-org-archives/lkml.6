Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CD320851
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfB0Kgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:36:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52743 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbfB0Kgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:36:38 -0500
X-UUID: 71e2a34a19ac4d28873855d972c510a1-20190227
X-UUID: 71e2a34a19ac4d28873855d972c510a1-20190227
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 632255843; Wed, 27 Feb 2019 18:36:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Feb 2019 18:36:31 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Feb 2019 18:36:31 +0800
Message-ID: <1551263791.9274.1.camel@mtkswgap22>
Subject: Re: [PATCH v4 3/3] clk: mediatek: Mark bus and DRAM related clocks
 as critical
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <kevin-cw.chen@mediatek.com>, <matthias.bgg@kernel.org>,
        <mturquette@baylibre.com>, <sean.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <jasu@njomotys.info>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 27 Feb 2019 18:36:31 +0800
In-Reply-To: <155120371334.260864.14503820089028591730@swboyd.mtv.corp.google.com>
References: <20190214163242.26259-1-matthias.bgg@kernel.org>
         <155120371334.260864.14503820089028591730@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: D09BE145A9C3858815200826CB1E71BDDEEAAAAAD9CD596644D19FA7396885AF2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

On Tue, 2019-02-26 at 09:55 -0800, Stephen Boyd wrote:
> Quoting matthias.bgg@kernel.org (2019-02-14 08:32:42)
> > From: Jasper Mattsson <jasu@njomotys.info>
> > 
> > Currently, DRAM-related clocks are not marked with CLK_IS_CRITICAL
> > for MT6797. This causes memory corruption when the system is
> > booted without clk_ignore_unused.
> > This patch marks MUX ddrphycfg_sel as well as gates infra_dramc_f26m
> > and infra_dramc_b_f26m as CLK_IS_CRITICAL.
> > 
> > Signed-off-by: Jasper Mattsson <jasu@njomotys.info>
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> 
> Applied to clk-next
> 
> Would be nice to get someone from mediatek to ack it, but I can't wait
> forever.

Acked-by:Mars Cheng <mars.cheng@mediatek.com>

Thanks a lot.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


