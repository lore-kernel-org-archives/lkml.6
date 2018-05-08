Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbeEHWYh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:24:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43366 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756021AbeEHWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:24:35 -0400
From: Colin King <colin.king@canonical.com>
To: Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sctp: fix spelling mistake: "max_retans" -> "max_retrans"
Date: Tue,  8 May 2018 23:24:28 +0100
Message-Id: <20180508222428.24874-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in error string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/sctp/sm_make_chunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 4d7b3ccea078..4a4fd1971255 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1131,7 +1131,7 @@ struct sctp_chunk *sctp_make_violation_max_retrans(
 					const struct sctp_association *asoc,
 					const struct sctp_chunk *chunk)
 {
-	static const char error[] = "Association exceeded its max_retans count";
+	static const char error[] = "Association exceeded its max_retrans count";
 	size_t payload_len = sizeof(error) + sizeof(struct sctp_errhdr);
 	struct sctp_chunk *retval;
 
-- 
2.17.0
