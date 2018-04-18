Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeDRM1t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:27:49 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:40886 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeDRM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:27:48 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Update mailing list address
Date: Wed, 18 Apr 2018 14:27:21 +0200
Message-Id: <20180418122721.21818-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a new mailing list, so update the MAINTAINERS file.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b60179d948bb..4834d1551248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14768,8 +14768,7 @@ F:	drivers/media/usb/zr364xx/
 USER-MODE LINUX (UML)
 M:	Jeff Dike <jdike@addtoit.com>
 M:	Richard Weinberger <richard@nod.at>
-L:	user-mode-linux-devel@lists.sourceforge.net
-L:	user-mode-linux-user@lists.sourceforge.net
+L:	linux-um@lists.infradead.org
 W:	http://user-mode-linux.sourceforge.net
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 S:	Maintained
-- 
2.13.6
