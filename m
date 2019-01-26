Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CCDC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD176218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfAZJ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:28:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:28:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0Q9RtJn502169
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 01:27:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0Q9RtAc502166;
        Sat, 26 Jan 2019 01:27:55 -0800
Date:   Sat, 26 Jan 2019 01:27:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-6e1849ec75792c46a18a2b14b8bd915435ff2a2a@git.kernel.org>
Cc:     tglx@linutronix.de, bp@suse.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tony.luck@intel.com, mingo@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, tony.luck@intel.com, bp@suse.de
In-Reply-To: <20190125174227.10652-1-bp@alien8.de>
References: <20190125174227.10652-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] RAS: Add a MAINTAINERS entry
Git-Commit-ID: 6e1849ec75792c46a18a2b14b8bd915435ff2a2a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6e1849ec75792c46a18a2b14b8bd915435ff2a2a
Gitweb:     https://git.kernel.org/tip/6e1849ec75792c46a18a2b14b8bd915435ff2a2a
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 25 Jan 2019 16:45:57 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 26 Jan 2019 10:23:02 +0100

RAS: Add a MAINTAINERS entry

This was long overdue and it is needed at least so that Tony and I get
CCed on patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20190125174227.10652-1-bp@alien8.de
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..a63f2b52a8dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12767,6 +12767,16 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
 S:	Maintained
 F:	drivers/rapidio/
 
+RAS INFRASTRUCTURE
+M:	Tony Luck <tony.luck@intel.com>
+M:	Borislav Petkov <bp@alien8.de>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/ras/
+F:	include/linux/ras.h
+F:	include/ras/ras_event.h
+F:	Documentation/admin-guide/ras.rst
+
 RAYLINK/WEBGEAR 802.11 WIRELESS LAN DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
