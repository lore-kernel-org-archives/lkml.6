Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9921FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745A020989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfA2SyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:54:20 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:58809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfA2SyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:54:20 -0500
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mqrjz-1hSGzn3awj-00muIn; Tue, 29 Jan 2019 19:54:14 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/3] bcm2835-drivers-next-2019-01-29
Date:   Tue, 29 Jan 2019 19:53:28 +0100
Message-Id: <1548788008-4733-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:tG5e4rB/ae/4LOicQ33k71HkMKgOGJQ8XE4ILJWiF9IZNMue2KO
 O95qpDJ8C1zmcXxBpZZmm4tkTDBPZlzZVSpfudiii8LYQB/IuV3k1hhT+fIUIJk+QyyPDjt
 jRqKNy9iuYrfR6AnjrbH6f/RvbsrwtL75LmIKsAwU7ahxQeVQawi5mLM18KcgudolbNcTnx
 dvfiCgYlVJoOoc04duR5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RMmEGb6Elvg=:NQWSb8U4uiXNV6PybeLQxN
 LvinXm2Si+FGNKMH4RCJ6jGe1hNS9+QKvGYNtlIhj0Q0t7SHjss91wyklUiVCvrlozZOSfCGd
 Z+9jinRGCDj/8nKfUmizNvTuyymK7NJd0LfgyZG2kUCJDgno6JEQl/H8WDISWffrz6SQk5/O+
 d2nC/OcL5MrOkDdwC2mmv4e626RmQyBB5Qk63W8QlkQkw0H9HusFSkpGeFWEfZx+IRhF84jcg
 yVHj9Ld4be6EyJfvzIE+z6ujbzP0Bu2HL0Qa0mjuaixz+5R3PYJOvqvbuF7K7KUYCe1msXQtF
 zqCcuiGfSVcV+x+gJALmlxB66SFpua+NyrT/m++c2+SLAD2CqAOd9A73OZ2QIFlo9/Uhg9SjT
 LCJEXGWLfeK3RAAHoNktIrkkvskxXM1LYVsicARSn3z2AHuSpNo4jTOR4f4JxqF/OEPk6lKvL
 8aLyU2lwoZr/OG18wyaJjKrp4bQE1H3zgU/r1Ij1WH/aNhbVSpM12mXxceFSOkGzKHU+nbE+c
 a8yW0ApVT9JRPFChQzniD7SXKIklphMJwuiw+LlfLEBWIshZE2z1w54p4ifvLwZ/Y4wEaZxMj
 NXQ2TfhJOwVPILRupRrHkZZ6LwUHI1pvdOVVuBtn9Y1B4pMp01yx6suV2CIEzzGxFkASTJlh/
 WH/lO3aYFCpAqi3Xma5zGRXiXQJ03RpfVJJrtAtXFFzUKhHcEwJu6H7GniWYDYdjTLTU5G3Ap
 nnDI9WfzohUQKQ9HD3vjX7S723RhhUeUvR8dhNqQP+hfrFoh+n+N//ZH4wU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-01-29

for you to fetch changes up to f494caa480f7089ff9bba16dd865e190cee7e545:

  soc: bcm: Make PM driver default for BCM2835 (2019-01-24 19:19:22 +0100)

----------------------------------------------------------------
This pull request brings the new BCM2835 PM driver and a workaround to
avoid network boot failures of the Raspberry Pi 3 B+ BOOTROM.

----------------------------------------------------------------
Eric Anholt (3):
      dt-bindings: soc: Add a new binding for the BCM2835 PM node. (v4)
      bcm2835-pm: Move bcm2835-watchdog's DT probe to an MFD.
      soc: bcm: bcm2835-pm: Add support for power domains under a new binding.

Stefan Wahren (3):
      soc: bcm2835: sync firmware properties with downstream
      firmware: raspberrypi: notify VC4 firmware of a reboot
      soc: bcm: Make PM driver default for BCM2835

 .../bindings/soc/bcm/brcm,bcm2835-pm.txt           |  46 ++
 arch/arm/mach-bcm/Kconfig                          |   1 +
 drivers/firmware/raspberrypi.c                     |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bcm2835-pm.c                           |  92 +++
 drivers/soc/bcm/Kconfig                            |  12 +
 drivers/soc/bcm/Makefile                           |   1 +
 drivers/soc/bcm/bcm2835-power.c                    | 661 +++++++++++++++++++++
 drivers/watchdog/bcm2835_wdt.c                     |  26 +-
 include/dt-bindings/soc/bcm2835-pm.h               |  28 +
 include/linux/mfd/bcm2835-pm.h                     |  14 +
 include/soc/bcm2835/raspberrypi-firmware.h         |   4 +
 12 files changed, 880 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
 create mode 100644 drivers/mfd/bcm2835-pm.c
 create mode 100644 drivers/soc/bcm/bcm2835-power.c
 create mode 100644 include/dt-bindings/soc/bcm2835-pm.h
 create mode 100644 include/linux/mfd/bcm2835-pm.h
