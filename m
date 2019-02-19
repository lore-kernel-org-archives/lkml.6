Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA0B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfBSKne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:43:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfBSKne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 082F581F09;
        Tue, 19 Feb 2019 10:43:34 +0000 (UTC)
Received: from thuth.com (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51D2A60BE8;
        Tue, 19 Feb 2019 10:43:33 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     trivial@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Remove deceptive "See below" from the "Odd Fixes" description
Date:   Tue, 19 Feb 2019 11:43:29 +0100
Message-Id: <1550573009-1308-1-git-send-email-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 10:43:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the "See below" here, I'd expect to find some further
description of "Odd Fixes" a little bit later in the file. However,
as far as I can see, there is no further description available. Thus
let's simply remove these deceptive two words.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Please double-check ... maybe I'm just to blind to see the right
 paragraph where this text refers to...

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4..f627950 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -93,7 +93,7 @@ Descriptions of section entries:
 	   Supported:	Someone is actually paid to look after this.
 	   Maintained:	Someone actually looks after it.
 	   Odd Fixes:	It has a maintainer but they don't have time to do
-			much other than throw the odd patch in. See below..
+			much other than throw the odd patch in.
 	   Orphan:	No current maintainer [but maybe you could take the
 			role as you write your new code].
 	   Obsolete:	Old code. Something tagged obsolete generally means
-- 
1.8.3.1

