Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1037CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43E42084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43E42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=monom.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbeJ3FGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:06:43 -0400
Received: from mail.monom.org ([188.138.9.77]:50802 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbeJ3FGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:06:37 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 2107B500B3B;
        Mon, 29 Oct 2018 21:16:21 +0100 (CET)
Received: from localhost (ppp-93-104-187-85.dynamic.mnet-online.de [93.104.187.85])
        by mail.monom.org (Postfix) with ESMTPSA id D4854500294;
        Mon, 29 Oct 2018 21:16:20 +0100 (CET)
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 2/2] Linux 4.4.162-rt176-rc1
Date:   Mon, 29 Oct 2018 21:16:17 +0100
Message-Id: <20181029201617.24733-3-wagi@monom.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181029201617.24733-1-wagi@monom.org>
References: <20181029201617.24733-1-wagi@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.4.162-rt176-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index 8ead11a7cbc7..c3267d6bdd98 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt175
+-rt176-rc1
-- 
2.14.4
