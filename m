Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A894AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677D22401D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677D22401D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933724AbeFVKKs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:10:48 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:48274 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933095AbeFVKIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:08:17 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id 1m8E1y00F3XaVaC06m8EZ0; Fri, 22 Jun 2018 12:08:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzG-0001m9-6n; Fri, 22 Jun 2018 12:08:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fWIzG-0007aT-52; Fri, 22 Jun 2018 12:08:14 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] MAINTAINERS: Add file patterns for dsa device tree bindings
Date:   Fri, 22 Jun 2018 12:08:13 +0200
Message-Id: <20180622100813.29122-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v3:
  - Update for next-20180622,

v2.1:
  - Moved pattern to "NETWORKING [DSA]",

v2:
  - Rebased on top of commit 0d3cd4b6b49865e8 ("net: dsa: mv88e6xxx:
    move driver in its own folder").

Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/net/dsa/":

-"David S. Miller" <davem@davemloft.net> (odd fixer:NETWORKING DRIVERS,commit_signer:6/8=75%)
-Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:3/8=38%,authored:1/8=12%)
+Andrew Lunn <andrew@lunn.ch> (maintainer:NETWORKING [DSA])
+Vivien Didelot <vivien.didelot@savoirfairelinux.com> (maintainer:NETWORKING [DSA])
+Florian Fainelli <f.fainelli@gmail.com> (maintainer:NETWORKING [DSA])
+"David S. Miller" <davem@davemloft.net> (odd fixer:NETWORKING DRIVERS)
+Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
-Andrew Lunn <andrew@lunn.ch> (commit_signer:3/8=38%)
-Florian Fainelli <f.fainelli@gmail.com> (commit_signer:3/8=38%)
-Brandon Streiff <brandon.streiff@ni.com> (commit_signer:1/8=12%)
-Egil Hjelmeland <privat@egil-hjelmeland.no> (authored:1/8=12%)
-Fabio Estevam <fabio.estevam@nxp.com> (authored:1/8=12%)
-"Damien Thébault" <damien.thebault@vitec.com> (authored:1/8=12%)
-"Michal Vokáč" <vokac.m@gmail.com> (authored:1/8=12%)
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5db502df5afdd8b..07a4927b1e7aada4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9884,6 +9884,7 @@ M:	Andrew Lunn <andrew@lunn.ch>
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
 M:	Florian Fainelli <f.fainelli@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/
 F:	net/dsa/
 F:	include/net/dsa.h
 F:	include/linux/dsa/
-- 
2.17.1

