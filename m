Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06927C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988E720840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988E720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbeHAUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:20:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46136 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404193AbeHATDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E16031045;
        Wed,  1 Aug 2018 17:00:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 144/336] watchdog: renesas-wdt: Add support for the R8A77965 WDT
Date:   Wed,  1 Aug 2018 18:47:59 +0200
Message-Id: <20180801165034.653469480@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit b1eb8fedc01499132ced4b2a44b3ab3855c4e681 ]

Document support for the Watchdog Timer (WDT) Controller in the Renesas
R-Car M3-N (R8A77965) SoC. No driver update is needed.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[wsa: rebased to v4.17-rc3]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -7,6 +7,7 @@ Required properties:
 	         - "renesas,r7s72100-wdt" (RZ/A1)
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
+		 - "renesas,r8a77965-wdt" (R-Car M3-N)
 	         - "renesas,r8a77970-wdt" (R-Car V3M)
 	         - "renesas,r8a77995-wdt" (R-Car D3)
 


