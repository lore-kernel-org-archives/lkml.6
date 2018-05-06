Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeEFLYi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 07:24:38 -0400
Received: from sauhun.de ([88.99.104.3]:37670 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbeEFLY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 07:24:29 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] net: flow_dissector: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:52 +0200
Message-Id: <20180506112404.24872-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/net/flow_dissector.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 9a074776f70b66..d1fcf2442a423b 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -251,7 +251,7 @@ extern struct flow_dissector flow_keys_buf_dissector;
  * This structure is used to hold a digest of the full flow keys. This is a
  * larger "hash" of a flow to allow definitively matching specific flows where
  * the 32 bit skb->hash is not large enough. The size is limited to 16 bytes so
- * that it can by used in CB of skb (see sch_choke for an example).
+ * that it can be used in CB of skb (see sch_choke for an example).
  */
 #define FLOW_KEYS_DIGEST_LEN	16
 struct flow_keys_digest {
-- 
2.11.0
