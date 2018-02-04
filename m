Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeBDPi0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:38:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39372 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBDPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:38:18 -0500
X-Google-Smtp-Source: AH8x224TJR0Z1arexy384+M5NNv1KzlxrvyYIIyTOtmsojDji6ABYQkP6wqJyUdJR+ZA7PB58QfA/PZlxJkgLfHcdeU=
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 4 Feb 2018 21:08:16 +0530
Message-ID: <CABb+yY02DWB4eb9efeb3MF+hVcV3P65PiALUMd9Rde-X8t5Vxg@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ef7f8cec80a0ba7bd00ece46844c8994117dc910:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
(2018-01-08 20:21:39 -0800)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v4.16

for you to fetch changes up to 0ae7d327a64b262443b7d3ebee5831e4dde47b89:

  dt-bindings: mailbox: qcom: Document the APCS clock binding
(2018-02-04 12:16:34 +0530)

----------------------------------------------------------------
Misc driver changes only :
- TI-MsgMgr: Fix print format for a printk
- TI-MSgMgr: SPDX license switch for the driver
- QCOM-IPC: Convert driver to use regmap
- QCOM-IPC: Spawn sibling clock device from mailbox driver

----------------------------------------------------------------
Georgi Djakov (3):
      mailbox: qcom: Convert APCS IPC driver to use regmap
      mailbox: qcom: Create APCS child device for clock controller
      dt-bindings: mailbox: qcom: Document the APCS clock binding

Nishanth Menon (2):
      mailbox: ti-msgmgr: Switch to SPDX Licensing
      mailbox: ti-msgmgr: Use %zu for size_t print format

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     | 18 +++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            | 35 ++++++++++++++++++----
 drivers/mailbox/ti-msgmgr.c                        | 14 ++-------
 3 files changed, 51 insertions(+), 16 deletions(-)
