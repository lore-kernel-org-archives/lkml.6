Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F692C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4421620896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 05:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4421620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tamalin.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeFQFbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 01:31:15 -0400
Received: from mout.perfora.net ([74.208.4.194]:40853 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932123AbeFQFbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 01:31:11 -0400
Received: from kahja.local ([73.231.184.107]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MO9FS-1fXi3n0n1I-005Xo2;
 Sun, 17 Jun 2018 07:31:03 +0200
From:   Quytelda Kahja <quytelda@tamalin.org>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 08/11] staging: rtl8723bs: Fix spelling mistake in comment.
Date:   Sat, 16 Jun 2018 22:30:37 -0700
Message-Id: <20180617053040.5903-8-quytelda@tamalin.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617053040.5903-1-quytelda@tamalin.org>
References: <20180617053040.5903-1-quytelda@tamalin.org>
X-Provags-ID: V03:K1:71ku56bCFU+fnR3zE6G8dcr6DWjLz8wltsbWtdv2igsKEnSo1wN
 4GlSeCPshlvQxB76UIsnoF6UPqqfaC66hIwn8XHfQWmc6EkUV5AidwIZjlWyJcUIWWk65Vp
 BdrA+cCHlYj31rU6tb643PoyIS6mRzVNyP7OWYsXhgoA+sKhUoTpBd+y4vVJ5P7+CsaYVIL
 vKw13b2Y0jlMw2clV26Ig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VF3ls8CNam8=:YScJ5qGv29g6CENyybiJ5Z
 x/wFsQlaYA2/jJbW7AG3NfPL/Rh8b0Sw7AXBt3vGIyaGKbrmRb+IwgNCBPXeZ6vBLRIUGmqA5
 Z5LUOSMjC0Sj4HbVVycgX5dZGI2O/Jei5kzgw5CSwGkmYa1SUkvmI5tNY+RTKw+o5BbfVYYJj
 DrpDTxo2UcEnQFB5qY5iI0L43Yc9MfvUTkEJRJPQKLlq+Ybb/OmfHE/42mHzu+PTbcVxYjmq7
 HVoRnW1FHB+Xyn4JZsEukW1CWuIu7ZbJWH09qn2p6kcisxk3BP3y3wg/Cf0cNWpC5CacLDWxd
 hA5ICoo8Qvo42oAY94RP3HkOZ9MjpB7+H4s1tJrKP0VhveaeyLQqWwBfpH6G58BBOADoOuc9n
 9Oo3YSAn69gRc6bit+WibRYK2IBfXLvNZU+nkUbWn20CfsILZwlmiUYNYk+PcsTwka/5pFIUX
 V0GtdwmZp89OdZHg9nRLQpMd6LGCLIYGS6ePRYTORKoHEzSoDRbVFYoCiB59FLfs078UuT2s/
 E7jLHItGy7hhjUt0lBS/undoi8Zlpxd8CkY41DqoMcp0CGDMdWFM0BspoKRnsfW9xlXs8bPj5
 2N9ENJY6QR7yJCBXdwGpZh9F6uHDdks1CzrIui0WmXKP1pGbOUHw2LZewNOpdL/xpTVCYl+5V
 N0gzww6w2OAcq7oKccx/rTNqA1sfFyXiDHZyFuXeNbDMxhOHbDQmXTpbabdI5bmMucbU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 6d8a07ac7bb3..dd097df86fa3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1731,7 +1731,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	if (idx_rate_sctn == 0 || idx_rate_sctn == 1)
 		idx_bandwidth = 0;
 
-	/*  workaround for wrong indxe combination to obtain tx power limit, */
+	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  HT on 80M will reference to HT on 40M */
 	if ((idx_rate_sctn == 2 || idx_rate_sctn == 3) &&
 	    band_type == BAND_ON_5G && idx_bandwidth == 2) {
-- 
2.17.1

