Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeAaJlw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:41:52 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42777 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbeAaJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:35:19 -0500
X-Google-Smtp-Source: AH8x227gaPSvPNcM9LTIZlMw4PLlFJs/X4Py9hAL5q3bYp+Bnw6yxrCe8hM357URFbCp/xZa4wn+8w==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org, rdunlap@infradead.org, dan.carpenter@oracle.com,
        pebolle@tiscali.nl, Ulf Magnusson <ulfalizer@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 01/11] net/sched: kconfig: Remove blank help texts
Date: Wed, 31 Jan 2018 10:34:20 +0100
Message-Id: <20180131093434.20050-2-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180131093434.20050-1-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank help texts are probably either a typo, a Kconfig misunderstanding,
or some kind of half-committing to adding a help text (in which case a
TODO comment would be clearer, if the help text really can't be added
right away).

Best to remove them, IMO.

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
