Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AC8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105E120873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfARDF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:05:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfARDFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:05:25 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 06F043EE8B63D2C38C6C;
        Fri, 18 Jan 2019 11:05:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 11:05:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <isdn@linux-pingi.de>,
        <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] isdn: remove unneeded semicolon
Date:   Fri, 18 Jan 2019 11:05:11 +0800
Message-ID: <20190118030511.16000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded semicolon

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/isdn/hisax/netjet.c      | 6 +++---
 drivers/isdn/hisax/q931.c        | 2 +-
 drivers/isdn/hisax/st5481.h      | 2 +-
 drivers/isdn/isdnloop/isdnloop.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/isdn/hisax/netjet.c b/drivers/isdn/hisax/netjet.c
index e932a15..d7b011c8 100644
--- a/drivers/isdn/hisax/netjet.c
+++ b/drivers/isdn/hisax/netjet.c
@@ -332,7 +332,7 @@ static int make_raw_data_56k(struct BCState *bcs) {
 			bitcnt = 0;
 		}
 		val >>= 1;
-	};
+	}
 	fcs = PPP_INITFCS;
 	for (i = 0; i < bcs->tx_skb->len; i++) {
 		val = bcs->tx_skb->data[i];
@@ -415,7 +415,7 @@ static void read_raw(struct BCState *bcs, u_int *buf, int cnt) {
 	else { // it's 56K
 		mask = 0x7f;
 		bits = 7;
-	};
+	}
 	for (i = 0; i < cnt; i++) {
 		val = bcs->channel ? ((*p >> 8) & 0xff) : (*p & 0xff);
 		p++;
@@ -623,7 +623,7 @@ void netjet_fill_dma(struct BCState *bcs)
 	else { // it's 56k
 		if (make_raw_data_56k(bcs))
 			return;
-	};
+	}
 	if (bcs->cs->debug & L1_DEB_HSCX)
 		debugl1(bcs->cs, "tiger fill_dma2: c%d %4lx", bcs->channel,
 			bcs->Flag);
diff --git a/drivers/isdn/hisax/q931.c b/drivers/isdn/hisax/q931.c
index 298c8db..6b8c3fb 100644
--- a/drivers/isdn/hisax/q931.c
+++ b/drivers/isdn/hisax/q931.c
@@ -598,7 +598,7 @@ prcalling(char *dest, u_char *p)
 		dp += prbits(dp, *++p, 8, 8);
 		*dp++ = '\n';
 		l--;
-	};
+	}
 	p++;
 
 	dp += sprintf(dp, "    number digits ");
diff --git a/drivers/isdn/hisax/st5481.h b/drivers/isdn/hisax/st5481.h
index 8cd2d82..b421b86 100644
--- a/drivers/isdn/hisax/st5481.h
+++ b/drivers/isdn/hisax/st5481.h
@@ -512,7 +512,7 @@ static inline const char *ST5481_CMD_string(int evt)
 	case ST5481_CMD_AR10: return "AR10";
 	case ST5481_CMD_ARL: return "ARL";
 	case ST5481_CMD_PDN: return "PDN";
-	};
+	}
 
 	sprintf(s, "0x%x", evt);
 	return s;
diff --git a/drivers/isdn/isdnloop/isdnloop.c b/drivers/isdn/isdnloop/isdnloop.c
index a4597e9..f4253d4 100644
--- a/drivers/isdn/isdnloop/isdnloop.c
+++ b/drivers/isdn/isdnloop/isdnloop.c
@@ -72,7 +72,7 @@ isdnloop_bchan_send(isdnloop_card *card, int ch)
 				printk(KERN_WARNING "isdnloop: no rcard, skb dropped\n");
 				dev_kfree_skb(skb);
 
-			};
+			}
 			cmd.command = ISDN_STAT_BSENT;
 			cmd.parm.length = len;
 			card->interface.statcallb(&cmd);
-- 
2.7.0


