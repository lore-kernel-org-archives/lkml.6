Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753038AbeDJW0K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:26:10 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:39747 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752977AbeDJW0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:26:06 -0400
X-Google-Smtp-Source: AIpwx4+nIm+XEIuLGuTpYskLjRF3wYaRgjyGELCMy7MwNSvG153NuilYKe8O5OLvsoa5kAUjB8UQ3Q==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org
Cc: clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] soc: qcom: smem: bug fixes
Date: Tue, 10 Apr 2018 17:25:36 -0500
Message-Id: <20180410222542.29474-1-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains mostly bug fixes to the Qualcomm shared memory
("smem") code.  Although the bugs are real, they have most likely
never been observed.

					-Alex

Alex Elder (6):
  soc: qcom: smem: fix first cache entry calculation
  soc: qcom: smem: return proper type for cached entry functions
  soc: qcom: smem: byte swap values properly
  soc: qcom: smem: fix off-by-one error in qcom_smem_alloc_private()
  soc: qcom: smem: fix qcom_smem_set_global_partition()
  soc: qcom: smem: check sooner in qcom_smem_set_global_partition()

 drivers/soc/qcom/smem.c | 50 +++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

-- 
2.14.1
