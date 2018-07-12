Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D459C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE3C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE3C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kolodziej.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbeGLIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:20:20 -0400
Received: from s1.kolodziej.it ([37.187.23.228]:49318 "EHLO s1.kolodziej.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeGLIUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:20:20 -0400
Received: from localhost (goldnet.4web.pl [95.175.3.2])
        (Authenticated sender: kacper@kolodziej.it)
        by s1.kolodziej.it (Postfix) with ESMTPSA id 027B99F9E0;
        Thu, 12 Jul 2018 10:21:11 +0200 (CEST)
From:   =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Cc:     =?UTF-8?q?Kacper=20Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Janani Sankara Babu <jananis37@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] staging: rtl8188eu: break line longer than 80 cols
Date:   Thu, 12 Jul 2018 10:11:39 +0200
Message-Id: <20180712081141.9147-1-kacper@kolodziej.it>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180712061701.GF20905@kroah.com>
References: <20180712061701.GF20905@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break too long line to follow kernel coding style.

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

