Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933007AbeCMLR2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:17:28 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:34603 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbeCMLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:17:26 -0400
From: Eric Engestrom <eric.engestrom@imgtec.com>
To: <linux-kernel@vger.kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <trivial@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [trivial PATCH] Documentation/sparse: fix typo
Date: Tue, 13 Mar 2018 11:10:58 +0000
Message-ID: <20180313111128.5803-1-eric.engestrom@imgtec.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.60.4.28]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
---
 Documentation/dev-tools/sparse.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
index 78aa00a604a009071361..c401c952a340a50fa769 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -67,7 +67,7 @@ __releases - The specified lock is held on function entry, but not exit.
 
 If the function enters and exits without the lock held, acquiring and
 releasing the lock inside the function in a balanced way, no
-annotation is needed.  The tree annotations above are for cases where
+annotation is needed.  The three annotations above are for cases where
 sparse would otherwise report a context imbalance.
 
 Getting sparse
-- 
Cheers,
  Eric
