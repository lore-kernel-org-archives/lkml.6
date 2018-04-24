Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeDXMta (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:49:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38345 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbeDXMpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:45:22 -0400
X-Google-Smtp-Source: AIpwx4+SrlA3fW7TvtIsXJaMxf90HxSvH3jexW+ip267rECWmQV8Ac+cv6+31SwlCSZEP4eZNZ3Brg==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 13/28] venus: core: delete not used flag for buffer mode
Date: Tue, 24 Apr 2018 15:44:21 +0300
Message-Id: <20180424124436.26955-14-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
References: <20180424124436.26955-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete not used flag for capture buffer allocation mode.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index fe2d2b9e8af8..c46334454cd9 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -249,7 +249,6 @@ struct venus_buffer {
  * @priv:	a private for HFI operations callbacks
  * @session_type:	the type of the session (decoder or encoder)
  * @hprop:	a union used as a holder by get property
- * @cap_bufs_mode_static:	buffers allocation mode capability
  * @cap_bufs_mode_dynamic:	buffers allocation mode capability
  */
 struct venus_inst {
@@ -299,7 +298,6 @@ struct venus_inst {
 	const struct hfi_inst_ops *ops;
 	u32 session_type;
 	union hfi_get_property hprop;
-	bool cap_bufs_mode_static;
 	bool cap_bufs_mode_dynamic;
 };
 
-- 
2.14.1
