Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbeFBLLd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 07:11:33 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36044 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFBLL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 07:11:29 -0400
X-Google-Smtp-Source: ADUXVKIqangKC5B0n3CcbdGlFk7Hash6SKbvRNRvznHvpttg9HdHDpCvP4kCFVR5MMmxvkILfu76Hg==
From: Amit Kucheria <amit.kucheria@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, edubezval@gmail.com,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 0/2] thermal: tsens: SDM845 support
Date: Sat,  2 Jun 2018 14:11:11 +0300
Message-Id: <cover.1527937396.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDM845 support in the tsens driver. I've create a separate file
(tsens-sdm845.c) because I expect it to diverge from the other drivers.

Cleanup the tsens_device structure while we're at it.


Amit Kucheria (2):
  thermal: tsens: Add support for SDM845 platform
  tsens: Get rid of unused fields in structure

 .../devicetree/bindings/thermal/qcom-tsens.txt     |  1 +
 drivers/thermal/qcom/Makefile                      |  2 +-
 drivers/thermal/qcom/tsens-sdm845.c                | 98 ++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c                       |  3 +
 drivers/thermal/qcom/tsens.h                       |  3 +-
 5 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100644 drivers/thermal/qcom/tsens-sdm845.c

-- 
2.7.4
