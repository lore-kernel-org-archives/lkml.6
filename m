Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1BD2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfBDUno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:43:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfBDUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:43:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x14Kguxg563287
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 12:42:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x14KgtoA563284;
        Mon, 4 Feb 2019 12:42:55 -0800
Date:   Mon, 4 Feb 2019 12:42:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-cbfa447edd6a3825fdb8a4ffae74ff7208f2d2c0@git.kernel.org>
Cc:     linux-edac@vger.kernel.org, yazen.ghannam@amd.com, hpa@zytor.com,
        mchehab@kernel.org, arnd@arndb.de, x86@kernel.org, bp@suse.de,
        Shirish.S@amd.com, tony.luck@intel.com, qiuxu.zhuo@intel.com,
        mingo@redhat.com, vishal.l.verma@intel.com, keescook@chromium.org,
        tglx@linutronix.de, puwen@hygon.cn, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Reply-To: vishal.l.verma@intel.com, keescook@chromium.org,
          tglx@linutronix.de, mingo@kernel.org, puwen@hygon.cn,
          linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
          yazen.ghannam@amd.com, hpa@zytor.com, mchehab@kernel.org,
          arnd@arndb.de, bp@suse.de, x86@kernel.org, tony.luck@intel.com,
          Shirish.S@amd.com, qiuxu.zhuo@intel.com, mingo@redhat.com
In-Reply-To: <20190201225534.8177-2-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-2-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE/AMD, EDAC/mce_amd: Add new MP5, NBIO, and
 PCIE SMCA bank types
Git-Commit-ID: cbfa447edd6a3825fdb8a4ffae74ff7208f2d2c0
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

Commit-ID:  cbfa447edd6a3825fdb8a4ffae74ff7208f2d2c0
Gitweb:     https://git.kernel.org/tip/cbfa447edd6a3825fdb8a4ffae74ff7208f2d2c0
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 1 Feb 2019 22:55:51 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 3 Feb 2019 13:01:44 +0100

x86/MCE/AMD, EDAC/mce_amd: Add new MP5, NBIO, and PCIE SMCA bank types

Add the (HWID, MCATYPE) tuples and names for the new MP5, NBIO, and
PCIE SMCA bank types.

Also, add their respective error descriptions to the MCE decoding module
edac_mce_amd.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Shirish S <Shirish.S@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190201225534.8177-2-Yazen.Ghannam@amd.com
---
 arch/x86/include/asm/mce.h    |  3 +++
 arch/x86/kernel/cpu/mce/amd.c | 12 ++++++++++++
 drivers/edac/mce_amd.c        | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c1a812bd5a27..91b65d859ca8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -312,6 +312,9 @@ enum smca_bank_types {
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
 	SMCA_SMU,	/* System Management Unit */
+	SMCA_MP5,	/* Microprocessor 5 Unit */
+	SMCA_NBIO,	/* Northbridge IO Unit */
+	SMCA_PCIE,	/* PCI Express Unit */
 	N_SMCA_BANK_TYPES
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ed3327342b40..00f60b8c7e4f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -93,6 +93,9 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_PB]	= { "param_block",	"Parameter Block" },
 	[SMCA_PSP]	= { "psp",		"Platform Security Processor" },
 	[SMCA_SMU]	= { "smu",		"System Management Unit" },
+	[SMCA_MP5]	= { "mp5",		"Microprocessor 5 Unit" },
+	[SMCA_NBIO]	= { "nbio",		"Northbridge IO Unit" },
+	[SMCA_PCIE]	= { "pcie",		"PCI Express Unit" },
 };
 
 static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
@@ -162,6 +165,15 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* System Management Unit MCA type */
 	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0), 0x1 },
+
+	/* Microprocessor 5 Unit MCA type */
+	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2), 0x3FF },
+
+	/* Northbridge IO Unit MCA type */
+	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0), 0x1F },
+
+	/* PCI Express Unit MCA type */
+	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0), 0x1F },
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index c605089d899f..5ab4ab3f0ce6 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -285,6 +285,35 @@ static const char * const smca_smu_mce_desc[] = {
 	"SMU RAM ECC or parity error",
 };
 
+static const char * const smca_mp5_mce_desc[] = {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+};
+
+static const char * const smca_nbio_mce_desc[] = {
+	"ECC or Parity error",
+	"PCIE error",
+	"SDP ErrEvent error",
+	"SDP Egress Poison Error",
+	"IOHC Internal Poison Error",
+};
+
+static const char * const smca_pcie_mce_desc[] = {
+	"CCIX PER Message logging",
+	"CCIX Read Response with Status: Non-Data Error",
+	"CCIX Write Response with Status: Non-Data Error",
+	"CCIX Read Response with Status: Data Error",
+	"CCIX Non-okay write response with data error",
+};
+
 struct smca_mce_desc {
 	const char * const *descs;
 	unsigned int num_descs;
@@ -304,6 +333,9 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_PB]	= { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
 	[SMCA_PSP]	= { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
 	[SMCA_SMU]	= { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
+	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
+	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
+	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
 };
 
 static bool f12h_mc0_mce(u16 ec, u8 xec)
