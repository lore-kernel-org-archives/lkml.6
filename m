Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEDVML (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:12:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50738 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeEDVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:12:09 -0400
X-Google-Smtp-Source: AB8JxZppL2b8dyvZ30YVM4iZ1GcajxIJwuM+7GZ/KpTv6oeSPmAPQRYP8Oq+XBXlgoRR18pMTfBKgg==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] Documentation: refcount-vs-atomic: Update reference to LKMM doc.
Date: Fri,  4 May 2018 23:11:49 +0200
Message-Id: <1525468309-5310-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LKMM project has moved to 'tools/memory-model/'.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 Documentation/core-api/refcount-vs-atomic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
index 83351c258cdb9..322851bada167 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -17,7 +17,7 @@ in order to help maintainers validate their code against the change in
 these memory ordering guarantees.
 
 The terms used through this document try to follow the formal LKMM defined in
-github.com/aparri/memory-model/blob/master/Documentation/explanation.txt
+tools/memory-model/Documentation/explanation.txt.
 
 memory-barriers.txt and atomic_t.txt provide more background to the
 memory ordering in general and for atomic operations specifically.
-- 
2.7.4
