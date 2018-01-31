Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeAaO03 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 09:26:29 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36840 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbeAaO01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 09:26:27 -0500
X-Google-Smtp-Source: AH8x226hM0nXyjr3GHhUU2r3sFwOM0kKSTKiGUCI7YqWzujAD32kND9lobhfx9VOC+B3dJ3dMCcpiw==
Reply-To: minyard@acm.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net"
        <openipmi-developer@lists.sourceforge.net>
From: Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] IPMI updates for 4.16
Message-ID: <55498064-43a1-5cda-6b67-dae6f8191a3b@acm.org>
Date: Wed, 31 Jan 2018 08:26:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a638349bf6c29433b938141f99225b160551ff48:

   Merge branch 'for-4.15-fixes' of 
git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu (2017-12-11 
17:13:03 -0800)

are available in the git repository at:

   https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.16-1

for you to fetch changes up to e45af3d372f1d4339663dcbef28665f5b15d448c:

   ipmi_ssif: Remove duplicate NULL check (2018-01-22 08:10:38 -0600)

----------------------------------------------------------------
Small fixes for various things, been sitting in next for a
while (some a long time).

----------------------------------------------------------------
Andy Shevchenko (1):
       ipmi_ssif: Remove duplicate NULL check

Corey Minyard (1):
       ipmi_si: Fix error handling of platform device

Jeremy Kerr (1):
       ipmi/ipmi_powernv: remove outdated todo in powernv IPMI driver

John Garry (1):
       ipmi: use dynamic memory for DMI driver override

Masamitsu Yamazaki (1):
       ipmi: Clear smi_info->thread to prevent use-after-free during 
module unload

Wei Yongjun (3):
       ipmi_si_platform: Fix typo in parameter description
       ipmi watchdog: fix typo in parameter description
       ipmi/powernv: Fix error return code in ipmi_powernv_probe()

Xiongfeng Wang (1):
       ipmi: use correct string length

  drivers/char/ipmi/ipmi_dmi.c         |  5 ++++-
  drivers/char/ipmi/ipmi_msghandler.c  |  2 +-
  drivers/char/ipmi/ipmi_powernv.c     |  6 +++---
  drivers/char/ipmi/ipmi_si_intf.c     | 13 +++++++++----
  drivers/char/ipmi/ipmi_si_platform.c |  2 +-
  drivers/char/ipmi/ipmi_ssif.c        |  3 +--
  drivers/char/ipmi/ipmi_watchdog.c    |  4 ++--
  7 files changed, 21 insertions(+), 14 deletions(-)
