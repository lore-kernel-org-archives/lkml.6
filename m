Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F0B2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfBSVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:09:57 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44070 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfBSVJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:09:56 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C46C1A0064;
        Tue, 19 Feb 2019 22:09:55 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C28ED1A011E;
        Tue, 19 Feb 2019 22:09:54 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.49])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id EB90340CAF;
        Tue, 19 Feb 2019 14:09:53 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for v5.1 take3
Date:   Tue, 19 Feb 2019 15:09:53 -0600
Message-Id: <20190219210953.1840-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please help to look into the following changes on top of previous
pull request and merge them if they look good.


The following changes since commit 3c0d64e867ed78a782a8a00d3b519396d9c5a2db:

  soc: fsl: guts: reuse machine name from device tree (2019-01-11 16:08:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1-3

for you to fetch changes up to bd3bd3b36df725645036748e58a8c35c8d2cbf91:

  soc: fsl: dpio: fix memory leak of a struct qbman on error exit path (2019-02-19 14:59:39 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.1 take3

DPIO driver
- fixed a use after free problem
- fixed a memory leak on error path

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: dpio: fix memory leak of a struct qbman on error exit path

Dan Carpenter (1):
      soc: fsl: dpio: Use after free in dpaa2_dpio_remove()

 drivers/soc/fsl/dpio/dpio-driver.c  | 2 +-
 drivers/soc/fsl/dpio/qbman-portal.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
