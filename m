Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935358AbeEINWD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:22:03 -0400
Received: from osg.samsung.com ([64.30.133.232]:39532 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935132AbeEINTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:19:13 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 08/11] docs: refcount-vs-atomic.rst: prefix url with https
Date: Wed,  9 May 2018 10:18:51 -0300
Message-Id: <d5683242124d6070c9a2d665c59e274d94c8b3ba.1525870886.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525870886.git.mchehab+samsung@kernel.org>
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a github URL there, but it is not prefixed by https.
Add a prefix, to avoid false-positives with:
	./scripts/documentation-file-ref-check

As a side effect, Sphinx should also generate a cross-ref.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/core-api/refcount-vs-atomic.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
index 83351c258cdb..185d659e350a 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -17,7 +17,7 @@ in order to help maintainers validate their code against the change in
 these memory ordering guarantees.
 
 The terms used through this document try to follow the formal LKMM defined in
-github.com/aparri/memory-model/blob/master/Documentation/explanation.txt
+https://github.com/aparri/memory-model/blob/master/Documentation/explanation.txt
 
 memory-barriers.txt and atomic_t.txt provide more background to the
 memory ordering in general and for atomic operations specifically.
-- 
2.17.0
