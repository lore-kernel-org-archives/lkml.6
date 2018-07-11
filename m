Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E995C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56912087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56912087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kolodziej.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbeGKTfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:35:53 -0400
Received: from s1.kolodziej.it ([37.187.23.228]:48263 "EHLO s1.kolodziej.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387634AbeGKTfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:35:53 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2018 15:35:52 EDT
Received: from localhost (goldnet.4web.pl [95.175.3.2])
        (Authenticated sender: kacper@kolodziej.it)
        by s1.kolodziej.it (Postfix) with ESMTPSA id 71F4A9FC85;
        Wed, 11 Jul 2018 21:33:49 +0200 (CEST)
From:   =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Janani Sankara Babu <jananis37@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] staging: rtl8188eu: break line longer than 80 cols
Date:   Wed, 11 Jul 2018 21:24:09 +0200
Message-Id: <20180711192411.24817-1-kacper@kolodziej.it>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kacper Kołodziej <kacper@kolodziej.it>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 454a975a14f2..220b4bbe1f84 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -362,7 +362,8 @@ void	expire_timeout_chk(struct adapter *padapter)
 				stainfo_offset =
 					rtw_stainfo_offset(pstapriv, psta);
 				if (stainfo_offset_valid(stainfo_offset))
-					chk_alive_list[chk_alive_num++] = stainfo_offset;
+					chk_alive_list[chk_alive_num++] =
+						stainfo_offset;
 				continue;
 			}
 
-- 
2.16.4

