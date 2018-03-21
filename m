Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeCUNre (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 09:47:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38066 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeCUNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 09:47:30 -0400
X-Google-Smtp-Source: AG47ELtlwPpSksVgkHqUXZdExi+wrqV4EkIDpP4uiCOB1MT97M2HdD7cOmv1+fhS6v6VAWIR5n0JsQ==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
Subject: [PATCH 0/2] RAVE SP EEPROM driver
Date: Wed, 21 Mar 2018 06:47:08 -0700
Message-Id: <20180321134710.29757-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas:

This series is a first iteration of the patchset adding NVMEM support
for EEPROMs connected to RAVE SP MFD device (support for which landed
in 4.15).

NOTE: This patchset depends on the following patches:

"nvmem: Document struct nvmem_config"
"nvmem: core: Allow specifying device name verbatim"
"nvmem: Introduce devm_nvmem_(un)register()"

which are still trickling down from 'char-misc' to Linus' tree.

Feedback is wellcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (2):
  dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
  nvmem: Add RAVE SP EEPROM driver

 .../bindings/nvmem/zii,rave-sp-eeprom.txt          |  23 ++
 drivers/nvmem/Kconfig                              |   6 +
 drivers/nvmem/Makefile                             |   3 +
 drivers/nvmem/rave-sp-eeprom.c                     | 356 +++++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 drivers/nvmem/rave-sp-eeprom.c

-- 
2.14.3
