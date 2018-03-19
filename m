Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeCSKu2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:50:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56740 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755420AbeCSKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:50:27 -0400
From: Colin King <colin.king@canonical.com>
To: "David S . Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] test_rhashtable: fix spelling mistake: "existant" -> "existent"
Date: Mon, 19 Mar 2018 10:50:21 +0000
Message-Id: <20180319105021.327-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in warning message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/test_rhashtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index f4000c137dbe..32d964cbac8c 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -396,7 +396,7 @@ static int __init test_rhltable(unsigned int entries)
 			if (WARN(err, "cannot remove element at slot %d", i))
 				continue;
 		} else {
-			if (WARN(err != -ENOENT, "removed non-existant element %d, error %d not %d",
+			if (WARN(err != -ENOENT, "removed non-existent element %d, error %d not %d",
 			     i, err, -ENOENT))
 				continue;
 		}
@@ -441,7 +441,7 @@ static int __init test_rhltable(unsigned int entries)
 			if (WARN(err, "cannot remove element at slot %d", i))
 				continue;
 		} else {
-			if (WARN(err != -ENOENT, "removed non-existant element, error %d not %d",
+			if (WARN(err != -ENOENT, "removed non-existent element, error %d not %d",
 				 err, -ENOENT))
 			continue;
 		}
-- 
2.15.1
