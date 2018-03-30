Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeC3JoU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:44:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:52266 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeC3JoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:44:19 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/3] clk: uniphier: add support for PCIe, SATA and ethernet
Date: Fri, 30 Mar 2018 18:44:11 +0900
Message-Id: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock lines for PCI-express and SATA controllers implemented on
UniPhier SoCs, and additional clock lines for ethernet controller on Pro4.

Kunihiko Hayashi (3):
  clk: uniphier: add PCIe clock control support
  clk: uniphier: add SATA clock control support
  clk: uniphier: add additional ethernet clock lines for Pro4

 drivers/clk/uniphier/clk-uniphier-sys.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.7.4
