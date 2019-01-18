Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE97C5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38AF2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfARXWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:22:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:52764 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbfARXWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:22:53 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 424D920029D;
        Sat, 19 Jan 2019 00:22:51 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C0F1200079;
        Sat, 19 Jan 2019 00:22:51 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.49])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 433EB40CAD;
        Fri, 18 Jan 2019 16:22:50 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] fixes for soc/fsl drivers for v5.0
Date:   Fri, 18 Jan 2019 17:22:50 -0600
Message-Id: <20190118232250.22570-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please merge the following fix for soc/fsl drivers.

Regards,
Leo


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.0

for you to fetch changes up to 89857a8a5c89a406b967ab2be7bd2ccdbe75e73d:

  soc: fsl: qbman: avoid race in clearing QMan interrupt (2019-01-18 16:48:35 -0600)

----------------------------------------------------------------
soc/fsl fixes for v5.0

- qbman: avoid missing interrupts by only clearing processed events

----------------------------------------------------------------
Madalin Bucur (1):
      soc: fsl: qbman: avoid race in clearing QMan interrupt

 drivers/soc/fsl/qbman/qman.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
