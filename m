Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD77C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5C2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfBTUBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:01:04 -0500
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:51046
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbfBTUBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:01:03 -0500
X-Greylist: delayed 675 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 15:01:03 EST
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id wXrLg7cpLhEQ7wXrLg2FqG; Wed, 20 Feb 2019 12:48:47 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1gwXrL-0005I3-25; Wed, 20 Feb 2019 12:48:47 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     sashal@kernel.org, linux-hyperv@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add mailing list for Hyper-V CORE AND DRIVERS
Date:   Wed, 20 Feb 2019 19:48:23 +0000
Message-Id: <20190220194823.20298-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Reply-To: haiyangz@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNB5h4Q/UIffWi0DwTk3taWF4rKs5cPq1WiPnhgaCHPGIcGXITsgOlKDvl+ZnyWi0GPhtCLLb0XmaBJSPGXVb11EpBEA903F3z7ugFc1+zdFQZfFgXGY
 8PIXUhlCW6P2pMbmfUaJTw91HmJAY88Yw4S6VPQU1H+izMlBZTFU+pQPPC+qlfGNu8pCikflwcsZeV+vKoPJhMkMAPZYSxsfX1ZNOw2OmIG4f+UzsnRybBRq
 5duZncKYoFR5aPRD0FaXXQ2z6Y4XmD/iTbzmy3TnVSs2eqllJzoMrX0nHX5n07YMG2pvVm6Du7MjYKIqzLl+PwIiloBR8JontTnc81e7Vm796Z+oiZPiPPy6
 jwSoSw5xi2Qwfd3nEiHchdtGG6v2e06VHqivutc8ikMlIpUqkL8j3D+7N9DCTFvyx8O2x7S7u+RpOMUIFDO1QFIBBv+JLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

The new mailing list is: linux-hyperv@vger.kernel.org

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 86aa227b5782..ef65de3cfe1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7137,6 +7137,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Stephen Hemminger <sthemmin@microsoft.com>
 M:	Sasha Levin <sashal@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
+L:	linux-hyperv@vger.kernel.org
 L:	devel@linuxdriverproject.org
 S:	Supported
 F:	Documentation/networking/device_drivers/microsoft/netvsc.txt
-- 
2.19.1

