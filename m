Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeEUSsn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:48:43 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40289 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeEUSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:46:31 -0400
X-Google-Smtp-Source: AB8JxZomlsylThFPefbSqQEoRfEBi2hpRyKJ5XL6e+fyyAuiiqG1nVoqEuM9TV3JlSwlWSJ4l5EGOg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>,
        Richard Cochran <richardcochran@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        linux-omap@vger.kernel.org (open list:TI ETHERNET SWITCH DRIVER (CPSW)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/5] TI Ethernet driver warnings fixes
Date: Mon, 21 May 2018 11:45:50 -0700
Message-Id: <20180521184555.21555-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series attempts to fix properly the warnings observed with turning
on COMPILE_TEST and TI Ethernet drivers on 64-bit hosts.

Since I don't have any of this hardware, please review carefully for possible
breakage!

Thank you!

Florian Fainelli (5):
  ti: ethernet: cpdma: Use correct format for genpool_*
  net: ethernet: ti: cpts: Fix timestamp print
  net: ethernet: ti: cpsw: Fix cpsw_add_ch_strings() printk format
  net: ethernet: davinci_emac: Fix printing of base address
  ti: ethernet: davinci: Fix cast to int warnings

 drivers/net/ethernet/ti/cpsw.c          |  4 ++--
 drivers/net/ethernet/ti/cpts.c          |  3 ++-
 drivers/net/ethernet/ti/davinci_cpdma.c | 10 +++++-----
 drivers/net/ethernet/ti/davinci_emac.c  |  4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.14.1
