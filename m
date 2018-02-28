Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeB1Cpg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:45:36 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40190 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeB1Cpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:45:34 -0500
X-Google-Smtp-Source: AG47ELsM3gPrqe/iM26UgaGd/X0Gc19HB1/nkuxfW+XO2rvvfxzQoCm4bgDz4G/O6av3G4z90DoFc9c7xUzhHUDyWXo=
MIME-Version: 1.0
From: Rob Herring <robherring2@gmail.com>
Date: Tue, 27 Feb 2018 20:45:12 -0600
Message-ID: <CAL_JsqLUrhpY9wngZkU2pFxM+eqXebQjLw4QDe=kE8KsTaSmSw@mail.gmail.com>
Subject: [GIT PULL] DeviceTree fixes for 4.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a couple of DT binding updates.

Rob

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.16

for you to fetch changes up to d40ade43e3cd55c6d83859dffc0f9d428a954c63:

  dt-bindings: power: Fix "debounce-interval" property misspelling
(2018-02-18 21:05:43 -0600)

----------------------------------------------------------------
DeviceTree fixes for 4.16:

- Update i.MX thermal binding example to use current binding, not the
  deprecated one

- Move arm-charlcd to auxdisplay/

- Fix misspelling of "debounce-interval"

----------------------------------------------------------------
Andy Shevchenko (1):
      auxdisplay: Move arm-charlcd binding to correct folder

Dong Aisheng (1):
      dt-bindings: thermal: imx: update the binding to new method

Geert Uytterhoeven (1):
      dt-bindings: power: Fix "debounce-interval" property misspelling

 .../bindings/{misc => auxdisplay}/arm-charlcd.txt  |  0
 .../devicetree/bindings/power/wakeup-source.txt    |  2 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    | 25 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{misc =>
auxdisplay}/arm-charlcd.txt (100%)
