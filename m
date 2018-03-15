Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932222AbeCONtm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:49:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:15486 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752378AbeCONtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:49:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="25513886"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] x86/mm: Fix couple MKTME-related issues
Date: Thu, 15 Mar 2018 16:49:05 +0300
Message-Id: <20180315134907.9311-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kai has pointed to few issues around x86_phys_bits in MKTME changes.

Here is fixes. Please review and consider applying.

Kirill A. Shutemov (2):
  x86/mm: Fix comment in detect_tme() regarding x86_phys_bits
  x86/mm: Do not lose cpuinfo_x86:x86_phys_bits adjustment

 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/amd.c        |  3 ++-
 arch/x86/kernel/cpu/common.c     | 14 ++++++++++++++
 arch/x86/kernel/cpu/intel.c      |  8 +++-----
 4 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.16.1
