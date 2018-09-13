Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB6C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C713E2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C713E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeIMK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:58:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeIMK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:58:54 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N1whr-1foo6h2AaP-012JZk; Thu, 13 Sep 2018 07:50:38 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/3] bcm2835-dt-64-next-2018-09-09
Date:   Thu, 13 Sep 2018 07:50:32 +0200
Message-Id: <1536817833-3900-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
References: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:gb6wvIgTeWahlkDXE/nSBdyGM1qRybFeAileIRmT7sy2kSUWzEx
 R/AFR5TUlvXeB+QREsgaK5At/Ufzo/pHssHD82L4o2iB8hWZzuHWFU3EkwjZ0qdt3yd/zZg
 H+kdUlVQTHfABzrsBAsCtHDZKuuIFxXDZM46NRjeUVcL4rs85BQUEkI2AnlXhoZv1TA2zUB
 TcJkM/WPlaPy3QTDMRbMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SiZNxH4okAo=:x573xWL2ipWXN0d4F/obxX
 /2CTS+kcipS2kPx3+P1NrohkLyvJ0aUsOnFDHx5io7CMhCcbCMMtsYmPG7vgyYH4VK97XITHb
 FJnvcUFRlMQMp/ssURaQqt40g/x0pM3sUjjnXQjVZJRM14reWa/jXcFAmB/bJWF8bReUdujn2
 GiEPeURqGQhR0uQRgTZ95vpj+QftyX0guI2JmatgRNf8PCW7kGsGd5/xRzZQz08VO5qYGWneX
 52QgIO0fTFmsTQiUlnvvOyAHpGNNEi8ihtGHrvvD9mCYqSp2uxLEHXja9JqmAjg5s4z8t28Vq
 zJPvAqUmXKe5R0eQRfdQEsqyPUj+DHcT0kOULyT+Q+fCKfDDJsXCivSF90ujiA5dKSBXTM+DZ
 KUepVCH5OOvs5vkDtfUqaLqcLLDIixTG7ACO1pBaL1MPVd1j3gpFecGR+GfDCzRN22djoIiZm
 lDSslDMWEwrXHue/JYxHg2mMuwg3hyrGzhTUelLgQg5/khzJwqkoGjwb3oi4brxqQzUH319Co
 //y45qscouhxQz6hFylLqCeyiz7BV0CQXZS0KPAudmiIKXYrZQLCUxA0WUwS/Amv9mXz2G4cv
 5FGg1KBOscBNfQT7yt4JMA2oU3XioLaQ18cb8KpvKDESS0F9cFEm1OUnvjrKIEBn6zQ12R8tY
 r4p6DUMgYHleOU+4sax4Iz5+HSHummFLj+SDyAIpl482PQnB5PPCd+J8qy5k2QUTbEx4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-64-next-2018-09-09

for you to fetch changes up to a7eb26392b893bff92b1eb6483f4af3d2eb19510:

  arm64: dts: broadcom: Add reference to Compute Module IO Board V3 (2018-08-31 07:01:34 +0200)

----------------------------------------------------------------
This pull request brings in the arm64 reference for Raspberry Pi Compute
Module 3.

----------------------------------------------------------------
Stefan Wahren (1):
      arm64: dts: broadcom: Add reference to Compute Module IO Board V3

 arch/arm64/boot/dts/broadcom/Makefile                | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
