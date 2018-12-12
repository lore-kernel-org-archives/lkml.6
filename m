Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D5C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8002084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8002084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeLLMcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:32:24 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:21773 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727155AbeLLMcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:32:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,344,1539640800"; 
   d="scan'208";a="359976176"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 12 Dec 2018 13:32:22 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 0/2] scripts: coccinelle: Improve boolinit
Date:   Wed, 12 Dec 2018 12:55:55 +0100
Message-Id: <1544615757-19356-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the scope of the rule and improve the warning messages.

julia (2):
  scripts: coccinelle: only suggest true/false in files that already use
    them
  scripts: coccinelle: Correct warning message

 scripts/coccinelle/misc/boolinit.cocci | 43 +++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 16 deletions(-)

-- 
1.9.1

