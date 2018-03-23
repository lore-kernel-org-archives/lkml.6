Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeCWMbU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:31:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:10375 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751768AbeCWMbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:31:19 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] net: ethernet: ave: add UniPhier PXs3 support
Date: Fri, 23 Mar 2018 21:30:35 +0900
Message-Id: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ethernet controller support on UniPhier PXs3 SoC.

Kunihiko Hayashi (2):
  dt-bindings: net: ave: add PXs3 support
  net: ethernet: ave: add UniPhier PXs3 support

 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 1 +
 drivers/net/ethernet/socionext/sni_ave.c                          | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.7.4
