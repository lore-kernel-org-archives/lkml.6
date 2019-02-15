Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0588C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78400207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfBOPFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:05:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOPFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:05:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1FF4qxZ1226177
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 07:04:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1FF4p991226174;
        Fri, 15 Feb 2019 07:04:51 -0800
Date:   Fri, 15 Feb 2019 07:04:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hedi Berriche <tipbot@zytor.com>
Message-ID: <tip-f816525d615fff0336d0c881e5d960bbec5ea016@git.kernel.org>
Cc:     linux-efi@vger.kernel.org, hedi.berriche@hpe.com, mingo@redhat.com,
        mike.travis@hpe.com, ard.biesheuvel@linaro.org, sivanich@hpe.com,
        dvhart@infradead.org, steve.wahl@hpe.com, bhsharma@redhat.com,
        tglx@linutronix.de, andy@infradead.org, bp@suse.de, hpa@zytor.com,
        rja@hpe.com, mingo@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: bp@suse.de, hpa@zytor.com, x86@kernel.org,
          linux-kernel@vger.kernel.org, rja@hpe.com, mingo@kernel.org,
          andy@infradead.org, dvhart@infradead.org, tglx@linutronix.de,
          bhsharma@redhat.com, steve.wahl@hpe.com, hedi.berriche@hpe.com,
          linux-efi@vger.kernel.org, mike.travis@hpe.com, mingo@redhat.com,
          ard.biesheuvel@linaro.org, sivanich@hpe.com
In-Reply-To: <20190213193413.25560-3-hedi.berriche@hpe.com>
References: <20190213193413.25560-3-hedi.berriche@hpe.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/uv] x86/platform/UV: Remove uv_bios_call_reentrant()
Git-Commit-ID: f816525d615fff0336d0c881e5d960bbec5ea016
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

Commit-ID:  f816525d615fff0336d0c881e5d960bbec5ea016
Gitweb:     https://git.kernel.org/tip/f816525d615fff0336d0c881e5d960bbec5ea016
Author:     Hedi Berriche <hedi.berriche@hpe.com>
AuthorDate: Wed, 13 Feb 2019 19:34:11 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 15 Feb 2019 15:13:48 +0100

x86/platform/UV: Remove uv_bios_call_reentrant()

uv_bios_call_reentrant() has no callers nor is it exported, remove it.

Cleanup, no functional changes.

Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
Reviewed-by: Mike Travis <mike.travis@hpe.com>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190213193413.25560-3-hedi.berriche@hpe.com
---
 arch/x86/include/asm/uv/bios.h |  1 -
 arch/x86/platform/uv/bios_uv.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 00d862cfbcbe..8c6ac271b5b3 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -140,7 +140,6 @@ enum uv_memprotect {
  */
 extern s64 uv_bios_call(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 extern s64 uv_bios_call_irqsave(enum uv_bios_cmd, u64, u64, u64, u64, u64);
-extern s64 uv_bios_call_reentrant(enum uv_bios_cmd, u64, u64, u64, u64, u64);
 
 extern s64 uv_bios_get_sn_info(int, int *, long *, long *, long *, long *);
 extern s64 uv_bios_freq_base(u64, u64 *);
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 4a61ed2a7bb8..91e3d5285836 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -66,18 +66,6 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	return ret;
 }
 
-s64 uv_bios_call_reentrant(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
-					u64 a4, u64 a5)
-{
-	s64 ret;
-
-	preempt_disable();
-	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
-	preempt_enable();
-
-	return ret;
-}
-
 
 long sn_partition_id;
 EXPORT_SYMBOL_GPL(sn_partition_id);
