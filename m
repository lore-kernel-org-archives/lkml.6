Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeBTBnn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 20:43:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44082 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932294AbeBTBnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 20:43:41 -0500
X-Google-Smtp-Source: AH8x227RMdhGbPhXuV5u4MPECp7X8qUgGWzNtg6LCKjbZDqkt+FDvuy/MEWhSNk7K/7IZOqLca4G9A==
From: Joel Stanley <joel@jms.id.au>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 0/3] reset: simple: enable for ASPEED SoCs
Date: Tue, 20 Feb 2018 12:13:27 +1030
Message-Id: <20180220014330.23425-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Fix typos in bindings document, add Rob's ack

This series that enables the simple reset driver for the ASPEED SoCs.

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
