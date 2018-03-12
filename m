Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeCLKEg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:04:36 -0400
Received: from foss.arm.com ([217.140.101.70]:51886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbeCLKEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:04:33 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 0/2] arm64: Expose v8.4 features
Date: Mon, 12 Mar 2018 10:04:12 +0000
Message-Id: <20180312100414.6809-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series applies on arm64's for-next/core branch.

Changes since V2:
 - Dropped "arm64: Relax constraints on ID feature bits" patch
 - Add stand alone patch for removing RES0 fields from the documentation.
  (I have retained Dave's Reviewed-by, as the patch hasn't changed)

Suzuki K Poulose (2):
  arm64: Documentation: cpu-feature-registers: Remove RES0 fields
  arm64: Expose Arm v8.4 features

 Documentation/arm64/cpu-feature-registers.txt | 18 ++++++++++--------
 Documentation/arm64/elf_hwcaps.txt            | 16 ++++++++++++++++
 arch/arm64/include/asm/sysreg.h               |  3 +++
 arch/arm64/include/uapi/asm/hwcap.h           |  4 ++++
 arch/arm64/kernel/cpufeature.c                |  7 +++++++
 arch/arm64/kernel/cpuinfo.c                   |  4 ++++
 6 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.14.3
