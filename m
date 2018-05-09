Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934418AbeEIJsp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:48:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52472 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934366AbeEIJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:48:40 -0400
From: Colin King <colin.king@canonical.com>
To: Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        "David S . Miller" <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/9p: fix spelling mistake: "suspsend" -> "suspend"
Date: Wed,  9 May 2018 10:48:33 +0100
Message-Id: <20180509094833.15871-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/9p/trans_xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 086a4abdfa7c..0f19960390a6 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -485,7 +485,7 @@ static int xen_9pfs_front_probe(struct xenbus_device *dev,
 
 static int xen_9pfs_front_resume(struct xenbus_device *dev)
 {
-	dev_warn(&dev->dev, "suspsend/resume unsupported\n");
+	dev_warn(&dev->dev, "suspend/resume unsupported\n");
 	return 0;
 }
 
-- 
2.17.0
