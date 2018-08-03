Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC2BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C840621757
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 14:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C840621757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbeHCQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 12:32:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57192 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbeHCQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 12:32:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1flbBR-0000i1-EE; Fri, 03 Aug 2018 14:36:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Antti Palosaari <crope@iki.fi>, linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Trival spelling mistake fixes
Date:   Fri,  3 Aug 2018 15:35:57 +0100
Message-Id: <20180803143601.4211-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Four Trival spelling mistake fixes

Colin Ian King (4):
  media: au0828: fix spelling mistake: "completition" -> "completion"
  media: cx231xx: fix spelling mistake: "completition" -> "completion"
  media: dvb-usb-v2: fix spelling mistake: "completition" ->
    "completion"
  media: dvb-usb: fix spelling mistake: "completition" -> "completion"

 drivers/media/usb/au0828/au0828-video.c   | 2 +-
 drivers/media/usb/cx231xx/cx231xx-audio.c | 4 ++--
 drivers/media/usb/cx231xx/cx231xx-vbi.c   | 2 +-
 drivers/media/usb/dvb-usb-v2/usb_urb.c    | 4 ++--
 drivers/media/usb/dvb-usb/usb-urb.c       | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1

