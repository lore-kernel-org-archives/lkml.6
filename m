Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeEGJkR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:40:17 -0400
Received: from osg.samsung.com ([64.30.133.232]:52363 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752443AbeEGJgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:36:05 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michael Jamet <michael.jamet@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 06/18] docs: core-api: add cgroup-v2 documentation
Date: Mon,  7 May 2018 06:35:42 -0300
Message-Id: <b45083a64578b661cabadcf99d509e7def7c21a5.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup-v2.txt is already in ReST format. So, move it to the
core-api guide, where it belongs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/00-INDEX                                     | 2 --
 Documentation/{cgroup-v2.txt => admin-guide/cgroup-v2.rst} | 0
 Documentation/admin-guide/index.rst                        | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/{cgroup-v2.txt => admin-guide/cgroup-v2.rst} (100%)

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 04074059bcdc..c6b81ef9827b 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -80,8 +80,6 @@ cdrom/
 	- directory with information on the CD-ROM drivers that Linux has.
 cgroup-v1/
 	- cgroups v1 features, including cpusets and memory controller.
-cgroup-v2.txt
-	- cgroups v2 features, including cpusets and memory controller.
 circular-buffers.txt
 	- how to make use of the existing circular buffer infrastructure
 clk.txt
diff --git a/Documentation/cgroup-v2.txt b/Documentation/admin-guide/cgroup-v2.rst
similarity index 100%
rename from Documentation/cgroup-v2.txt
rename to Documentation/admin-guide/cgroup-v2.rst
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 52eb3408f9a0..48d70af11652 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -48,6 +48,7 @@ configure specific aspects of kernel behavior to your liking.
    :maxdepth: 1
 
    initrd
+   cgroup-v2
    serial-console
    braille-console
    parport
-- 
2.17.0
