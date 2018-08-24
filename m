Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B74E2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B74E2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeHXL3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:29:55 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:35152 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbeHXL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:29:55 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 24 Aug 2018 16:56:25 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 8019074FA7;
        Fri, 24 Aug 2018 16:56:25 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,281,1531753200"; 
   d="scan'208";a="288949469"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 24 Aug 2018 16:56:21 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Document r8a774a1 USB bindings
Date:   Fri, 24 Aug 2018 08:56:09 +0100
Message-Id: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

this series aims at documenting USB related dt-bindings for the
r8a774a1.

Applies on next-20180823.

Thanks,
Fab

Biju Das (1):
  dt-bindings: dmaengine: usb-dmac: Add binding for r8a774a1

Fabrizio Castro (5):
  dt-bindings: rcar-gen3-phy-usb2: Add r8a774a1 support
  dt-bindings: rcar-gen3-phy-usb3: Add r8a774a1 support
  dt-bindings: usb-xhci: Add r8a774a1 support
  dt-bindings: usb: renesas_usbhs: Add r8a774a1 support
  usb: gadget: udc: renesas_usb3: Add r8a774a1 support

 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt   |  1 +
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  9 ++++++---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 10 ++++++----
 Documentation/devicetree/bindings/usb/renesas_usb3.txt       |  5 +++--
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt      |  3 ++-
 Documentation/devicetree/bindings/usb/usb-xhci.txt           |  4 +++-
 6 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.7.4

