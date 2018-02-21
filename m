Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937223AbeBUNuo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:50:44 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44204 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbeBUNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:50:36 -0500
X-Google-Smtp-Source: AH8x226sA8qgr4jXYc4s9w7El8BUwcYpT7lvwYkoLiF0rn6ZGF81v/01FmX5ByzMmSWYMzt3cDi0HQ==
From: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH 0/2] Optimizes, cleans up and enhances stm32-exti irq hierarchy
Date: Wed, 21 Feb 2018 14:50:25 +0100
Message-Id: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- optimizes and cleans up stm32-exti irq domain
- optimizes and enhances stm32gpio irq chip

Radoslaw Pietrzyk (2):
  ARM: irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
  ARM: pinctrl: stm32: Optimizes and enhances stm32gpio irqchip

 drivers/irqchip/irq-stm32-exti.c      | 10 +---------
 drivers/pinctrl/stm32/pinctrl-stm32.c |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

-- 
1.9.1
