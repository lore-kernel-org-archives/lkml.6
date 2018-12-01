Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9FCC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358A320867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 08:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358A320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeLATwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:52:55 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:38112 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeLATwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 14:52:55 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 81D51CC35021395B7CB7;
        Sat,  1 Dec 2018 16:40:53 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB18emjl056803;
        Sat, 1 Dec 2018 16:40:48 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120116413472-14112191 ;
          Sat, 1 Dec 2018 16:41:34 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Davidlohr Bueso <dave@stgolabs.net>, paulmck@linux.ibm.com,
        Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] locktorture: style fix - spaces required around
Date:   Sat, 1 Dec 2018 16:40:39 +0800
Message-Id: <20181201084039.46125-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-01 16:41:35,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-01 16:40:28
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB18emjl056803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl errors:

ERROR: spaces required around that ':' (ctx:VxW)
+                torture=5Ftype, tag, cxt.debug=5Flock ? " [debug]": "",
                                                               ^

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: "Paul E. McKenney" <paulmck@linux.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/locking/locktorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index cd95c01491d8..d1d8356b770a 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -790,7 +790,7 @@ lock=5Ftorture=5Fprint=5Fmodule=5Fparms(struct lock=5Ft=
orture=5Fops *cur=5Fops,
 {
 	pr=5Falert("%s" TORTURE=5FFLAG
 		 "--- %s%s: nwriters=5Fstress=3D%d nreaders=5Fstress=3D%d stat=5Finterva=
l=3D%d verbose=3D%d shuffle=5Finterval=3D%d stutter=3D%d shutdown=5Fsecs=3D=
%d onoff=5Finterval=3D%d onoff=5Fholdoff=3D%d\n",
-		 torture=5Ftype, tag, cxt.debug=5Flock ? " [debug]": "",
+		 torture=5Ftype, tag, cxt.debug=5Flock ? " [debug]" : "",
 		 cxt.nrealwriters=5Fstress, cxt.nrealreaders=5Fstress, stat=5Finterval,
 		 verbose, shuffle=5Finterval, stutter, shutdown=5Fsecs,
 		 onoff=5Finterval, onoff=5Fholdoff);
--=20
2.19.1

