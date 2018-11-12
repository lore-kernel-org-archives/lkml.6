Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4A0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DEC2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4DEC2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeKLPyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:54:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbeKLPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:54:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAC6290Z3546647
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Nov 2018 22:02:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAC629F83546644;
        Sun, 11 Nov 2018 22:02:09 -0800
Date:   Sun, 11 Nov 2018 22:02:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-c10a8de0d32e95b0b8c7c17b6dc09baea5a5a899@git.kernel.org>
Cc:     acme@redhat.com, kan.liang@linux.intel.com,
        torvalds@linux-foundation.org, eranian@google.com,
        mingo@kernel.org, peterz@infradead.org, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, eranian@google.com,
          torvalds@linux-foundation.org, kan.liang@linux.intel.com,
          acme@redhat.com, vincent.weaver@maine.edu, peterz@infradead.org
In-Reply-To: <20181019170419.378-1-kan.liang@linux.intel.com>
References: <20181019170419.378-1-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Add more IMC PCI IDs for
 KabyLake and CoffeeLake CPUs
Git-Commit-ID: c10a8de0d32e95b0b8c7c17b6dc09baea5a5a899
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

Commit-ID:  c10a8de0d32e95b0b8c7c17b6dc09baea5a5a899
Gitweb:     https://git.kernel.org/tip/c10a8de0d32e95b0b8c7c17b6dc09baea5a5a899
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Fri, 19 Oct 2018 10:04:18 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Nov 2018 05:03:24 +0100

perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLake CPUs

KabyLake and CoffeeLake CPUs have the same client uncore events as SkyLake.

Add the PCI IDs for the KabyLake Y, U, S processor lines and CoffeeLake U,
H, S processor lines.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20181019170419.378-1-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snb.c | 115 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 8527c3e1038b..bfa25814fe5f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -15,6 +15,25 @@
 #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC	0x1910
 #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC	0x190f
 #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC	0x191f
+#define PCI_DEVICE_ID_INTEL_KBL_Y_IMC	0x590c
+#define PCI_DEVICE_ID_INTEL_KBL_U_IMC	0x5904
+#define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC	0x5914
+#define PCI_DEVICE_ID_INTEL_KBL_SD_IMC	0x590f
+#define PCI_DEVICE_ID_INTEL_KBL_SQ_IMC	0x591f
+#define PCI_DEVICE_ID_INTEL_CFL_2U_IMC	0x3ecc
+#define PCI_DEVICE_ID_INTEL_CFL_4U_IMC	0x3ed0
+#define PCI_DEVICE_ID_INTEL_CFL_4H_IMC	0x3e10
+#define PCI_DEVICE_ID_INTEL_CFL_6H_IMC	0x3ec4
+#define PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC	0x3e0f
+#define PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC	0x3e1f
+#define PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC	0x3ec2
+#define PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC	0x3e30
+#define PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC	0x3e18
+#define PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC	0x3ec6
+#define PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC	0x3e31
+#define PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC	0x3e33
+#define PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC	0x3eca
+#define PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC	0x3e32
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -569,7 +588,82 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SQ_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
-
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_UQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SD_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SQ_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4U_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4H_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6H_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ },
 };
 
@@ -618,6 +712,25 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
 	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
 	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
+	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
+	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
+	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
+	IMC_DEV(KBL_SD_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Dual Core */
+	IMC_DEV(KBL_SQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core S Quad Core */
+	IMC_DEV(CFL_2U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 2 Cores */
+	IMC_DEV(CFL_4U_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core U 4 Cores */
+	IMC_DEV(CFL_4H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 4 Cores */
+	IMC_DEV(CFL_6H_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core H 6 Cores */
+	IMC_DEV(CFL_2S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 2 Cores Desktop */
+	IMC_DEV(CFL_4S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Desktop */
+	IMC_DEV(CFL_6S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Desktop */
+	IMC_DEV(CFL_8S_D_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Desktop */
+	IMC_DEV(CFL_4S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Work Station */
+	IMC_DEV(CFL_6S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Work Station */
+	IMC_DEV(CFL_8S_W_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Work Station */
+	IMC_DEV(CFL_4S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 4 Cores Server */
+	IMC_DEV(CFL_6S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 6 Cores Server */
+	IMC_DEV(CFL_8S_S_IMC, &skl_uncore_pci_driver),  /* 8th Gen Core S 8 Cores Server */
 	{  /* end marker */ }
 };
 
