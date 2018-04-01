Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753839AbeDAR0l (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 13:26:41 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39576 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753743AbeDAR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 13:26:39 -0400
X-Google-Smtp-Source: AIpwx4+L8ANXUudfSGBSCXsnCN7Hqc5BgVqWOdJfiUvuQZOHKULA2xEZUq9xZBwVo7rJW6nf+8OqlQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        linux-kernel@vger.kernel.org (open list), jon.mason@broadcom.com,
        nbd@nbd.name
Subject: [PATCH net 0/2] net: bgmac: Couple of sparse warnings
Date: Sun,  1 Apr 2018 10:26:28 -0700
Message-Id: <20180401172630.12883-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series fixes a couple of warnings reported by sparse, should not
cause any functional problems since bgmac is typically used on LE platforms
anyway.

Florian Fainelli (2):
  net: bgmac: Correctly annotate register space
  net: bgmac: Fix endian access in bgmac_dma_tx_ring_free()

 drivers/net/ethernet/broadcom/bgmac.c | 3 ++-
 drivers/net/ethernet/broadcom/bgmac.h | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.14.1
