Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AAF2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfBTUFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:05:44 -0500
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:55318
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbfBTUFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:05:44 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id wY6lg7sMBhEQ7wY6lg2SW5; Wed, 20 Feb 2019 13:04:43 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gwY6l-0005NF-3o; Wed, 20 Feb 2019 13:04:43 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     sashal@kernel.org, linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH v2] MAINTAINERS: Change mailing list for Hyper-V CORE AND DRIVERS
Date:   Wed, 20 Feb 2019 20:04:11 +0000
Message-Id: <20190220200411.20621-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: haiyangz@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNjeJZ1pJ6OpziPiRe2H1exLC6LEBPB7jlTuAkNLsAWsJ7dpVA+btRBfBaQX05IdEe6w1C4swboxUn3Yl7onKJn21JbmbjsKOlNMMWhPOENYZDC9nkv4
 sFLFVCECsusqjTooWSl8IJ7mfE80rVZfaBOKUzlSdZWM152TotN1LysWi/ZOoadeNxtQruLfgWTkj7fTWzJCiACDMQJZTuAuLikcVHCl98BM7ercPmObbVGf
 XTP1A4LYO1DGWOtysY3LbB9MM2TPWIJNMLgp583HotBAWC4y+uUgDzql91m1qnLQSgdsbPmlJ26iZxpbjyhFUyPwB8I4pnezOMMJSS/5OEUjMuyAr8QI1C2q
 snaMrvQKmEqTR3b8qUXhMT4xTZ7u7w/tIHStFXuP+dS6Z/80XaQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

The new mailing list is: linux-hyperv@vger.kernel.org

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86aa227b5782..403d6e4b8257 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7137,7 +7137,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Stephen Hemminger <sthemmin@microsoft.com>
 M:	Sasha Levin <sashal@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
-L:	devel@linuxdriverproject.org
+L:	linux-hyperv@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/device_drivers/microsoft/netvsc.txt
 F:	arch/x86/include/asm/mshyperv.h
-- 
2.19.1

