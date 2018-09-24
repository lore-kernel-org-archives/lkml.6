Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C142C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D74E20666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D74E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeIYEYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:24:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53482 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbeIYEYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:24:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B94EA2001A8;
        Tue, 25 Sep 2018 00:20:18 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F63520019A;
        Tue, 25 Sep 2018 00:20:18 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.69])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id A98FD40A63;
        Mon, 24 Sep 2018 15:20:17 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] updates for soc/fsl drivers for v4.20
Date:   Mon, 24 Sep 2018 17:20:17 -0500
Message-Id: <20180924222017.30522-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please pull soc/fsl drivers updates for v4.20.

Regards,
Leo

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-next-v4.20

for you to fetch changes up to afa86d264a7ce62ba214bc7c6012e2129141421e:

  soc: fsl: dpio: remove redundant pointer 'priv' (2018-08-30 12:19:02 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v4.20

- Use of_get_child_by_name helper for QE driver
- Remove redundant pointer 'priv' for dpio driver

----------------------------------------------------------------
Colin Ian King (1):
      soc: fsl: dpio: remove redundant pointer 'priv'

Rob Herring (1):
      soc: fsl/qe: Use of_get_child_by_name helper

 drivers/soc/fsl/dpio/dpio-driver.c | 3 ---
 drivers/soc/fsl/qe/qe.c            | 6 +-----
 2 files changed, 1 insertion(+), 8 deletions(-)
