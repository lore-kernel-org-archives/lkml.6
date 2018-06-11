Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i7ctNwM1HlscGQAAmS7hNA
	; Mon, 11 Jun 2018 08:38:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4739860792; Mon, 11 Jun 2018 08:38:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C6320602FC;
	Mon, 11 Jun 2018 08:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6320602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754174AbeFKIim (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:38:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40184 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:38:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fSILX-0006qX-7y; Mon, 11 Jun 2018 08:38:39 +0000
From: Colin King <colin.king@canonical.com>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: apr: fix spelling mistake: "paket" -> "packet"
Date: Mon, 11 Jun 2018 09:38:38 +0100
Message-Id: <20180611083838.24365-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/soc/qcom/apr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 57af8a537332..7f8c4c096ad2 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -87,7 +87,7 @@ static int apr_callback(struct rpmsg_device *rpdev, void *buf,
 	}
 
 	if (hdr->pkt_size < APR_HDR_SIZE || hdr->pkt_size != len) {
-		dev_err(apr->dev, "APR: Wrong paket size\n");
+		dev_err(apr->dev, "APR: Wrong packet size\n");
 		return -EINVAL;
 	}
 
-- 
2.17.0
