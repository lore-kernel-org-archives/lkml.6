Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeC0NAZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:00:25 -0400
Received: from mout01.posteo.de ([185.67.36.65]:34665 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbeC0NAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:00:23 -0400
From: Martin Kepplinger <martink@posteo.de>
To: corbet@lwn.net
Cc: mchehab@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] Documentation/process: update FUSE project website
Date: Tue, 27 Mar 2018 14:59:50 +0200
Message-Id: <20180327125950.717-1-martink@posteo.de>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the old project site, https://sourceforge.net/projects/fuse/
the project has moved to https://github.com/libfuse/ so we update the
link to point to the latest libfuse release.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 Documentation/process/changes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 4f19a9725f76..ddc029734b25 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -430,7 +430,7 @@ udev
 FUSE
 ----
 
-- <http://sourceforge.net/projects/fuse>
+- <https://github.com/libfuse/libfuse/releases>
 
 mcelog
 ------
-- 
2.14.2
