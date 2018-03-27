Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeC0XUK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:20:10 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:42229 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeC0XUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:20:09 -0400
X-Google-Smtp-Source: AIpwx4/sl5eq7dJZ9o/9n3LwQVRBt75SGE4ylRsRqOaJVV0dd0/CseHVjnvypx10fpzAAYUBUgdYGQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Florian Westphal <fw@strlen.de>,
        linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 0/2] net: bgmac: Couple of small bgmac changes
Date: Tue, 27 Mar 2018 16:20:00 -0700
Message-Id: <20180327232002.29399-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series addresses two minor issues with the bgmac driver:

- provides the interface name through /proc/interrupts rather than "bgmac"
- makes sure the interrupts are masked during probe, in case the block was
  not properly reset

Florian Fainelli (2):
  net: bgmac: Use interface name to request interrupt
  net: bgmac: Mask interrupts during probe

 drivers/net/ethernet/broadcom/bgmac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.14.1
