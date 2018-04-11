Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeDKCAO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 22:00:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47069 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeDKCAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 22:00:13 -0400
X-Google-Smtp-Source: AIpwx4+IMtUSGpK9pbGNimGnjPHoyRHAc/cXfSD3dd4IymgJJXErZU9eDjyQK8GLwIink/hbP3Gbng==
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] RAVE SP EEPROM driver
Date: Tue, 10 Apr 2018 18:59:46 -0700
Message-Id: <20180411015948.19562-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas:

This series is a second iteration of the patchset adding NVMEM support
for EEPROMs connected to RAVE SP MFD device (support for which landed
in 4.15).

Changes since [v1]:

	- Patchset rebased on latest master from Linus which contains
          all necessary dependencies

	- Added sizes.h to include in patch 1/2 to avoid build breaks
          reported by build-bot

	- Added missing #size-cells, #address-cells as well as example
	  cell to DT bindings documentation (pointed out by Rob)

Feedback is wellcome!

Thanks,
Andrey Smirnov

[v1] lkml.kernel.org/r/20180321134710.29757-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  dt-bindings: nvmem: Add binding for RAVE SP EEPROM driver
  nvmem: Add RAVE SP EEPROM driver

 .../bindings/nvmem/zii,rave-sp-eeprom.txt          |  29 ++
 drivers/nvmem/Kconfig                              |   6 +
 drivers/nvmem/Makefile                             |   3 +
 drivers/nvmem/rave-sp-eeprom.c                     | 357 +++++++++++++++++++++
 4 files changed, 395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/zii,rave-sp-eeprom.txt
 create mode 100644 drivers/nvmem/rave-sp-eeprom.c

-- 
2.14.3
