Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeERIDU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:03:20 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41479 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeERIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:03:16 -0400
X-Google-Smtp-Source: AB8JxZqSdXWJXWa8I1xWoqV/pEFD7hCPqRYFMU3Vf0ON6pOqaHQVdz77E2sH6IQeJVcBWBGTruFp0aUVXh6z4nEn1JM=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 10:03:15 +0200
X-Google-Sender-Auth: 6EFbFkx6fFNvn0aJRgCHKsOyBVc
Message-ID: <CAJZ5v0gzh68Y3TwONGkGrCNGt8WY+f1rtjeEw0hgFyRr1sFyDQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.17-rc6
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
 acpi-4.17-rc6

with top-most commit 7b34c0fb1b51a6377752fc971e57577eeb102d60

 ACPICA: Add deferred package support for the Load and loadTable operators

on top of commit 67b8d5c7081221efa252e111cd52532ec6d4266f

 Linux 4.17-rc5

to receive an ACPI fix for 4.17-rc6.

This fixes an ACPICA regression introduced in this cycle and related
to the handling of package objects loaded by the Load and loadTable
AML operators that are not initialized properly after recent changes
(Bob Moore).

Thanks!


---------------

Bob Moore (1):
      ACPICA: Add deferred package support for the Load and loadTable operators

---------------

 drivers/acpi/acpica/acnamesp.h |  4 +++
 drivers/acpi/acpica/exconfig.c | 14 ++++++++
 drivers/acpi/acpica/nsinit.c   | 76 +++++++++++++++++++++++++++++++-----------
 3 files changed, 74 insertions(+), 20 deletions(-)
