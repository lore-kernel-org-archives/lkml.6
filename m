Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164410AbeBOWJJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:09:09 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33000 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162892AbeBOWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:09:07 -0500
X-Google-Smtp-Source: AH8x227lWz4d5I/y3FDAF6BkX9Nur7q+BVV6AofMjG9uc+IP0NLYy0QzVKA0RDZRqabjjnaOB9Pk4Q==
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v4.16-rc2
Date: Thu, 15 Feb 2018 14:09:04 -0800
Message-Id: <1518732544-17094-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v4.16-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.16-rc2

Thanks,
Guenter
------

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.16-rc2

for you to fetch changes up to aef17ca1271948ee57cc39b2493d31110cc42625:

  hwmon: (k10temp) Only apply temperature offset if result is positive (2018-02-12 14:23:29 -0800)

----------------------------------------------------------------
Fix bad temperature display on Ryzen/Threadripper

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (k10temp) Only apply temperature offset if result is positive

 drivers/hwmon/k10temp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
