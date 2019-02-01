Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB2BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E1E21726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfBAXDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:03:32 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:48721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:03:31 -0500
Received: from localhost.localdomain ([37.4.249.100]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MDQqe-1gxzpf2vQ6-00AYFD; Sat, 02 Feb 2019 00:03:21 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] bcm2835-dt-64-next-2019-02-01
Date:   Sat,  2 Feb 2019 00:02:59 +0100
Message-Id: <1549062179-5828-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:fB3eGHoWQE6HRo1RhgijEvTgiMdmiWiuKR/H9bBPIxNP8s7HVo1
 54OJCaQPXMuv56jvSKLaobXg5NuFiSU0zHY/GiMyMSPP9crcb2LMR1C+aWBKYLd+0LZgmN3
 CsioxL1nXE9aYwoPZcE/iNHa5D05lhHvvgFVtj/8nmiBOerZH4SWhctevAfDmna34FQ/jjX
 G8XrCWu9C3VQHliheXGlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b/3RHBjW1/A=:BXYqtVxT90Gjg9wt3BOXl9
 Z1jjarR/FLlb3P4MpnjYy3AhMc5zBC2quQi5M9Jg35nAiCoj5sRLhuT8or9vCoou4k4E9sOgy
 6kott2ZzERl0L2vLlXFWL/LDiACu1Y2oAVG0ki/Ed2X/WjVm2GQYz87RVmIdU4qfCNhl/hiyW
 liUAhAFNZTbEHRsk0RXDQ3RxVhiFxHX5X+wiRqsqeO8uTqwrNKzfAMo36MQ+bhcXHI7tvtsRD
 LxCvQvyWqOsJ8/rjTJQedtWltxaiyELve5LzPzmOIHUS5YCY+5/FsEnc8uVKnV7syGb0Dvn12
 RCwyad+lelnVTWQgtQI7227bf4uFH41R5AMhkecrXblRWfRluGCsBlNvzMBCNfO5podUGN69H
 y9TQKfOFUCcZuLLbkXCdLNw2LKQIhhucp4yZifqSERyI18Y5Ijig5lCTbyb27ZSklC7xl2oD0
 Fqrhzkf9SwdY3rRJTKP06RFCPRvMll4DJ7ypn4KpoB8eB9xrPkOmXGSM1UKsD31q6l1Ms298l
 5pHAAbRBKrh3K71cLtImnFy+5jjJXtkgCQdYyK87/ltNR6VopqoYXLhbNdgJAZQF20HxhhmcV
 Q+iIxLDxYhtTJUlxX0FPCsfRvy0wDi/ttCPGiwgSS6v7xMGDC6+JumVA25SgM4G0Eztt/nDeM
 PynqpnPUAE9wDfl2PuQOahowHyv/7VMaUry6NVxDw9fbJhFg/YbSW0S5RiCttmip0JG4+/JqO
 bwztSTybcnEfV6TQjcqoLubOrnKJ5Qavqiykj4VjJNirGgILjx/zJ+fLaBc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

this is the fixup version (cherry picked the patch with the reference target)
of the dt-64-next pull request. Please consider this as a replacement for
the broken dt-64-next pull request.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-64-next-2019-02-01

for you to fetch changes up to 441d8020d8fc8654698f5518cdf76832f84101f4:

  arm64: dts: broadcom: Add reference to RPi 3 A+ (2019-02-01 23:35:26 +0100)

----------------------------------------------------------------
This pull request brings in the arm64 reference for Raspberry Pi 3 A+.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: dts: add Raspberry Pi 3 A+
      arm64: dts: broadcom: Add reference to RPi 3 A+

