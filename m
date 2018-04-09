Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeDIQuX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:50:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34196 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753089AbeDIQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:50:22 -0400
X-Google-Smtp-Source: AIpwx49NBKiOssh4aNnTJnG3IuoAowhpYhon46dTlWj2LnuGSJnlrSwJg490RwavHqVwnpBxv2sObw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] memory-model: fix cheat sheet typo
Date: Mon,  9 Apr 2018 18:50:15 +0200
Message-Id: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"RWM" should be "RMW", and that's more or less the extent to which I
can claim to change the document. :)  In particular, "Self" is not
documented and the difference between "Self" and "SV" is not clear
to me.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 956b1ae4aafb..c0eafdaddfa4 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -1,6 +1,6 @@
                                   Prior Operation     Subsequent Operation
                                   ---------------  ---------------------------
-                               C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
+                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
-- 
1.8.3.1
