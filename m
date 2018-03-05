Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932467AbeCEC3a (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:29:30 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.171]:28418 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932101AbeCEC31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:29:27 -0500
From: Matheus Castello <matheus@castello.eng.br>
To: stefan.wahren@i2se.com, linus.walleij@linaro.org
Cc: eric@anholt.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v2 0/3] pinctrl: bcm2835: Add brcm,level property
Date: Sun,  4 Mar 2018 22:29:17 -0400
Message-Id: <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <431699005.307231.1520086916739@email.1und1.de>
References: <431699005.307231.1520086916739@email.1und1.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1esfsT-002WAq-GA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:25193
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 16
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Stefan,

thanks for the tips.

This series adds support for generic binding for pinctrl bcm2835 driver,
and add the code for set output buffer of a pin using the output-low and
output-high generic properties.

Tested on Raspberry Pi Zero W, based on bcm2835 SoC.

Matheus Castello (3):
  pinctrl: bcm2835: switch to GENERIC_PINCONF
  pinctrl: bcm2835: Add support for generic pinctrl binding
  pinctrl: bcm2835: Add support for output-low output-high properties

 drivers/pinctrl/bcm/Kconfig           |  1 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 88 +++++++++++++++++++++++------------
 2 files changed, 60 insertions(+), 29 deletions(-)

--
2.7.4
