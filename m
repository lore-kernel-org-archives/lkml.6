Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935346AbeEINV3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:21:29 -0400
Received: from osg.samsung.com ([64.30.133.232]:43696 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935166AbeEINTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:19:15 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 07/11] docs: ranoops.rst: fix location of ramoops.txt
Date: Wed,  9 May 2018 10:18:50 -0300
Message-Id: <423e5919b9fa852bf2ac1abf8a24896f325afd6b.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The location of the dt bindings file is wrong: it was probably
badly renamed by some script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/ramoops.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index 4efd7ce77565..6dbcc5481000 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -61,7 +61,7 @@ Setting the ramoops parameters can be done in several different manners:
 	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
 
  B. Use Device Tree bindings, as described in
- ``Documentation/device-tree/bindings/reserved-memory/admin-guide/ramoops.rst``.
+ ``Documentation/devicetree/bindings/reserved-memory/ramoops.txt``.
  For example::
 
 	reserved-memory {
-- 
2.17.0
