Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755221AbeDPMG0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:06:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38655 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753848AbeDPMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:06:24 -0400
X-Google-Smtp-Source: AIpwx48dat1+xC/wkBqa+sYElqoHh0fnG11QE/U0236wIp60xQmJPaj5PnsLnxFG1dGG0M5erlR4WA==
Date: Mon, 16 Apr 2018 13:06:19 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, cphealy@gmail.com,
        andrew.smirnov@gmail.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and HWMON due for the v4.18
 merge window
Message-ID: <20180416120619.4mj7byn2rtztcbvd@dell>
References: <1522160389-18822-1-git-send-email-andrey.gusakov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522160389-18822-1-git-send-email-andrey.gusakov@cogentembedded.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.  Things are pretty hectic at the moment.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-hwmon-v4.18

for you to fetch changes up to ed645cccc0ebc0329916b6df039dd792d9105c9d:

  hwmon: MC13783: Add uid and die temperature sensor inputs (2018-04-16 13:01:36 +0100)

----------------------------------------------------------------
Immutable branch between MFD and HWMON due for the v4.18 merge window

----------------------------------------------------------------
Andrey Gusakov (1):
      hwmon: MC13783: Add uid and die temperature sensor inputs

 drivers/hwmon/mc13783-adc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/mc13xxx-core.c  | 15 +++++++++++-
 include/linux/mfd/mc13xxx.h |  2 ++
 3 files changed, 76 insertions(+), 1 deletion(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
