Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968033AbeBOM2V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:28:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36083 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031283AbeBOM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:27:19 -0500
X-Google-Smtp-Source: AH8x226m9Pm8C1FJzlMRCFwl8r1RSJbq70I+a3lWOJy73hm4TAIfFbumrdZt52qgM7Zl2DCY/ZuCXA==
From: srinivas.kandagatla@linaro.org
To: vinod.koul@intel.com, andy.gross@linaro.org, dmaengine@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, david.brown@linaro.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/5] dt-bindings: dmaengine: bam_dma: add remote controlled bindings
Date: Thu, 15 Feb 2018 12:25:08 +0000
Message-Id: <20180215122511.13517-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
References: <20180215122511.13517-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds 2 new properties for remote controlled bam dt bindings.
1. num-channels to indicate number of dma channels.
2. qcom,num-ees to indicate number of Execution Environments.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
index 9cbf5d9df8fd..cf5b9e44432c 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
@@ -15,6 +15,10 @@ Required properties:
   the secure world.
 - qcom,controlled-remotely : optional, indicates that the bam is controlled by
   remote proccessor i.e. execution environment.
+- num-channels : optional, indicates supported number of DMA channels in a
+  remotely controlled bam.
+- qcom,num-ees : optional, indicates supported number of Execution Environments
+  in a remotely controlled bam.
 
 Example:
 
-- 
2.15.1
