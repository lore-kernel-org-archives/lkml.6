Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeBBNtJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:49:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:38319 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBBNs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:48:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="14968301"
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: platform-driver-x86@vger.kernel.org
Cc: dvhart@infradead.org, andy@infradead.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, srinivas.pandruvada@linux.intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org,
        x86@kernel.org
Subject: [Patch v2 0/5] platform/x86: intel_pmc_core: Add CFL/CNL Support
Date: Fri,  2 Feb 2018 19:13:32 +0530
Message-Id: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains the remaining (rebased) patches that were not applied
to the pdx tree earlier. This also includes Acked-by / Reviewed-by tags from
Rafael and Thomas.

Rebased and tested on:
http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>

Cc: linux-acpi@vger.kernel.org
Cc: x86@kernel.org

Rajneesh Bhardwaj (3):
  x86/cpu: Add Cannonlake to Intel family
  platform/x86: intel_pmc_core: Add CannonLake PCH support
  platform/x86: intel_pmc_core: Special case for Coffeelake

Srinivas Pandruvada (2):
  ACPI / LPIT: Export lpit_read_residency_count_address()
  platform/x86: intel_pmc_core: Read base address from LPIT

 arch/x86/include/asm/intel-family.h   |   6 ++
 drivers/acpi/acpi_lpit.c              |   1 +
 drivers/platform/x86/intel_pmc_core.c | 108 +++++++++++++++++++++++++++++++++-
 drivers/platform/x86/intel_pmc_core.h |  13 ++++
 4 files changed, 127 insertions(+), 1 deletion(-)

-- 
2.7.4
