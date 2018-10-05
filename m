Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF5C65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A726F20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A726F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeJEXKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:10:53 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJEXKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:10:53 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M9nAB-1g2hPG2CKT-005rpo; Fri, 05 Oct 2018 18:11:27 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M9nAB-1g2hPG2CKT-005rpo; Fri, 05 Oct 2018 18:11:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: keystone: add missing MODULE_LICENSE
Date:   Fri,  5 Oct 2018 18:11:15 +0200
Message-Id: <20181005161126.704214-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:DVPu+IJOKpsK4wUVvQSrcjPgjI2mrg+eJkiNSyS1OS0/4qgUuNN
 z1zZcgfHHxdmFo5yR/MLWlwiX+JBlzuFwBGgYjMZ44o7YCyUbDYotj6BekP+kXM0IPEcvGv
 AyY2HaH5AtQqNGnkwhY0PdC0Ic2lbu/HPDbl2bR+OZtHyAULiKc6wWDcfTowriRcD4T+TnK
 hzsU2w52PnNqTU79Ruasg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M/GmLyOCgE4=:hghMhHMl1HRLorJTkLo29n
 ro12sCQ95OuL75xvg1fpjOhja8OzZEaYlXMiT3Jov1vSQYMMdGW6+yOZDST1ZIiqiwtM9vJF+
 hnsi12OFkjmMHnd7JCq7F95qgE6rGcecjIpkT0hw1BTg27Rai67riu5Z9xaF4XAnY8iLERNgy
 lqQa1oWL3Ee0cltMTIiPlqYMALMlzT+1qx3e/BpzFzQRJR2i7d6edX9xU5U9MX5nVYfnz6SxB
 EJaVdk7FhkGzvPWgvYCcDHK+LJfhEF0ULB/0eSTR/iIXtCQuCWSkDBIbh1kNtixC22wY/TUsJ
 yGnMpRzkUXmRJj51nkVv2g7O5KsxCU2+LHLnNV9JY4V2GWrJP0wxySyot3qdSzbapC4lFM3Vq
 1rJEiUgrg8FAp8xeDiNhtElL4ZhgcuO06F8fGVZ0tLYV6GZDhAelZFr3WJB/hY3G7bNV6SKCL
 hjH0rhyAYCjxbICMtaHD+C557YV++b/Wk6ee8r9sD60B/1wbotfQuvcOZjakA7bdV4nnfAw/u
 1GhD2DZrWvbFWyH62c1sTY0PtMS9qmUa4a95b/ajzka626PjdarBpJ8jFIs89gNbKkSLch1Yx
 iaVngiMYGFZo61yIr3RN/r2n6OENGiEOHfhyKWwEdAG+Lf0cb+yVxw2c1IZg72e2rWyySTRDM
 RsXYfTwxce3VF5211OzSPB6nenm1O1an5WkB8VlRpDhZq7PxSgRJ/ckDfqhvyJAjTCmM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A randconfig build showed that two clk modules have no license tag:

WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/keystone/gate.o
see include/linux/module.h for more information
WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/keystone/pll.o
see include/linux/module.h for more information

Add the appropriate information from the comment at the start of the
two files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I had not seen this until today, no idea why it showed up now on arm64.
---
 drivers/clk/keystone/gate.c | 5 +++++
 drivers/clk/keystone/pll.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/keystone/gate.c b/drivers/clk/keystone/gate.c
index def15db4eef0..4ed9b29ba438 100644
--- a/drivers/clk/keystone/gate.c
+++ b/drivers/clk/keystone/gate.c
@@ -266,3 +266,8 @@ static void __init of_keystone_psc_clk_init(struct device_node *node)
 }
 CLK_OF_DECLARE(keystone_gate_clk, "ti,keystone,psc-clock",
 					of_keystone_psc_clk_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Clock driver for Keystone 2 based devices");
+MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
+MODULE_AUTHOR("Santosh Shilimkar <santosh.shilimkar@ti.com>");
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index 2b871fc91d56..349540469fc0 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -338,3 +338,8 @@ static void __init of_pll_mux_clk_init(struct device_node *node)
 		pr_err("%s: error registering mux %s\n", __func__, clk_name);
 }
 CLK_OF_DECLARE(pll_mux_clock, "ti,keystone,pll-mux-clock", of_pll_mux_clk_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PLL clock driver for Keystone devices");
+MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
+MODULE_AUTHOR("Santosh Shilimkar <santosh.shilimkar@ti.com>");
-- 
2.18.0

