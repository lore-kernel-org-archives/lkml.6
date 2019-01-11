Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676762133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfAKRac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:30:32 -0500
Received: from mailoutvs41.siol.net ([185.57.226.232]:39665 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729727AbfAKRac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:30:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 02E85522B1E;
        Fri, 11 Jan 2019 18:30:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id exOHRiIWlZXQ; Fri, 11 Jan 2019 18:30:28 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id AA540522B18;
        Fri, 11 Jan 2019 18:30:28 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 7B561522B1E;
        Fri, 11 Jan 2019 18:30:26 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] Add support for IR on Allwinner A64
Date:   Fri, 11 Jan 2019 18:30:12 +0100
Message-Id: <20190111173015.12119-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IR on A64 is nothing special and very similar to IR on A13 to the point
that same driver can be used.

Following patches just add necessary DT changes.

Best regards,
Jernej

Igors Makejevs (1):
  arm64: dts: allwinner: a64: Add IR node

Jernej Skrabec (2):
  media: dt: bindings: sunxi-ir: Add A64 compatible
  arm64: dts: allwinner: a64: Orange Pi Win: Enable IR

 .../devicetree/bindings/media/sunxi-ir.txt     |  5 ++++-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts  |  4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi  | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

--=20
2.20.1

