Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbeEGJhs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:37:48 -0400
Received: from osg.samsung.com ([64.30.133.232]:65419 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752502AbeEGJgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:36:09 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Subject: [PATCH 11/18] docs: crypto_engine.rst: Fix two parse warnings
Date: Mon,  7 May 2018 06:35:47 -0300
Message-Id: <13511fdb708dc5319630b03c48e733eb4eb978d7.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./Documentation/crypto/crypto_engine.rst:13: WARNING: Unexpected indentation.
./Documentation/crypto/crypto_engine.rst:15: WARNING: Block quote ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/crypto/crypto_engine.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/crypto/crypto_engine.rst b/Documentation/crypto/crypto_engine.rst
index 8272ac92a14f..1d56221dfe35 100644
--- a/Documentation/crypto/crypto_engine.rst
+++ b/Documentation/crypto/crypto_engine.rst
@@ -8,11 +8,13 @@ The crypto engine API (CE), is a crypto queue manager.
 
 Requirement
 -----------
-You have to put at start of your tfm_ctx the struct crypto_engine_ctx
-struct your_tfm_ctx {
+You have to put at start of your tfm_ctx the struct crypto_engine_ctx::
+
+  struct your_tfm_ctx {
         struct crypto_engine_ctx enginectx;
         ...
-};
+  };
+
 Why: Since CE manage only crypto_async_request, it cannot know the underlying
 request_type and so have access only on the TFM.
 So using container_of for accessing __ctx is impossible.
-- 
2.17.0
