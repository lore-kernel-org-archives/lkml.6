Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14725C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC41D24330
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC41D24330
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h-hofmeier.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933133AbeFVOCI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:02:08 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:41813 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751233AbeFVOCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:02:07 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id B2A9B58C4AE;
        Fri, 22 Jun 2018 16:02:02 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Fri, 22 Jun 2018 16:02:02 +0200
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
Subject: [PATCH 0/3] staging: rtl8723bs: Correct errors reported by checkpatch and comment
Date:   Fri, 22 Jun 2018 16:01:56 +0200
Message-Id: <1529676119-21591-1-git-send-email-passt@h-hofmeier.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix errors reported by checkpatch:
  * move open braces of defintions
  * remove unnecessary initializations

Change comment on local variable definition to comply
with coding-style and correct to 'global variables'.

Henriette Hofmeier (3):
  rtl8723bs: Move definition open brace to next line
  rtl8723bs: Remove unnecessary initializations
  staging: rtl8723bs: Fix comment on variable init

 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 13 +++++--------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  6 ++++--
 2 files changed, 9 insertions(+), 10 deletions(-)

-- 
2.7.4

