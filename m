Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A63FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE99208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIIDECqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE99208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeJAM6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbeJAM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:58:43 -0400
Received: from localhost.localdomain (unknown [106.201.51.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976842083C;
        Mon,  1 Oct 2018 06:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538374955;
        bh=eXU2GdgVQQgg/zvIm3lvao3HAUAAXXFZxl+Pa3vBQRI=;
        h=From:To:Cc:Subject:Date:From;
        b=tIIDECqTFJQb1MzTmOT7es8q/dX+3ZV3PzxWPnLgl7gDGzIu+fnp86arWn5s9O82Z
         CYiJ7TOyczwU7wTnCOcL8s99cqsT8rzw7CSs3V8QFqhipUB271oDBGrsOHZSRPk9ul
         UQxtNLNVyU+9xlh91sj2e34RoDTyMwqbReH9ydgs=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v6 0/2] arm64: dts: add prng-ee nodes
Date:   Mon,  1 Oct 2018 11:51:49 +0530
Message-Id: <20181001062151.27607-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds prng-ee nodes for msm8996 and sdm845

changes in v6:
 - Fix comments given by Stan

changes in v5:
 - Add more description in patch logs

changes in v4:
 - Fix node address on sdm845

changes in v3:
 - Add Bjorn's reviewed-by
 - Update patch titles to reflect that they add nodes

changes in v2:
 - rebase on v4.19-rc1

Vinod Koul (2):
  arm64: dts: msm8996: add prng-ee node
  arm64: dts: sdm845: add prng-ee node

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 7 +++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 8 ++++++++
 2 files changed, 15 insertions(+)

-- 
2.14.4

