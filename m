Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDAV7a (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 17:59:30 -0400
Received: from mout01.posteo.de ([185.67.36.65]:38643 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbeDAV73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 17:59:29 -0400
From: Martin Kepplinger <martink@posteo.de>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Documentation: devices.rst: minor plural grammar fix
Date: Sun,  1 Apr 2018 23:59:14 +0200
Message-Id: <20180401215914.32101-1-martink@posteo.de>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's authors who request something here, no authors who requests. Let's
fix this.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 Documentation/admin-guide/devices.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/devices.rst b/Documentation/admin-guide/devices.rst
index 7fadc05330dd..f781e80f342d 100644
--- a/Documentation/admin-guide/devices.rst
+++ b/Documentation/admin-guide/devices.rst
@@ -22,7 +22,7 @@ Allocations marked (68k/Amiga) apply to Linux/68k on the Amiga
 platform only.	Allocations marked (68k/Atari) apply to Linux/68k on
 the Atari platform only.
 
-This document is in the public domain.	The authors requests, however,
+This document is in the public domain.	The authors request, however,
 that semantically altered versions are not distributed without
 permission of the authors, assuming the authors can be contacted without
 an unreasonable effort.
-- 
2.16.2
