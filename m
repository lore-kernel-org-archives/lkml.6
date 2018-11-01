Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35069C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65E720820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65E720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeKBGcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:32:13 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:37270 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeKBGcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:32:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 3A7971801376D;
        Thu,  1 Nov 2018 22:27:30 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-kernel@vger.kernel.org
Cc:     linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Update maintainers file entry
Date:   Thu,  1 Nov 2018 22:27:01 +0100
Message-Id: <20181101212701.31828-1-richard@nod.at>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove stale fs/hppfs/ reference
- Point to our patchwork queue

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b91bbec94f98..3779bbab1715 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15672,13 +15672,13 @@ M:	Jeff Dike <jdike@addtoit.com>
 M:	Richard Weinberger <richard@nod.at>
 L:	linux-um@lists.infradead.org
 W:	http://user-mode-linux.sourceforge.net
+Q:	https://patchwork.ozlabs.org/project/linux-um/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git
 S:	Maintained
 F:	Documentation/virtual/uml/
 F:	arch/um/
 F:	arch/x86/um/
 F:	fs/hostfs/
-F:	fs/hppfs/
=20
 USERSPACE COPYIN/COPYOUT (UIOVEC)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
--=20
2.19.1

