Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeEOJCN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:02:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45751 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeEOJCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:02:11 -0400
From: Colin King <colin.king@canonical.com>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scripts/dtc: fix spelling mistake: "endpont" -> "endpoint"
Date: Tue, 15 May 2018 10:02:09 +0100
Message-Id: <20180515090209.9165-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in FAIL message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/dtc/checks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index a2cc1036c915..9d253819e12c 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1536,7 +1536,7 @@ static void check_graph_endpoint(struct check *c, struct dt_info *dti,
 		return;
 
 	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
-		FAIL(c, dti, node, "graph endpont node name should be 'endpoint'");
+		FAIL(c, dti, node, "graph endpoint node name should be 'endpoint'");
 
 	check_graph_reg(c, dti, node);
 
-- 
2.17.0
