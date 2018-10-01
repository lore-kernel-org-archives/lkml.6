Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36905C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8F32089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8F32089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeJBFig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:38:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:44212 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJBFif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:38:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B810200015;
        Tue,  2 Oct 2018 00:58:28 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F9BF2001CF;
        Tue,  2 Oct 2018 00:58:28 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.181])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 5AE1340A63;
        Mon,  1 Oct 2018 15:58:27 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19 take 2
Date:   Mon,  1 Oct 2018 17:58:27 -0500
Message-Id: <20181001225827.21946-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please merge the updated fix for the following issue.

Regards,
Leo

The following changes since commit 96fc74333f84cfdf8d434c6c07254e215e2aad00:

  soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-25 13:57:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git soc-fsl-fix-v4.19-2

for you to fetch changes up to 5a1eb8b9542884592a018829bb1ff20c9695d925:

  soc: fsl: qman_portals: defer probe after qman's probe (2018-10-01 17:47:43 -0500)

----------------------------------------------------------------
NXP/FSL SoC driver fixes for v4.19 round 2

- Fix crash of qman_portal by deferring its probe if qman is not probed

----------------------------------------------------------------
Laurentiu Tudor (2):
      soc: fsl: qbman: add APIs to retrieve the probing status
      soc: fsl: qman_portals: defer probe after qman's probe

 drivers/soc/fsl/qbman/bman_ccsr.c   | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c   | 11 +++++++++++
 drivers/soc/fsl/qbman/qman_portal.c |  8 ++++++++
 include/soc/fsl/bman.h              |  8 ++++++++
 include/soc/fsl/qman.h              |  8 ++++++++
 5 files changed, 46 insertions(+)
