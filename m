Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeERICO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:02:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:45446 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:02:12 -0400
X-Google-Smtp-Source: AB8JxZrqGBXMTspD6Qr1r4kpOgNmJx6JcFEOo/+PyfYatN5s9lfjYp4lP57txwxCKn7uGx9auD6WU8Po0v79zueLrRg=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 10:02:11 +0200
X-Google-Sender-Auth: FXOKpqZOuvygAaSGNhTCCJmDUEs
Message-ID: <CAJZ5v0iecQwakKwyRb_Db=ebTEdpzKiGhkynW1GRRvf_ycVGnw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v4.17-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.17-rc6

with top-most commit 0cf442c6bcf572e04f5690340d5b8e62afcee2ca

 cpufreq: armada-37xx: driver relies on cpufreq-dt

on top of commit 67b8d5c7081221efa252e111cd52532ec6d4266f

 Linux 4.17-rc5

to receive a power management fix for 4.17-rc6.

This fixes Kconfig dependencies of the armada-37xx cpufreq driver
(Miquel Raynal).

Thanks!


---------------

Miquel Raynal (1):
      cpufreq: armada-37xx: driver relies on cpufreq-dt

---------------

 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
