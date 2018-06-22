Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4DCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCD024330
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCD024330
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h-hofmeier.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933296AbeFVOCP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:02:15 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:41837 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933135AbeFVOCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:02:13 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 3B66A58C4AF;
        Fri, 22 Jun 2018 16:02:07 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Fri, 22 Jun 2018 16:02:07 +0200
From:   Henriette Hofmeier <passt@h-hofmeier.de>
To:     devel@linuxdriverproject.org
Cc:     florian.harbecke@fau.de, linux-kernel@i4.cs.fau.de,
        gregkh@linuxfoundation.org, shreeya.patel23498@gmail.com,
        garsilva@embeddedor.com, tavery321@gmail.com,
        jeremy.lefaure@lse.epita.fr, aishpant@gmail.com,
        georgiana.chelu93@gmail.com, himanshujha199640@gmail.com,
        joe@perches.com, keescook@chromium.org, natechancellor@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        xmrancho@gmail.com, Henriette Hofmeier <passt@h-hofmeier.de>
Subject: [PATCH 1/3] staging: rtl8723bs: Move definition open brace
Date:   Fri, 22 Jun 2018 16:01:57 +0200
Message-Id: <1529676119-21591-2-git-send-email-passt@h-hofmeier.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529676119-21591-1-git-send-email-passt@h-hofmeier.de>
References: <1529676119-21591-1-git-send-email-passt@h-hofmeier.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move open braces of definitions to the next line
to comply with codestyle.
Criticized by checkpatch.

Signed-off-by: Henriette Hofmeier <passt@h-hofmeier.de>
Signed-off-by: Florian Harbecke <florian.harbecke@fau.de>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index a81e130..0952d15 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -331,7 +331,8 @@ static void init_mlme_ext_priv_value(struct adapter *padapter)
 
 static int has_channel(RT_CHANNEL_INFO *channel_set,
 					   u8 chanset_size,
-					   u8 chan) {
+					   u8 chan)
+{
 	int i;
 
 	for (i = 0; i < chanset_size; i++) {
@@ -345,7 +346,8 @@ static int has_channel(RT_CHANNEL_INFO *channel_set,
 
 static void init_channel_list(struct adapter *padapter, RT_CHANNEL_INFO *channel_set,
 							  u8 chanset_size,
-							  struct p2p_channels *channel_list) {
+							  struct p2p_channels *channel_list)
+{
 
 	struct p2p_oper_class_map op_class[] = {
 		{ IEEE80211G,  81,   1,  13,  1, BW20 },
-- 
2.7.4

