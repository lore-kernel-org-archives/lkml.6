Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbeCLKE7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:04:59 -0400
Received: from foss.arm.com ([217.140.101.70]:51896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752689AbeCLKEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:04:35 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 1/2] arm64: Documentation: cpu-feature-registers: Remove RES0 fields
Date: Mon, 12 Mar 2018 10:04:13 +0000
Message-Id: <20180312100414.6809-2-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180312100414.6809-1-suzuki.poulose@arm.com>
References: <20180312100414.6809-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the invisible RES0 field entries from the table, listing
fields in CPU ID feature registers, as :
 1) We are only interested in the user visible fields.
 2) The field description may not be up-to-date, as the
    field could be assigned a new meaning.
 3) We already explain the rules of the fields which are not
    visible.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/cpu-feature-registers.txt | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
index a70090b28b07..22cfb86143ee 100644
--- a/Documentation/arm64/cpu-feature-registers.txt
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -110,7 +110,6 @@ infrastructure:
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
      |--------------------------------------------------|
-     | RES0                         | [63-52] |    n    |
      |--------------------------------------------------|
      | FHM                          | [51-48] |    y    |
      |--------------------------------------------------|
@@ -124,8 +123,6 @@ infrastructure:
      |--------------------------------------------------|
      | RDM                          | [31-28] |    y    |
      |--------------------------------------------------|
-     | RES0                         | [27-24] |    n    |
-     |--------------------------------------------------|
      | ATOMICS                      | [23-20] |    y    |
      |--------------------------------------------------|
      | CRC32                        | [19-16] |    y    |
@@ -135,8 +132,6 @@ infrastructure:
      | SHA1                         | [11-8]  |    y    |
      |--------------------------------------------------|
      | AES                          | [7-4]   |    y    |
-     |--------------------------------------------------|
-     | RES0                         | [3-0]   |    n    |
      x--------------------------------------------------x
 
 
@@ -144,12 +139,9 @@ infrastructure:
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
      |--------------------------------------------------|
-     | RES0                         | [63-36] |    n    |
      |--------------------------------------------------|
      | SVE                          | [35-32] |    y    |
      |--------------------------------------------------|
-     | RES0                         | [31-28] |    n    |
-     |--------------------------------------------------|
      | GIC                          | [27-24] |    n    |
      |--------------------------------------------------|
      | AdvSIMD                      | [23-20] |    y    |
-- 
2.14.3
