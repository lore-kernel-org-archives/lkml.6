Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7986A20844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfA2SzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:55:25 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2SzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:55:24 -0500
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXpQA-1geikM20dQ-00Y7XM; Tue, 29 Jan 2019 19:54:14 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/3] bcm2835-dt-64-next-2019-01-29
Date:   Tue, 29 Jan 2019 19:53:27 +0100
Message-Id: <1548788008-4733-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:weP9x1bjLc6j8jqZTUbWJ6RUDD2+RsCJhuFsntlS6yRWX7ixjlv
 TJTgYGLYeyr/K0TQ8KKhNDJtT6ezayWLnsRGPWDvt685WFtdJlcfFgrjf2EewOc3rskeByv
 xsfI9w9WprKn1jQlAnLAC1DY5i9shs3892kk5UXinTm8m4kHADpgwfczpbgz/oB2IXEYOlQ
 qHG1J81+lDFKBA/iEL0kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5C4DL9QtVag=:WM2dssDTYYKh0gBpleuTAk
 7VRqF99ZgBIIjhWjqHWYCgfKrp04+OscaMfnSrIgcGpCkZwR3bdWQBVAnVP0m82IJoIuNfiOO
 JJFSegiscXKi4WprFdLY67A5GTZPfHJW8cK+520pt1U3nNusae0aMaC+/NFOekf+32poGrgvs
 gg/mJPG5rlA6+oE6+hgoz8YxQcWQJK5KnlvX07huGyY9VPGewdi1VH55fNxM0wye/OKgQ7V0h
 jyGSWoF5KooK9cJHzs8Cbc6hTZODgOjyo3hEr1ntgFeFQuoRFtx10aZZa273iXk/sZnMayc2g
 zPDlMK3lMDG5OC42bNx/p4bl7dDgBAA7CW4mWN9rZCyBZ6hhKoTrpwV9Zpjx8KLxCjZgtEMRD
 WkJNmiXwCd9F/tGCyj57U7T+uk86V1NtlBXmVApU63WGWhR/E0wtZCC18bci3ufeU/uHOBUD7
 lDxhk32tczB26wVNnluog/7xRuX5c3n/Gu+rUvzi/craP8+OKBh1t65E20h/tV4sYgOnuQtQa
 UBtfMyyNHcotjf/r379nNgV3gp1EyF6IfS1chzainKw3N4kT5KEXPZjWdsbC8bN5TZHa7JsDZ
 LbiCXfVbTTHqd5csari8AFcF3yJ3FOdVDHAFG+nqNDv8wlSL4SRsBsKiYNmDhQLGjNnmDY4Jr
 m66DI6rukFI6DuZzwT2h7eo/PGg+fNkOfJHdS4PNmnTCJyJnQj2euCUtBGtDLjEluEmaGZxNU
 AywU1N0lqYm4QHB9cCxGUT/rCNXJg6ET6mvbAHjHlYnuJJGY5cwnHbdtaLc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-64-next-2019-01-29

for you to fetch changes up to 3688325a4acac981e95e25478d3703e3ab05d4c9:

  arm64: dts: broadcom: Add reference to RPi 3 A+ (2019-01-09 19:24:04 +0100)

----------------------------------------------------------------
This pull request brings in the arm64 reference for Raspberry Pi 3 A+.

----------------------------------------------------------------
Stefan Wahren (1):
      arm64: dts: broadcom: Add reference to RPi 3 A+

 arch/arm64/boot/dts/broadcom/Makefile                 | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
