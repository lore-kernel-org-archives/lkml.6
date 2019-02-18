Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB84C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C487C2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbfBRQfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:35:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbfBRQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:35:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1IGYEge2650898
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 08:34:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1IGYCMV2650892;
        Mon, 18 Feb 2019 08:34:12 -0800
Date:   Mon, 18 Feb 2019 08:34:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shaokun Zhang <tipbot@zytor.com>
Message-ID: <tip-f91fecc09e498529230b4d5053cb361619a0c42d@git.kernel.org>
Cc:     imammedo@redhat.com, tglx@linutronix.de, puwen@hygon.cn,
        x86@kernel.org, suravee.suthikulpanit@amd.com, bp@suse.de,
        mingo@redhat.com, zhenzhong.duan@oracle.com, mingo@kernel.org,
        yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        zhangshaokun@hisilicon.com, konrad.wilk@oracle.com,
        rppt@linux.vnet.ibm.com, hpa@zytor.com, alison.schofield@intel.com
Reply-To: alison.schofield@intel.com, hpa@zytor.com,
          konrad.wilk@oracle.com, rppt@linux.vnet.ibm.com,
          mingo@kernel.org, zhangshaokun@hisilicon.com,
          yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
          mingo@redhat.com, zhenzhong.duan@oracle.com, bp@suse.de,
          suravee.suthikulpanit@amd.com, x86@kernel.org,
          imammedo@redhat.com, puwen@hygon.cn, tglx@linutronix.de
In-Reply-To: <1550495101-41755-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1550495101-41755-1-git-send-email-zhangshaokun@hisilicon.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/smpboot: Remove unused phys_id variable
Git-Commit-ID: f91fecc09e498529230b4d5053cb361619a0c42d
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

Commit-ID:  f91fecc09e498529230b4d5053cb361619a0c42d
Gitweb:     https://git.kernel.org/tip/f91fecc09e498529230b4d5053cb361619a0c42d
Author:     Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate: Mon, 18 Feb 2019 21:05:01 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 18 Feb 2019 17:09:24 +0100

x86/smpboot: Remove unused phys_id variable

The 'phys_id' local variable became unused after commit

  ce4b1b16502b ("x86/smpboot: Initialize secondary CPU only if master CPU will wait for it").

Remove it.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Link: https://lkml.kernel.org/r/1550495101-41755-1-git-send-email-zhangshaokun@hisilicon.com
---
 arch/x86/kernel/smpboot.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ccd1f2a8e557..5d5421b48e55 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -149,7 +149,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
  */
 static void smp_callin(void)
 {
-	int cpuid, phys_id;
+	int cpuid;
 
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
@@ -159,11 +159,6 @@ static void smp_callin(void)
 	 */
 	cpuid = smp_processor_id();
 
-	/*
-	 * (This works even if the APIC is not enabled.)
-	 */
-	phys_id = read_apic_id();
-
 	/*
 	 * the boot CPU has finished the init stage and is spinning
 	 * on callin_map until we finish. We are free to set up this
