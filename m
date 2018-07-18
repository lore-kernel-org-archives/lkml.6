Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2601ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82AA206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82AA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeGRMYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:24:32 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39180 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730512AbeGRMYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:24:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 92CAA20012D;
        Wed, 18 Jul 2018 13:46:59 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 863E120012E;
        Wed, 18 Jul 2018 13:46:59 +0200 (CEST)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 14982205F3;
        Wed, 18 Jul 2018 13:46:59 +0200 (CEST)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org
Cc:     paulus@samba.org, mpe@ellerman.id.au, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH 0/3] powerpc/dpaa: use the Cortina PHY driver
Date:   Wed, 18 Jul 2018 14:46:48 +0300
Message-Id: <cover.1531903211.git.camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortina PHY on T2080RDB and T4240RDB requires the use of the
dedicated Cortina PHY driver. This patch series enables it for
DPAA platforms and uses it on T4240RDB and T2080RDB.

Camelia Groza (3):
  powerpc/configs/dpaa: enable the Cortina PHY driver
  powerpc/dts/fsl: t4240rdb: use the Cortina PHY driver compatible
  powerpc/dts/fsl: t2080rdb: use the Cortina PHY driver compatible

 arch/powerpc/boot/dts/fsl/t2080rdb.dts | 4 ++--
 arch/powerpc/boot/dts/fsl/t4240rdb.dts | 8 ++++----
 arch/powerpc/configs/dpaa.config       | 1 +
 3 files changed, 7 insertions(+), 6 deletions(-)

--
1.9.1

