Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCAC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185372086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185372086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbeKGXPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:15:33 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:54923 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727590AbeKGXPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:15:32 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id wA7DEauJ011299;
        Wed, 7 Nov 2018 15:14:36 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 1DA6E630C9; Wed,  7 Nov 2018 15:44:35 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     linus.walleij@linaro.org, yuenn@google.com, venture@google.com,
        benjaminfair@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, kunyi@google.com
Cc:     linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/1] pinctrl: nuvoton: modify NPCM7xx pin configuration 
Date:   Wed,  7 Nov 2018 15:44:33 +0200
Message-Id: <20181107134434.354795-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch Modify GPIO direction setting in pin configuration function.

please refer patch:
Kun Yi https://patchwork.ozlabs.org/patch/985540/

Tomer Maimon (1):
  pinctrl: nuvoton: modify NPCM7xx pin configuration function

 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
2.14.1

