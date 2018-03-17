Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753317AbeCQX3W (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:29:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:34428 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbeCQX3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:29:19 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>
Cc: James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 0/8] Ingenic JZ47xx Timer/Counter Unit drivers
Date: Sun, 18 Mar 2018 00:28:53 +0100
Message-Id: <20180317232901.14129-1-paul@crapouillou.net>
In-Reply-To: <20180110224838.16711-2-paul@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the 4th version of my TCU patchset.

The major change is a greatly improved documentation, both in-code
and as separate text files, to describe how the hardware works and
how the devicetree bindings should be used.

There are also cosmetic changes in the irqchip driver, and the
clocksource driver will now use as timers all TCU channels not
requested by the TCU PWM driver.

Cheers,
-Paul
