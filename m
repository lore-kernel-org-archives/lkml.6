Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeBWIb6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:31:58 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51814 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeBWIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:31:54 -0500
X-Google-Smtp-Source: AG47ELvCBQVnbSrU5DSlG6PqOgBnTCmmm88+mYgHJC+ugOTuy13wr+8nOyZgqgmY1kTuUclIGKf8lA==
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
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Ludovic BARRE <ludovic.barre@st.com>
Subject: [PATCH v2 0/2] v2 patches for stm32-exti irq hierarchy
Date: Fri, 23 Feb 2018 09:31:43 +0100
Message-Id: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw Pietrzyk (2):
  irqchip: stm32: Optimizes and cleans up stm32-exti irq_domain
  pinctrl: stm32: Optimizes and enhances stm32gpio irqchip

 drivers/irqchip/irq-stm32-exti.c      | 13 -------------
 drivers/pinctrl/stm32/pinctrl-stm32.c |  3 ++-
 2 files changed, 2 insertions(+), 14 deletions(-)

-- 
1.9.1
