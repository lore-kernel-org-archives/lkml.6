Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C4CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4921526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4921526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeITWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:41:23 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36246 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeITWlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:41:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E2DCD1A00A0;
        Thu, 20 Sep 2018 18:56:57 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ABCA01A0030;
        Thu, 20 Sep 2018 18:56:57 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.33.95])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id E1DCF40A63;
        Thu, 20 Sep 2018 09:56:56 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] fixes for soc/fsl drivers for v4.19
Date:   Thu, 20 Sep 2018 11:56:56 -0500
Message-Id: <20180920165656.31902-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please merge the following fixes for soc/fsl drivers.

Regards,
Leo

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fixes-for-4.19

for you to fetch changes up to 3cb31b634052ed458922e0c8e2b4b093d7fb60b9:

  soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift() (2018-09-17 16:01:46 -0500)

----------------------------------------------------------------
soc/fsl fixes for 4.19

----------------------------------------------------------------
Alexandre Belloni (2):
      soc: fsl: qbman: qman_portal: defer probing when qman is not available
      soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Zhao Qiang (1):
      soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()

 drivers/soc/fsl/qbman/qman.c        | 3 +++
 drivers/soc/fsl/qbman/qman_portal.c | 2 ++
 drivers/soc/fsl/qe/ucc.c            | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)
