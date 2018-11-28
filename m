Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A514C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDD12081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDD12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeK2DOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:14:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48963 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbeK2DOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:14:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gS2S0-0000YP-Ud; Wed, 28 Nov 2018 16:12:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: speakup: i18n: fix spelling mistake "phoneticly" -> "phonetically"
Date:   Wed, 28 Nov 2018 16:12:32 +0000
Message-Id: <20181128161232.14907-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in array speakup_default_msgs at index
MSG_FUNCNAME_SPELL_WORD_PHONETICALLY, fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/speakup/i18n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/speakup/i18n.c b/drivers/staging/speakup/i18n.c
index cea8707653f5..ee240d36f947 100644
--- a/drivers/staging/speakup/i18n.c
+++ b/drivers/staging/speakup/i18n.c
@@ -336,7 +336,7 @@ static char *speakup_default_msgs[MSG_LAST_INDEX] = {
 	[MSG_FUNCNAME_SPELL_DELAY_DEC] = "spell delay decrement",
 	[MSG_FUNCNAME_SPELL_DELAY_INC] = "spell delay increment",
 	[MSG_FUNCNAME_SPELL_WORD] = "spell word",
-	[MSG_FUNCNAME_SPELL_WORD_PHONETICALLY] = "spell word phoneticly",
+	[MSG_FUNCNAME_SPELL_WORD_PHONETICALLY] = "spell word phonetically",
 	[MSG_FUNCNAME_TONE_DEC] = "tone decrement",
 	[MSG_FUNCNAME_TONE_INC] = "tone increment",
 	[MSG_FUNCNAME_VOICE_DEC] = "voice decrement",
-- 
2.19.1

