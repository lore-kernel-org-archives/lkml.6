Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968492AbeE0PCO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:02:14 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:42342 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965011AbeE0PCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:02:12 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 2/5] doc: add chapter labels
Date: Sun, 27 May 2018 16:55:57 +0200
Message-Id: <20180527145559.16411-3-federico.vaga@vaga.pv.it>
In-Reply-To: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
References: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to make it easier to create references (doc-guide does the same).

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/index.rst                | 2 ++
 Documentation/kernel-hacking/index.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 331da87c82c8..8f11fccb9744 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -3,6 +3,8 @@
    You can adapt this file completely to your liking, but it should at least
    contain the root `toctree` directive.
 
+.. _linux_doc:
+
 The Linux Kernel documentation
 ==============================
 
diff --git a/Documentation/kernel-hacking/index.rst b/Documentation/kernel-hacking/index.rst
index fcb0eda3cca3..f53027652290 100644
--- a/Documentation/kernel-hacking/index.rst
+++ b/Documentation/kernel-hacking/index.rst
@@ -1,3 +1,5 @@
+.. _kernel_hacking:
+
 =====================
 Kernel Hacking Guides
 =====================
-- 
2.14.3
