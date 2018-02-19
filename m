Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeBSGyv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:54:51 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46930 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeBSGyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:54:49 -0500
X-Google-Smtp-Source: AH8x227Y78JbpbUOFj/vJFYv+pKDr5uILr4INOn5WoZYWNQAZG8aUL9ffkx2wK6wSKGr767vz7oARg==
From: Joel Stanley <joel@jms.id.au>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH 0/3] reset: simple: enable for ASPEED SoCs
Date: Mon, 19 Feb 2018 17:24:35 +1030
Message-Id: <20180219065438.19933-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philip,

Here is a series that enables the simple reset driver for the ASPEED
SoCs. You may recall I posted a patch back in May 2017 with a
similar idea[1]. I was happy to see that you merged a driver that solves
the problem, and suits our purpose for the ASPEED. Thanks!

Cheers,

Joel

[1] https://lkml.org/lkml/2017/5/25/940


Joel Stanley (3):
  dt-bindings: aspeed-lpc: Add reset controller
  reset: simple: Enable for ASPEED systems
  reset: simple: Allow user selection of driver

 .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
 drivers/reset/Kconfig                               | 12 ++++++++----
 drivers/reset/reset-simple.c                        |  2 ++
 3 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.15.1
