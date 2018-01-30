Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeA3TGv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:06:51 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46649 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752511AbeA3TGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:06:49 -0500
X-Google-Smtp-Source: AH8x224pM/B3QO3S2c87R6sm6MPR7cjB+xZQJnrKNHOlDn3XYa/5sbqFwY3j3HJvROLUQCNkHDCGqA==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: yamada.masahiro@socionext.com, mcgrof@kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] net/sched: kconfig: Remove empty help texts
Date: Tue, 30 Jan 2018 20:05:23 +0100
Message-Id: <20180130190555.6577-2-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130190555.6577-1-ulfalizer@gmail.com>
References: <20180130190555.6577-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a warning ("kconfig: Warn if help text is
blank"): https://lkml.org/lkml/2018/1/30/516

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 net/sched/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index c03d86a7775e..f24a6ae6819a 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -857,17 +857,14 @@ config NET_ACT_TUNNEL_KEY
 config NET_IFE_SKBMARK
         tristate "Support to encoding decoding skb mark on IFE action"
         depends on NET_ACT_IFE
-        ---help---
 
 config NET_IFE_SKBPRIO
         tristate "Support to encoding decoding skb prio on IFE action"
         depends on NET_ACT_IFE
-        ---help---
 
 config NET_IFE_SKBTCINDEX
         tristate "Support to encoding decoding skb tcindex on IFE action"
         depends on NET_ACT_IFE
-        ---help---
 
 config NET_CLS_IND
 	bool "Incoming device classification"
-- 
2.14.1
