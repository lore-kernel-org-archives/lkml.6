Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965895AbeE2SZr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:25:47 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:40163 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965658AbeE2SZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:25:46 -0400
X-Google-Smtp-Source: ADUXVKIqdRlgu2iizqW3aZF500OksbNqpk8kjHMMMkzEk1PWRpoLoosx/+v8+x5+QFQydWzFbA/e8w==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] clockevents / clocksource changes for 4.18
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Eugeniy.Paltsev@synopsys.com,
        Matt Redfearn <matt.redfearn@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <1274a543-02dd-bbf0-c690-b08c788d9e91@linaro.org>
Date: Tue, 29 May 2018 20:25:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

this pull request contains the following changes:

 - Fix Kconfig dependency on the spreadtrum timer (Chunyan Zhang)

 - Add comment describing in details the reason why the local interrupt
is disabled (Eugeniy Paltsev)

 - Fix outdated file path and add the SPDX tag for the imx timers family
(Fabio Estevam)

 - Add pr_fmt and reword pr_* messages (Matt Redfearn)

Thanks!

  -- Daniel

The following changes since commit db6f9e55c8d80a4a1a329b9b68a1d370bffb6aad:

  clocksource: Move inline keyword to the beginning of function
declarations (2018-05-16 22:21:32 +0200)

are available in the git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.18

for you to fetch changes up to e45e778f078efaac085e50366fe06d7b83c8b881:

  clocksource/drivers/mxs_timer: Switch to SPDX identifier (2018-05-23
07:39:09 +0200)

----------------------------------------------------------------
Chunyan Zhang (1):
      clocksource/drivers/sprd: Fix Kconfig dependency

Eugeniy Paltsev (1):
      clocksource/drivers/arc_timer: Add comments about locking while
read GFRC

Fabio Estevam (4):
      clocksource/drivers/timer-imx-gpt: Remove outdated file path
      clocksource/drivers/timer-imx-gpt: Switch to SPDX identifier
      clocksource/drivers/timer-imx-tpm: Switch to SPDX identifier
      clocksource/drivers/mxs_timer: Switch to SPDX identifier

Matt Redfearn (1):
      clocksource/drivers/mips-gic-timer: Add pr_fmt and reword pr_*
messages

 drivers/clocksource/Kconfig          |  4 +++-
 drivers/clocksource/arc_timer.c      | 14 ++++++++++++++
 drivers/clocksource/mips-gic-timer.c | 18 ++++++++++--------
 drivers/clocksource/mxs_timer.c      | 28 +++++++---------------------
 drivers/clocksource/timer-imx-gpt.c  | 28 ++++++----------------------
 drivers/clocksource/timer-imx-tpm.c  | 13 ++++---------
 6 files changed, 44 insertions(+), 61 deletions(-)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
