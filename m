Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6C58AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B58208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B58208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h-hofmeier.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbeFNP0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:26:07 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:60886 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755227AbeFNP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:26:04 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 4378D58C4AE;
        Thu, 14 Jun 2018 17:20:44 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Thu, 14 Jun 2018 17:20:44 +0200
From:   Henriette Hofmeier <passt@h-hofmeier.de>
To:     devel@linuxdriverproject.org
Cc:     zbr@ioremap.net, arvind.yadav.cs@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        florian.harbecke@fau.de
Subject: [PATCH 0/3] drivers/w1/masters/ds2490: Correct errors reported by checkpatch
Date:   Thu, 14 Jun 2018 17:20:38 +0200
Message-Id: <1528989641-20284-1-git-send-email-passt@h-hofmeier.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary spaces, add required spaced and 
move braces to fix errors reported by checkpatch.

Henriette Hofmeier (3):
  ds2490.c: Add required spaces
  ds2490.c: Remove unnecessary whitespace
  ds2490.c: Move struct open braces to previous line

 drivers/w1/masters/ds2490.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.7.4

