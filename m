Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeE3Qv7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:51:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38336 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeE3Qv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:51:56 -0400
X-Google-Smtp-Source: ADUXVKIytis3RgRZ0v72ajxShVm7GdS3rEO/evjU1yW67At3f9Ztym9vgT6+MZc/rr9k3cmxT/JnHA==
From: Gwendal Grignou <gwendal@chromium.org>
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FIXUP checkpatch: improve patch recognition
Date: Wed, 30 May 2018 09:51:50 -0700
Message-Id: <20180530165150.50577-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <974a407e6fa18abd5a965da39cc68986a4c4f091.1526949367.git.joe@perches.com>
References: <974a407e6fa18abd5a965da39cc68986a4c4f091.1526949367.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix syntax error in patch.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f1fecd8aa4d7..03dd7b6b0eab 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2378,7 +2378,7 @@ sub process {
 # check if it's a mode change, rename or start of a patch
 		if (!$in_commit_log &&
 		    ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||
-		    ($line =~ /^rename (?:from|to) \S+\s*$/ ||
+		     $line =~ /^rename (?:from|to) \S+\s*$/ ||
 		     $line =~ /^diff --git a\/[\w\/\.\_\-]+ b\/\S+\s*$/)) {
 			$is_patch = 1;
 		}
-- 
2.17.0.921.gf22659ad46-goog
