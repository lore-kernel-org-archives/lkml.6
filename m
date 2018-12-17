Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A77C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC5A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbeLQPAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:00:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57890 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732831AbeLQPAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:00:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A287F20BE1; Mon, 17 Dec 2018 16:00:11 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 790432039F;
        Mon, 17 Dec 2018 16:00:01 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net v3 0/2] net: mvpp2: phylink validate fixes
Date:   Mon, 17 Dec 2018 15:56:04 +0100
Message-Id: <20181217145606.13847-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small series introduces 2 fixes for the phylink validate function
of the Marvell PPv2 Ethernet driver.

Since v2:
  - Added an additional patch (2/2) as suggested by Russell.
  - Rebased on top of net/master.

Since v1:
  - Rebased on top of net/master.

Antoine Tenart (2):
  net: mvpp2: 10G modes aren't supported on all ports
  net: mvpp2: fix the phylink mode validation

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.19.2

