Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85627C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C090206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 16:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C090206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeI3WzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:55:16 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:37123 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727504AbeI3WzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:55:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7A741180A8CA8;
        Sun, 30 Sep 2018 16:21:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glue83_481ec3db7d54f
X-Filterd-Recvd-Size: 1406
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 16:21:35 +0000 (UTC)
Message-ID: <ae2126ad8eab7d87b8a13cbe75d3ba27e2df22a7.camel@perches.com>
Subject: [PATCH] MAINTAINERS: MIPS/LOONGSON2 ARCHITECTURE - Use the normal
 wildcard style
From:   Joe Perches <joe@perches.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 30 Sep 2018 09:21:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither git nor get_maintainer understands the curly brace style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c62b724bb60..f6ab4f3bccfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9770,7 +9770,8 @@ MIPS/LOONGSON2 ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 L:	linux-mips@linux-mips.org
 S:	Maintained
-F:	arch/mips/loongson64/*{2e/2f}*
+F:	arch/mips/loongson64/fuloong-2e/
+F:	arch/mips/loongson64/lemote-2f/
 F:	arch/mips/include/asm/mach-loongson64/
 F:	drivers/*/*loongson2*
 F:	drivers/*/*/*loongson2*


