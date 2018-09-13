Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EA6C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0817820861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0817820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeIMK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:58:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeIMK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:58:54 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9WmQ-1fx18k0rPo-005Wyf; Thu, 13 Sep 2018 07:50:38 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/3] bcm2835-dt-next-2018-09-09
Date:   Thu, 13 Sep 2018 07:50:31 +0200
Message-Id: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:I9tiuHw5EVJcYS5DfgYjMSK3DGiU7DUG850JqEj5+ADTRgthDGP
 rmaFqAnT6ZflTj0phUCa0K5xGByfgH54dsDl37M+TRHCoA4IK7u1jeWWqhBwjkXgKjYsyur
 NZ9J43c4U8fXZZsmxfeSiBGwD+IY6YY5f9JpXiT2xIXD9PQyXL5Cy2LIg7Aa70RZjePYXzJ
 m2tLKZnm1e6HCWYhrMXEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dZxFZhXizX8=:ygDEFfLBOZR4UDh6bh7QUn
 MUL0INnzcgUsq1lw7HLQfciEtPp6DR+KqoXAB7Fks5NbH7wFwJUp2JFod2p9wEq/agcFfdMpO
 uaEyWrbZz+vNq1L046LJhYNeUF3f7B4hq2OwGbKd0OBVFitM5Kt0pPpu3lFfkx8lG5CEabjyk
 lgHv1xLRg0VcQJlDOWjCAxKrjMG4wxHcJ7ImV0H2U2zemjA3MTkICG1vDBxbwYZVtXrQItxnM
 QIAWJVMg8dxbMq8EU6QCbxygwwkgVTTQstfRVm0gQFlUQlKKcbMMHRdlmdWI+KJU74PfrYRJL
 SuRbhRKiXgZH/0p4BevTm+59GryL7W1h8XtYe4/JOICh6LQTfVM+zPH57TOLY4q5Hnbxbft2S
 KRRTVco7mbtf2OJW3xQHkUQnY3mzSUn1UGmFPnVGaF8rCMh0STcY2MS0y9oictrSymR49zcvs
 q57CT54qoCB7Z0+3U94yIB8Wvbaf2VdJv/jN2aiVhEnvajdwFpxWmG1QYwrAwazYj/yV6fi87
 d7gxEOD9fLnAVhIHBdm90jAeeu/Un0G9eotq5WqS05VPPHVZ3uojFgG1cSEztb+kVkvlEzEQS
 dgPRZNEvXhNBsNvGPp1woaztmMQ/6KMPjhVHo+9b9er7+2/TGsJMmnOyLk0tNj9Mwb4bIsGqJ
 YphVv48WI3GsvI4673kvNnbkC1JqAS+WEP+xqf7tUgmbjGPU73lEmftMTJOaYa+4k8h0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-09-09

for you to fetch changes up to 6ef5bd6cfd5da9fe67aea031fd0a66ff77d64ad6:

  ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs (2018-09-05 21:31:25 +0200)

----------------------------------------------------------------
This pull request brings in a board DT for the Raspberry Pi Compute
Module 3, its I/O board and enables the Ethernet LEDs for the RPi 3B+.

----------------------------------------------------------------
Stefan Wahren (3):
      dt-bindings: bcm: Add Raspberry Pi CM3 and CM3L
      ARM: dts: add Raspberry Pi Compute Module 3 and IO board
      ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs

 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  8 ++
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          | 87 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             | 52 +++++++++++++
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi         | 14 ++++
 5 files changed, 162 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
