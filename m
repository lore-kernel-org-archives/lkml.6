Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756798AbeDZStW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:49:22 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:35269 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbeDZStU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:49:20 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.17-rc3
Date: Thu, 26 Apr 2018 11:49:18 -0700
Message-Id: <1524768558-6166-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v4.17-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.17-rc3

Thanks,
Guenter
------

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.17-rc3

for you to fetch changes up to 877d8948d0aa402fbbede138fc73432bb335b65f:

  hwmon: (k10temp) Add support for AMD Ryzen w/ Vega graphics (2018-04-25 05:31:06 -0700)

----------------------------------------------------------------
hwmon fixes for v4.17-rc3

- Add support for new Ryzen chips to k10temp driver
  ... making Phoronix happy
- Fix inconsistent chip access in nct6683 driver
- Handle absence of few types of sensors in scmi driver

----------------------------------------------------------------
Guenter Roeck (3):
      hwmon: (nct6683) Enable EC access if disabled at boot
      hwmon: (k10temp) Add temperature offset for Ryzen 2700X
      hwmon: (k10temp) Add support for AMD Ryzen w/ Vega graphics

Sudeep Holla (1):
      hwmon: (scmi) handle absence of few types of sensors

 drivers/hwmon/k10temp.c    | 17 ++++++++++++++---
 drivers/hwmon/nct6683.c    |  4 ++--
 drivers/hwmon/scmi-hwmon.c |  5 ++++-
 3 files changed, 20 insertions(+), 6 deletions(-)
