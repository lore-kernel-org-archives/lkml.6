Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeDTQSl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:18:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40632 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeDTQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:18:39 -0400
X-Google-Smtp-Source: AIpwx49315EKz+Hn8GkuSjZnQMh1/GFArEd3hqqtvhn2266TwNur2m2EEpfa/+M8l0hPLHRjDRWBjg==
Date: Fri, 20 Apr 2018 09:18:35 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.17-rc2
Message-ID: <20180420161834.GA22776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here are a couple of fixes on thermal subsystem.
Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal Management updates for v4.17-rc2 with top-most

e04907dbc25930b88ee2328fe692c776f63ddf2c:

  dt-bindings: thermal: Remove "cooling-{min|max}-level" properties (2018-04-18 07:04:28 -0700)

on top of commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

BR,

Eduardo Valentin

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      dt-bindings: thermal: remove no longer needed samsung thermal properties

Viresh Kumar (1):
      dt-bindings: thermal: Remove "cooling-{min|max}-level" properties

 .../devicetree/bindings/thermal/exynos-thermal.txt | 23 +++++-----------------
 .../devicetree/bindings/thermal/thermal.txt        | 16 +--------------
 2 files changed, 6 insertions(+), 33 deletions(-)
