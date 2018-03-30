Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC3Jow (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:44:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:52277 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeC3Jos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:44:48 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] reset: uniphier: add support for PCIe and SATA
Date: Fri, 30 Mar 2018 18:44:42 +0900
Message-Id: <1522403084-18780-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add reset lines for PCI-express and SATA controllers implemented on
UniPhier SoCs.

Kunihiko Hayashi (2):
  reset: uniphier: add PCIe reset control support
  reset: uniphier: add SATA reset control support and change SATA-PHY ID

 drivers/reset/reset-uniphier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.7.4
