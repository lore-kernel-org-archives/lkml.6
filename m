Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5550CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31335218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfBATYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:24:35 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfBATYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:24:33 -0500
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MvavG-1h6d0d0UgY-00sdwn; Fri, 01 Feb 2019 20:24:21 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/2] bcm2835-drivers-next-2019-02-01
Date:   Fri,  1 Feb 2019 20:24:14 +0100
Message-Id: <1549049054-5460-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549049054-5460-1-git-send-email-stefan.wahren@i2se.com>
References: <1549049054-5460-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:Mv1akROEcQLLIC/psZSWykXnCjVfMVGx439DPVHG0QpUyjCMn5i
 u0qBRZI3fyCHk+Zg6D8GzKJWXKxUM+muuv0LY2gIx6J/fRksGOKm+DoIAzDaPtjwita4opI
 HKm8Zk2GqJD2hcLoRkArZGH6HkPEd0JJhB1K1eYdH/FTIcspnvjOr7tdXiWdHhlF3cRldLB
 N/BbJJJTSqaKn8fgh7ReQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J4lQDWa6V5Y=:3w+RmvfAAuIQimUcbZGp4w
 eSvCrMPPvPkrHkQ9Z9z9E6FLlyyqsEJ1YSfT08vyn9wasPfd4IiJBwD383Q6oTQn729PWHZkq
 qNJa5ITLQqT/FKKEhySOiaprO1j6Qb5EZpJf103SFqa92De0JvbTa3AWpjix0sgaqA9EPcBXs
 NpWyU5/JNh9E2xO2o/jyJSd0Ty2X+QiKMKcacNx3OS/XOEGTQTCfOTsvyuMNpMWUL56XGvrln
 Sabhhr/dyMZplmIKF5MX1Cq72jRExpeUv+ubtOouI3qnxaCJ5jVeG5SDarnSsl8mXPnu3ZwkE
 N2alyPfpWe9pimdrlVtR1x2G4r2lFc0wLlQrOfsPTp9S68SngGQLAd4j5CqtDIdWhkoJhngEp
 ji8AxhHzqw6i+LNPphlUzxO2pQS2kUC3SMQvubj2vBdTaQ82XenUB5avnOcQZPQc90FFZaFT7
 Fx+QWlKCFU1A3j6U3bLrgShtOEqGuiiFNHzjljBs5nZVbmEVeV0YXWiiL2cVj/uCby5grmXD8
 hAFDFHG/6/6sKdf5sm2OBMDvhpFbqLH92i+dorYcW1PCcUIJJoxt3xVM+4K1zprAm8MaPrOfh
 rn66tCaiybKVZBWr/QYgKKhbtugRzR0GgX9Vr4xKI5ysSn1ah6fYAu/UK+o6FuTax1VT25++T
 1FOSMtFldI5eWz/kKz3171zdSCe0jqV/QXAx8dfUI5tZiuLXuooO9fHz9gp01/VlIQVF+YfwL
 D5nhqEIvbczxGyponkVMiWlc67XDqxalI6XH3inwI0d8HHvUdigCFfrQsRg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit f494caa480f7089ff9bba16dd865e190cee7e545:

  soc: bcm: Make PM driver default for BCM2835 (2019-01-24 19:19:22 +0100)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-02-01

for you to fetch changes up to e1dc2b2e1bef7237fd8fc055fe1ec2a6ff001f91:

  ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware. (2019-02-01 10:34:32 +0100)

----------------------------------------------------------------
This pull requests adds the missing devicetree parts for the
new BCM2835 PM driver which depends on the driver changes.

-------------------------------------------------

Eric Anholt (2):
      ARM: bcm283x: Extend the WDT DT node out to cover the whole PM block. (v4)
      ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.

