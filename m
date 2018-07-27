Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD09C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBA3208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBA3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbeG0QGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:06:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55132 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbeG0QGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:06:42 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 65F1D20001F;
        Fri, 27 Jul 2018 16:44:27 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D96C200054;
        Fri, 27 Jul 2018 16:44:27 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 9423740A59;
        Fri, 27 Jul 2018 07:44:26 -0700 (MST)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w6REiOWU027745;
        Fri, 27 Jul 2018 07:44:25 -0700
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, ruxandra.radulescu@nxp.com,
        devel@driverdev.osuosl.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 0/2] staging: fsl-dpaa2: document nested structs as per kernel-doc
Date:   Fri, 27 Jul 2018 17:43:16 +0300
Message-Id: <cover.1532701591.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document nested structs per kernel-doc requirements by moving
all comments before the actual struct.

Changes in v2:
 - remove comments of non-existent fields

Ioana Ciornei (2):
  staging: fsl-dpaa2/eth: document nested structs as per kernel-doc
  staging: fsl-dpaa2/ethsw: document nested structs as per kernel-doc

 drivers/staging/fsl-dpaa2/ethernet/dpkg.h |  70 +++++++---------
 drivers/staging/fsl-dpaa2/ethernet/dpni.h | 129 +++++++++++++++++-------------
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h    |  27 +++----
 3 files changed, 111 insertions(+), 115 deletions(-)

-- 
1.9.1

