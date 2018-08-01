Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C43CC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC684208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC684208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbeHATig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:38:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406039AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7FA281164;
        Wed,  1 Aug 2018 17:06:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yixun Lan <yixun.lan@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 240/336] dt-bindings: net: meson-dwmac: new compatible name for AXG SoC
Date:   Wed,  1 Aug 2018 18:49:35 +0200
Message-Id: <20180801165038.241469273@linuxfoundation.org>
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

From: Yixun Lan <yixun.lan@amlogic.com>

[ Upstream commit 7e5d05e18ba1ed491c6f836edee7f0b90f3167bc ]

We need to introduce a new compatible name for the Meson-AXG SoC
in order to support the RMII 100M ethernet PHY, since the PRG_ETH0
register of the dwmac glue layer is changed from previous old SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/net/meson-dwmac.txt |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/devicetree/bindings/net/meson-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/meson-dwmac.txt
@@ -11,6 +11,7 @@ Required properties on all platforms:
 			- "amlogic,meson8b-dwmac"
 			- "amlogic,meson8m2-dwmac"
 			- "amlogic,meson-gxbb-dwmac"
+			- "amlogic,meson-axg-dwmac"
 		Additionally "snps,dwmac" and any applicable more
 		detailed version number described in net/stmmac.txt
 		should be used.


