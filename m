Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965549AbeCACwi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:52:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:19345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965522AbeCACwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:52:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="21932195"
Message-ID: <1519872317.58658.186.camel@intel.com>
Subject: [PATCH v2 0/3] x86: devicetree: re-enable x86-specific
 implementation
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Date: Wed, 28 Feb 2018 18:45:17 -0800
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing x86-specific DT implementation in the kernel allows reusing most of
firmware code for SoC that have ARM core replaced with x86, e.g. SC9853i.

Changes since first version:

 * Splitting a single patch into three parts

Ivan Gorinov (3):
  x86: devicetree: call early_init_dt_verify()
  x86: devicetree: enable multiprocessing in DT
  x86: devicetree: fix device IRQ settings in DT

 arch/x86/kernel/devicetree.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

-- 
2.7.4
