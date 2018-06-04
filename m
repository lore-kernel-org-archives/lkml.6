Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeFDLbE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:31:04 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41529 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFDLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:31:02 -0400
X-Google-Smtp-Source: ADUXVKLq5ddt4Recc/1ZyTqCT6FZX4umN+RxSyq5j4mblF5PFzGF1Vp9dEutavBglrUFGbWiLLMGKdlfWP8ad6ssgbc=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Jun 2018 13:31:01 +0200
X-Google-Sender-Auth: 6rgVAjxVbhT8_ICyoPYtRhrOLng
Message-ID: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
Subject: [GIT PULL] Device properties framework update for v4.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 dp-4.18-rc1

with top-most commit 63dcc7090137a893322432e156d66be3ce104615

 device property: Get rid of union aliasing

on top of commit 67b8d5c7081221efa252e111cd52532ec6d4266f

 Linux 4.17-rc5

to receive a device properties framework update for 4.18-rc1.

This modifies the device properties framework to remove union
aliasing from it (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      device property: Get rid of union aliasing

---------------

 drivers/base/property.c                 | 104 ++++++++++++++++++++++++++------
 drivers/firmware/efi/apple-properties.c |   8 ++-
 include/linux/property.h                |  52 ++++++++--------
 3 files changed, 117 insertions(+), 47 deletions(-)
