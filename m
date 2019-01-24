Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA50421872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XtKMY2l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfAXEU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:20:57 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:63022 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAXEU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:20:56 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x0O4JI04030691;
        Thu, 24 Jan 2019 13:19:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x0O4JI04030691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548303559;
        bh=TKNrR5jzjw6WrXHxtJ82ro++BWFAOJtU+JQPQgQeqyU=;
        h=From:To:Cc:Subject:Date:From;
        b=XtKMY2l1dEMLzsTwZOLssUz+jvBW+3PoAbXzMrK+477EUnJFw++mfZGNLW3cxkKDT
         C5m9NYp7EQZLq5YmOOzww7hVsbVZSIO+X2hyg9PjJh8z2XqvDUY3sanUiPpsTO26HJ
         7/wCPzTEYZyxT2kmumGw03PdO2Gcx+N8qx3iLjteUxFVYI3vEWGTgH4+FVKBO/fqap
         BhuJMWmQQ2enNoL8dQniomxKMJUKJrAITo18RsgnURD3+5aKG5bL/CI0zP1L1jSiLe
         90UbSSGTm8tyWnULR9S+zhOUn5BxAmkF48OO5pXeKtYSXonL1x6vvG6/Xg+FxKkKPT
         faw4CUCFv6jXQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH 0/2] mtd: rawnand: denali: just trivial cleanups
Date:   Thu, 24 Jan 2019 13:19:05 +0900
Message-Id: <1548303547-21156-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (2):
  mtd: rawnand: denali: remove unneeded denali_reset_irq() call
  mtd: rawnand: denali: remove unused function argument 'raw'

 drivers/mtd/nand/raw/denali.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.7.4

