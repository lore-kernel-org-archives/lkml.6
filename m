Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EE2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101D82073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfBDUpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:45:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfBDUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:45:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x14Kin6O565004
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 12:44:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x14Kins2565001;
        Mon, 4 Feb 2019 12:44:49 -0800
Date:   Mon, 4 Feb 2019 12:44:49 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-e03447ee718b331be8f3abc388c7bf7d325dfab4@git.kernel.org>
Cc:     mchehab@kernel.org, tony.luck@intel.com, bp@suse.de,
        linux-edac@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        yazen.ghannam@amd.com
Reply-To: bp@suse.de, mchehab@kernel.org, tony.luck@intel.com,
          hpa@zytor.com, linux-edac@vger.kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          yazen.ghannam@amd.com
In-Reply-To: <20190201225534.8177-5-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-5-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] EDAC, mce_amd: Match error descriptions to latest
 documentation
Git-Commit-ID: e03447ee718b331be8f3abc388c7bf7d325dfab4
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

Commit-ID:  e03447ee718b331be8f3abc388c7bf7d325dfab4
Gitweb:     https://git.kernel.org/tip/e03447ee718b331be8f3abc388c7bf7d325dfab4
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 1 Feb 2019 22:55:53 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 3 Feb 2019 13:16:50 +0100

EDAC, mce_amd: Match error descriptions to latest documentation

Update the error descriptions to match the latest documentation for
easier searching. In some cases the changes are small and in other cases
the changes may be total rewording of the description.

