Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B6C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CB520989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CB520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeIXDKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:10:41 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:39518
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727139AbeIXDKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:10:40 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 4BePgoiWbsezk4BePgk9gL; Sun, 23 Sep 2018 14:10:45 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1g4BeP-0007HB-Nl; Sun, 23 Sep 2018 14:10:45 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 2/4] Drivers: hv: kvp: Fix the indentation of some "break" statements
Date:   Sun, 23 Sep 2018 21:10:42 +0000
Message-Id: <20180923211044.27922-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180923211044.27922-1-kys@linuxonhyperv.com>
References: <20180923210938.27859-1-kys@linuxonhyperv.com>
 <20180923211044.27922-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfEG3va0Netkj7CQCsjP+ZhpqZRvXvPg171Iz4jF/O54XbKt4gF1ugKEu64uc1+6Rmghp3bvxIYCtEuAm6wtqJWEcSkrr52M8CYQayrSNEk4T8KNgutZQ
 6ALBPu++4bJgW40/SH/HWAtPIS8IR+DNNzQldTYUd5Vg/FyGsr/vikTKaCD87f1VUakeUKii0DY6y1FR5d3aReKa3Gfdr6Y3lXq2oCasUppO0vaRQhOvgSxb
 4Qb3F3pz3+NFkAF6UMw5pQhhepNtXboSydeOZ0vBRgpAOsO40938/7QhULA7tTTsQNgxuDNvpvlHHzbkE2Oo0zDlMQ41F+ncFKUGA/bv2WkwWKjvskWWoA9k
 yb7jEhcLzQjOupDcEs119J56YEW+tgkZYci6yulmeQvjF4cUuoN/RjhmJ/rKi64Ip8+AREZ68QZr6KqYmyMxhSvwSbW5SWUNDwyN+pKpcfl9mbTJb7ox8EpY
 WqFkoIGT/PXz6SXuhjkWZpwehflV7qXfgogTI8+8aSU6Uvc3TmEJcVCxB5XqgFCRb8pmC9qNGlMxAfcPFEUnIruDe3PIjllzZg+XB7AMkAQGFR+Wszbs9Qg/
 ECiwHzTz0oL0j9UGcPFKDQEa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

No functional change.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_kvp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 5eed1e7da15c..023bd185d21a 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -421,7 +421,7 @@ kvp_send_key(struct work_struct *dummy)
 				UTF16_LITTLE_ENDIAN,
 				message->body.kvp_set.data.value,
 				HV_KVP_EXCHANGE_MAX_VALUE_SIZE - 1) + 1;
-				break;
+			break;
 
 		case REG_U32:
 			/*
@@ -454,7 +454,7 @@ kvp_send_key(struct work_struct *dummy)
 			UTF16_LITTLE_ENDIAN,
 			message->body.kvp_set.data.key,
 			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
-			break;
+		break;
 
 	case KVP_OP_DELETE:
 		message->body.kvp_delete.key_size =
@@ -464,12 +464,12 @@ kvp_send_key(struct work_struct *dummy)
 			UTF16_LITTLE_ENDIAN,
 			message->body.kvp_delete.key,
 			HV_KVP_EXCHANGE_MAX_KEY_SIZE - 1) + 1;
-			break;
+		break;
 
 	case KVP_OP_ENUMERATE:
 		message->body.kvp_enum_data.index =
 			in_msg->body.kvp_enum_data.index;
-			break;
+		break;
 	}
 
 	kvp_transaction.state = HVUTIL_USERSPACE_REQ;
-- 
2.18.0

