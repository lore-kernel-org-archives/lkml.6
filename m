Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeBFNLt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:11:49 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36824 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbeBFNLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:11:41 -0500
From: Robin Murphy <robin.murphy@arm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, robh@kernel.org
Subject: [PATCH] kconfig: Remove last trace of GENERIC_IO
Date: Tue,  6 Feb 2018 13:11:36 +0000
Message-Id: <422a4ff024038db02a2952158b0babe5b9281b2b.1517922544.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.16.1.dirty
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9de8da47742b ("kconfig: kill off GENERIC_IO option"), this
select has done nothing, and is now just confusing. Clean it up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 lib/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index e96089499371..8ce8bcad6eff 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -396,7 +396,6 @@ config ASSOCIATIVE_ARRAY
 config HAS_IOMEM
 	bool
 	depends on !NO_IOMEM
-	select GENERIC_IO
 	default y
 
 config HAS_IOPORT_MAP
-- 
2.16.1.dirty