No functional changes.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190201225534.8177-5-Yazen.Ghannam@amd.com
---
 drivers/edac/mce_amd.c | 166 ++++++++++++++++++++++++-------------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index c79e650aa606..7e29ceabdf6f 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -151,74 +151,74 @@ static const char * const mc6_mce_desc[] = {
 
 /* Scalable MCA error strings */
 static const char * const smca_ls_mce_desc[] = {
-	"Load queue parity",
-	"Store queue parity",
-	"Miss address buffer payload parity",
-	"L1 TLB parity",
+	"Load queue parity error",
+	"Store queue parity error",
+	"Miss address buffer payload parity error",
+	"Level 1 TLB parity error",
 	"DC Tag error type 5",
-	"DC tag error type 6",
-	"DC tag error type 1",
+	"DC Tag error type 6",
+	"DC Tag error type 1",
 	"Internal error type 1",
 	"Internal error type 2",
-	"Sys Read data error thread 0",
-	"Sys read data error thread 1",
-	"DC tag error type 2",
-	"DC data error type 1 (poison consumption)",
-	"DC data error type 2",
-	"DC data error type 3",
-	"DC tag error type 4",
-	"L2 TLB parity",
+	"System Read Data Error Thread 0",
+	"System Read Data Error Thread 1",
+	"DC Tag error type 2",
+	"DC Data error type 1 and poison consumption",
+	"DC Data error type 2",
+	"DC Data error type 3",
+	"DC Tag error type 4",
+	"Level 2 TLB parity error",
 	"PDC parity error",
-	"DC tag error type 3",
-	"DC tag error type 5",
-	"L2 fill data error",
+	"DC Tag error type 3",
+	"DC Tag error type 5",
+	"L2 Fill Data error",
 };
 
 static const char * const smca_if_mce_desc[] = {
-	"microtag probe port parity error",
-	"IC microtag or full tag multi-hit error",
-	"IC full tag parity",
-	"IC data array parity",
-	"Decoupling queue phys addr parity error",
-	"L0 ITLB parity error",
-	"L1 ITLB parity error",
-	"L2 ITLB parity error",
-	"BPQ snoop parity on Thread 0",
-	"BPQ snoop parity on Thread 1",
-	"L1 BTB multi-match error",
-	"L2 BTB multi-match error",
-	"L2 Cache Response Poison error",
-	"System Read Data error",
+	"Op Cache Microtag Probe Port Parity Error",
+	"IC Microtag or Full Tag Multi-hit Error",
+	"IC Full Tag Parity Error",
+	"IC Data Array Parity Error",
+	"Decoupling Queue PhysAddr Parity Error",
+	"L0 ITLB Parity Error",
+	"L1 ITLB Parity Error",
+	"L2 ITLB Parity Error",
+	"BPQ Thread 0 Snoop Parity Error",
+	"BPQ Thread 1 Snoop Parity Error",
+	"L1 BTB Multi-Match Error",
+	"L2 BTB Multi-Match Error",
+	"L2 Cache Response Poison Error",
+	"System Read Data Error",
 };
 
 static const char * const smca_l2_mce_desc[] = {
-	"L2M tag multi-way-hit error",
-	"L2M tag ECC error",
-	"L2M data ECC error",
-	"HW assert",
+	"L2M Tag Multiple-Way-Hit error",
+	"L2M Tag or State Array ECC Error",
+	"L2M Data Array ECC Error",
+	"Hardware Assert Error",
 };
 
 static const char * const smca_de_mce_desc[] = {
-	"uop cache tag parity error",
-	"uop cache data parity error",
-	"Insn buffer parity error",
-	"uop queue parity error",
-	"Insn dispatch queue parity error",
-	"Fetch address FIFO parity",
-	"Patch RAM data parity",
-	"Patch RAM sequencer parity",
-	"uop buffer parity"
+	"Micro-op cache tag parity error",
+	"Micro-op cache data parity error",
+	"Instruction buffer parity error",
+	"Micro-op queue parity error",
+	"Instruction dispatch queue parity error",
+	"Fetch address FIFO parity error",
+	"Patch RAM data parity error",
+	"Patch RAM sequencer parity error",
+	"Micro-op buffer parity error"
 };
 
 static const char * const smca_ex_mce_desc[] = {
-	"Watchdog timeout error",
-	"Phy register file parity",
-	"Flag register file parity",
-	"Immediate displacement register file parity",
-	"Address generator payload parity",
-	"EX payload parity",
-	"Checkpoint queue parity",
-	"Retire dispatch queue parity",
+	"Watchdog Timeout error",
+	"Physical register file parity error",
+	"Flag register file parity error",
+	"Immediate displacement register file parity error",
+	"Address generator payload parity error",
+	"EX payload parity error",
+	"Checkpoint queue parity error",
+	"Retire dispatch queue parity error",
 	"Retire status queue parity error",
 	"Scheduling queue parity error",
 	"Branch buffer queue parity error",
@@ -226,36 +226,36 @@ static const char * const smca_ex_mce_desc[] = {
 };
 
 static const char * const smca_fp_mce_desc[] = {
-	"Physical register file parity",
-	"Freelist parity error",
-	"Schedule queue parity",
+	"Physical register file (PRF) parity error",
+	"Freelist (FL) parity error",
+	"Schedule queue parity error",
 	"NSQ parity error",
-	"Retire queue parity",
-	"Status register file parity",
+	"Retire queue (RQ) parity error",
+	"Status register file (SRF) parity error",
 	"Hardware assertion",
 };
 
 static const char * const smca_l3_mce_desc[] = {
-	"Shadow tag macro ECC error",
-	"Shadow tag macro multi-way-hit error",
-	"L3M tag ECC error",
-	"L3M tag multi-way-hit error",
-	"L3M data ECC error",
-	"XI parity, L3 fill done channel error",
-	"L3 victim queue parity",
-	"L3 HW assert",
+	"Shadow Tag Macro ECC Error",
+	"Shadow Tag Macro Multi-way-hit Error",
+	"L3M Tag ECC Error",
+	"L3M Tag Multi-way-hit Error",
+	"L3M Data ECC Error",
+	"SDP Parity Error or SystemReadDataError from XI",
+	"L3 Victim Queue Parity Error",
+	"L3 Hardware Assertion",
 };
 
 static const char * const smca_cs_mce_desc[] = {
-	"Illegal request from transport layer",
-	"Address violation",
-	"Security violation",
-	"Illegal response from transport layer",
-	"Unexpected response",
-	"Parity error on incoming request or probe response data",
-	"Parity error on incoming read response data",
-	"Atomic request parity",
-	"ECC error on probe filter access",
+	"Illegal Request",
+	"Address Violation",
+	"Security Violation",
+	"Illegal Response",
+	"Unexpected Response",
+	"Request or Probe Parity Error",
+	"Read Response Parity Error",
+	"Atomic Request Parity Error",
+	"Probe Filter ECC Error",
 };
 
 static const char * const smca_cs2_mce_desc[] = {
@@ -276,30 +276,30 @@ static const char * const smca_cs2_mce_desc[] = {
 };
 
 static const char * const smca_pie_mce_desc[] = {
-	"HW assert",
-	"Internal PIE register security violation",
-	"Error on GMI link",
-	"Poison data written to internal PIE register",
+	"Hardware Assert",
+	"Register security violation",
+	"Link Error",
+	"Poison data consumption",
 	"A deferred error was detected in the DF"
 };
 
 static const char * const smca_umc_mce_desc[] = {
 	"DRAM ECC error",
-	"Data poison error on DRAM",
+	"Data poison error",
 	"SDP parity error",
 	"Advanced peripheral bus error",
-	"Command/address parity error",
+	"Address/Command parity error",
 	"Write data CRC error",
 	"DCQ SRAM ECC error",
 	"AES SRAM ECC error",
 };
 
 static const char * const smca_pb_mce_desc[] = {
-	"Parameter Block RAM ECC error",
+	"An ECC error in the Parameter Block RAM array",
 };
 
 static const char * const smca_psp_mce_desc[] = {
-	"PSP RAM ECC or parity error",
+	"An ECC or parity error in a PSP RAM instance",
 };
 
 static const char * const smca_psp2_mce_desc[] = {
@@ -324,7 +324,7 @@ static const char * const smca_psp2_mce_desc[] = {
 };
 
 static const char * const smca_smu_mce_desc[] = {
-	"SMU RAM ECC or parity error",
+	"An ECC or parity error in an SMU RAM instance",
 };
 
 static const char * const smca_smu2_mce_desc[] = {
