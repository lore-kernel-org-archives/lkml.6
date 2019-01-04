Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65FEC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBAD21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfADAzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:55:46 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:30512 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfADAzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:55:46 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id D55A6DB7B348FC543D89;
        Fri,  4 Jan 2019 08:55:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x040tZd5006249;
        Fri, 4 Jan 2019 08:55:35 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019010408560931-20345232 ;
          Fri, 4 Jan 2019 08:56:09 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  security/selinux/hooks: remove unneeded semicolon
Date:   Fri, 4 Jan 2019 17:19:07 +0800
Message-Id: <1546593547-24406-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-04 08:56:09,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-04 08:55:19,
        Serialize complete at 2019-01-04 08:55:19
X-MAIL: mse01.zte.com.cn x040tZd5006249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded semicolon.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a67459e..73c679e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1263,7 +1263,7 @@ static void selinux_write_opts(struct seq_file *m,
 		default:
 			BUG();
 			return;
-		};
+		}
 		/* we need a comma before each option */
 		seq_putc(m, ',');
 		seq_puts(m, prefix);
-- 
1.8.3.1

