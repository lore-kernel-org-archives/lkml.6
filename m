Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeEFLYN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 07:24:13 -0400
Received: from sauhun.de ([88.99.104.3]:37554 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeEFLYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 07:24:10 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 0/9] tree-wide: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:44 +0200
Message-Id: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found this kind of typo when reading the documentation for device_remove().
So, I checked the tree for it.

CCing all the subsystems directly, and I'd think the leftover ones could be
picked up by the trivial tree. Or would it be more convenient if trivial would
pick up all? I don't mind.

Based on v4.17-rc3.

Wolfram Sang (9):
  dt-bindings: i2c: fix typo 'can by' to 'can be'
  powerpc/watchdog: fix typo 'can by' to 'can be'
  base: core: fix typo 'can by' to 'can be'
  hwmon: fschmd: fix typo 'can by' to 'can be'
  input: ati_remote2: fix typo 'can by' to 'can be'
  NTB: ntb_hw_idt: fix typo 'can by' to 'can be'
  reiserfs: journal: fix typo 'can by' to 'can be'
  net: flow_dissector: fix typo 'can by' to 'can be'
  objtool: fix typo 'can by' to 'can be'

 Documentation/devicetree/bindings/i2c/i2c-davinci.txt | 2 +-
 arch/powerpc/kernel/watchdog.c                        | 2 +-
 drivers/base/core.c                                   | 2 +-
 drivers/hwmon/fschmd.c                                | 2 +-
 drivers/input/misc/ati_remote2.c                      | 2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                       | 2 +-
 fs/reiserfs/journal.c                                 | 2 +-
 include/net/flow_dissector.h                          | 2 +-
 tools/objtool/Documentation/stack-validation.txt      | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.11.0
