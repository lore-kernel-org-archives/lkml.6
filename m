Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeD0XAa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 19:00:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36602 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932700AbeD0XA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 19:00:28 -0400
X-Google-Smtp-Source: AB8JxZoAxCQ3NjgNprU4feOQl786ka7VaYM+/NdEEGcH4tcTkU4xezT0X+ubwAtUwGb3ZQJiibjT3w==
From: "Wesley W. Terpstra" <wesley@sifive.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 0/3] SiFive SoC PWM driver
Date: Fri, 27 Apr 2018 15:59:55 -0700
Message-Id: <1524869998-2805-1-git-send-email-wesley@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SiFive SoCs can contain one or more PWM IP blocks.
This adds a driver for them. Tested on the HiFive Unleashed.

This patch series is broken into three parts:
  The driver itself, in drivers/pwm
  The device tree binding description, in Documentation/devicetree/bindings
  The SiFive vendor prefix, in Documentation/devicetree/bindings

Wesley W. Terpstra (3):
  dt-bindings: added new pwm-sifive driver documentation
  dt-bindings: Add "sifive" vendor prefix
  pwm-sifive: add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  28 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 259 +++++++++++++++++++++
 5 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
2.7.4
