Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBTJIj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:08:39 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44001 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeBTJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:08:36 -0500
X-Google-Smtp-Source: AH8x227zGncdxJdsdLm7e9PNW6PM4IoHF/xtibCEGstptm0lFDJqwPslJDhskVschYjnIMGOGnnTPg==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jassisinghbrar@gmail.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/2] add support for Socionext SynQuacer I2C controller
Date: Tue, 20 Feb 2018 09:08:25 +0000
Message-Id: <20180220090827.913-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.

Ard Biesheuvel (2):
  dt-bindings: i2c: add binding for Socionext SynQuacer I2C
  i2c: add support for Socionext SynQuacer I2C controller

 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
 drivers/i2c/busses/Kconfig                              |  11 +
 drivers/i2c/busses/Makefile                             |   1 +
 drivers/i2c/busses/i2c-synquacer.c                      | 817 ++++++++++++++++++++
 4 files changed, 858 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 create mode 100644 drivers/i2c/busses/i2c-synquacer.c

-- 
2.11.0
