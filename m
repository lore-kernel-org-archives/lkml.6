Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeCTLbC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:31:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeCTLbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:31:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF8F760591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From: Can Guo <cang@codeaurora.org>
To: subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com
Cc: linux-kernel@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v1 0/2] Support for Qualcomm UFS QMP PHY on SDM845
Date: Tue, 20 Mar 2018 19:30:49 +0800
Message-Id: <20180320113051.14444-1-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for UFS QMP PHY on SDM845 and updates the
compitable string for it.

Can Guo (2):
  phy: Add QMP phy based UFS phy support for sdm845
  dt-bindings: phy-qcom-qmp: Update UFS phy compitable string for sdm845

 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   3 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 120 ++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   8 ++
 3 files changed, 128 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
