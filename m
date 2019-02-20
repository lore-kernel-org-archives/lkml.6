Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ACB21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfBTFYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:24:42 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:53058 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfBTFYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:24:41 -0500
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gwKN1-0005VJ-KB from Jiada_Wang@mentor.com ; Tue, 19 Feb 2019 21:24:35 -0800
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 19 Feb 2019 21:24:32 -0800
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <horms@verge.net.au>, <magnus.damm@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiada_wang@mentor.com>
Subject: [PATCH v1 0/2] rsnd: dts: change to use extended audio dmac register
Date:   Wed, 20 Feb 2019 14:24:33 +0900
Message-ID: <20190220052435.20508-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to user reference manual for R-CAR H3 and M3-W SoCs,
in order to access busif4 ~ busif7, extended audio dmac registers
(PDMASAREn, PDMADAREn, PDMACHCREn)
need to be used, rather than basic audio dmac registers
(PDMASARn, PDMADARn, PDMACHCRn)

This patch set updates H3 (= r8a7795) and M3-W (= r8a7796) 
to use extended audio dmac registers

Jiada Wang (2):
  arm64: dts: renesas: r8a7795: use extended audio dmac register
  arm64: dts: renesas: r8a7796: use extended audio dmac register

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.19.2

