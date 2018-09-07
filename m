Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD4BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6502075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fM83qTtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6502075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeIGFhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:37:54 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:57576 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbeIGFhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:37:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D0DE183640;
        Fri,  7 Sep 2018 12:59:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1536281978;
        bh=lceiij/5J7cPNqRjFqh6YL5RrThuUzbIXGGlplZvThY=;
        h=From:To:Cc:Subject:Date;
        b=fM83qTtr17ftP9hMhU00/lG3Vv+KNxgvn37e/qSAdIAZ/tUvNYJqdLwe1t12lPlfK
         jYMJmWKkq6czhBsu15pIjXbVdo3UoBhNSTX2O4wcP7AdnojtZEfPMhfRT8MlBptJFI
         WnXzqCAFqQVSQJUBpki+QwGysr8jEMh4agyyJwjg=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b91cd7a0000>; Fri, 07 Sep 2018 12:59:38 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 8AE0113EE9C;
        Fri,  7 Sep 2018 12:59:41 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 53C141E1DDB; Fri,  7 Sep 2018 12:59:38 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, gregory.clement@bootlin.com
Cc:     jason@lakedaemon.net, davem@davemloft.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] ARM: dts: mvebu: marvell,prestera
Date:   Fri,  7 Sep 2018 12:59:24 +1200
Message-Id: <20180907005926.27134-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a generic compatible string so that drivers don't need to deal with the
specific variants.

Chris Packham (2):
  dt-bindings: marvell,prestera: Add common compatible string
  ARM: dts: mvebu: add "marvell,prestera" to PP nodes

 Documentation/devicetree/bindings/net/marvell,prestera.txt | 4 ++--
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  | 2 +-
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi                  | 2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi                  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.18.0

