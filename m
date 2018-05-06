Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeEFLYe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 07:24:34 -0400
Received: from sauhun.de ([88.99.104.3]:37676 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751776AbeEFLYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 07:24:31 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] objtool: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:53 +0200
Message-Id: <20180506112404.24872-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/objtool/Documentation/stack-validation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index 3995735a878fe7..b8a32534b9d5de 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -136,7 +136,7 @@ To achieve the validation, objtool enforces the following rules:
 
 3. Each callable function which calls another function must have the
    correct frame pointer logic, if required by CONFIG_FRAME_POINTER or
-   the architecture's back chain rules.  This can by done in asm code
+   the architecture's back chain rules.  This can be done in asm code
    with the FRAME_BEGIN/FRAME_END macros.
 
    This rule ensures that frame pointer based stack traces will work as
-- 
2.11.0
