Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C107C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D524120846
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D524120846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeH0MVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:21:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:21:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7R8ZKO0511051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Aug 2018 01:35:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7R8ZKdj511048;
        Mon, 27 Aug 2018 01:35:20 -0700
Date:   Mon, 27 Aug 2018 01:35:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nikolas Nyby <tipbot@zytor.com>
Message-ID: <tip-e3a5dc08715abba646324fd8456282bd77798e9c@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        nikolas@gnu.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, nikolas@gnu.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180825231054.23813-1-nikolas@gnu.org>
References: <20180825231054.23813-1-nikolas@gnu.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/Kconfig: Fix trivial typo
Git-Commit-ID: e3a5dc08715abba646324fd8456282bd77798e9c
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

Commit-ID:  e3a5dc08715abba646324fd8456282bd77798e9c
Gitweb:     https://git.kernel.org/tip/e3a5dc08715abba646324fd8456282bd77798e9c
Author:     Nikolas Nyby <nikolas@gnu.org>
AuthorDate: Sat, 25 Aug 2018 19:10:54 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 27 Aug 2018 10:29:14 +0200

x86/Kconfig: Fix trivial typo

Fix a typo in the Kconfig help text: adverticed -> advertised.

Signed-off-by: Nikolas Nyby <nikolas@gnu.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: trivial@kernel.org
Cc: tglx@linutronix.de
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20180825231054.23813-1-nikolas@gnu.org

---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c5ff296bc5d1..1a0be022f91d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2843,7 +2843,7 @@ config X86_SYSFB
 	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic
 	  framebuffers so the new generic system-framebuffer drivers can be
 	  used on x86. If the framebuffer is not compatible with the generic
-	  modes, it is adverticed as fallback platform framebuffer so legacy
+	  modes, it is advertised as fallback platform framebuffer so legacy
 	  drivers like efifb, vesafb and uvesafb can pick it up.
 	  If this option is not selected, all system framebuffers are always
 	  marked as fallback platform framebuffers as usual.
