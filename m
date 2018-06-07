Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1LNHEnBDGVsXCAAAmS7hNA
	; Thu, 07 Jun 2018 14:38:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 38D006089E; Thu,  7 Jun 2018 14:38:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8EFFA601C3;
	Thu,  7 Jun 2018 14:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EFFA601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934243AbeFGOih (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:38:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40477 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934023AbeFGOiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:38:25 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zo-Ty; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jL-IM; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.703013321@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 040/410] x86/cpu: Rename Merrifield2 to Moorefield
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit f5fbf848303c8704d0e1a1e7cabd08fd0a49552f upstream.

Merrifield2 is actually Moorefield.

Rename it accordingly and drop tail digit from Merrifield1.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20160906184254.94440-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: Drop driver changes]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/intel-family.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -56,8 +56,8 @@
 #define INTEL_FAM6_ATOM_SILVERMONT1	0x37 /* BayTrail/BYT / Valleyview */
 #define INTEL_FAM6_ATOM_SILVERMONT2	0x4D /* Avaton/Rangely */
 #define INTEL_FAM6_ATOM_AIRMONT		0x4C /* CherryTrail / Braswell */
-#define INTEL_FAM6_ATOM_MERRIFIELD1	0x4A /* Tangier */
-#define INTEL_FAM6_ATOM_MERRIFIELD2	0x5A /* Annidale */
+#define INTEL_FAM6_ATOM_MERRIFIELD	0x4A /* Tangier */
+#define INTEL_FAM6_ATOM_MOOREFIELD	0x5A /* Annidale */
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C
 #define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
 
