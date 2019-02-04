Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DCD2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfBDUoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:44:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfBDUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:44:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x14KiBYB564952
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 12:44:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x14KiB2C564949;
        Mon, 4 Feb 2019 12:44:11 -0800
Date:   Mon, 4 Feb 2019 12:44:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-8a5dd2cd2f2e94878cacc969655a69ca214795ab@git.kernel.org>
Cc:     x86@kernel.org, mingo@redhat.com, bp@suse.de, mchehab@kernel.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Shirish.S@amd.com, mingo@kernel.org,
        keescook@chromium.org, yazen.ghannam@amd.com, hpa@zytor.com,
        linux-edac@vger.kernel.org
Reply-To: x86@kernel.org, bp@suse.de, mingo@redhat.com, mchehab@kernel.org,
          tony.luck@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, Shirish.S@amd.com,
          tglx@linutronix.de, hpa@zytor.com, linux-edac@vger.kernel.org,
          yazen.ghannam@amd.com, keescook@chromium.org
In-Reply-To: <20190201225534.8177-4-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-4-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE/AMD, EDAC/mce_amd: Add new error
 descriptions for some SMCA bank types
Git-Commit-ID: 8a5dd2cd2f2e94878cacc969655a69ca214795ab
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

Commit-ID:  8a5dd2cd2f2e94878cacc969655a69ca214795ab
Gitweb:     https://git.kernel.org/tip/8a5dd2cd2f2e94878cacc969655a69ca214795ab
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 1 Feb 2019 22:55:52 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 3 Feb 2019 13:05:16 +0100

x86/MCE/AMD, EDAC/mce_amd: Add new error descriptions for some SMCA bank types

Some SMCA bank types on future systems will report new error types even
though the bank type is not treated as a new version. These new error
types will reported by bits that are reserved in past systems.

Add the new error descriptions to the lists in edac_mce_amd.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Shirish S <Shirish.S@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190201225534.8177-4-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c | 8 ++++----
 drivers/edac/mce_amd.c        | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index bd1331b241ca..e64de5149e50 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -144,22 +144,22 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
 
 	/* ZN Core (HWID=0xB0) MCA types */
-	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFEF },
+	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFFF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
 	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2), 0xF },
 	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3), 0x1FF },
 	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
-	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5), 0x7FF },
+	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5), 0xFFF },
 	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6), 0x7F },
 	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7), 0xFF },
 
 	/* Data Fabric MCA types */
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0), 0x1FF },
-	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0xF },
+	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0x1F },
 	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2), 0x3FFF },
 
 	/* Unified Memory Controller MCA type */
-	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0x3F },
+	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0xFF },
 
 	/* Parameter Block MCA type */
 	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0), 0x1 },
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 184c90172d17..c79e650aa606 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -155,7 +155,7 @@ static const char * const smca_ls_mce_desc[] = {
 	"Store queue parity",
 	"Miss address buffer payload parity",
 	"L1 TLB parity",
-	"Reserved",
+	"DC Tag error type 5",
 	"DC tag error type 6",
 	"DC tag error type 1",
 	"Internal error type 1",
@@ -222,6 +222,7 @@ static const char * const smca_ex_mce_desc[] = {
 	"Retire status queue parity error",
 	"Scheduling queue parity error",
 	"Branch buffer queue parity error",
+	"Hardware Assertion error",
 };
 
 static const char * const smca_fp_mce_desc[] = {
@@ -279,6 +280,7 @@ static const char * const smca_pie_mce_desc[] = {
 	"Internal PIE register security violation",
 	"Error on GMI link",
 	"Poison data written to internal PIE register",
+	"A deferred error was detected in the DF"
 };
 
 static const char * const smca_umc_mce_desc[] = {
@@ -288,6 +290,8 @@ static const char * const smca_umc_mce_desc[] = {
 	"Advanced peripheral bus error",
 	"Command/address parity error",
 	"Write data CRC error",
+	"DCQ SRAM ECC error",
+	"AES SRAM ECC error",
 };
 
 static const char * const smca_pb_mce_desc[] = {
