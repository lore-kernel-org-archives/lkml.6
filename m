Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5210FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B8920891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 21:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B8920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeFQVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 17:11:05 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:45965 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751421AbeFQVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 17:11:04 -0400
Received: from faui49man9 (faui49man9.informatik.uni-erlangen.de [131.188.42.54])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 13FE758C4C0;
        Sun, 17 Jun 2018 23:02:36 +0200 (CEST)
Received: by faui49man9 (sSMTP sendmail emulation); Sun, 17 Jun 2018 23:02:36 +0200
From:   =?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian.blaese@fau.de>
To:     gregkh@linuxfoundation.org
Cc:     maximilian.o.ott@fau.de, linux-kernel@i4.cs.fau.de,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        julia.lawall@lip6.fr, georgiana.chelu93@gmail.com,
        dafna3@gmail.com, keescook@chromium.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Fabian=20Bl=C3=A4se?= <fabian.blaese@fau.de>
Subject: [PATCH 0/2] rtl8192u: Improve coding style
Date:   Sun, 17 Jun 2018 23:02:29 +0200
Message-Id: <1529269351-21941-1-git-send-email-fabian.blaese@fau.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch series improves coding style in rtl8192u staging driver
to fix checkpath errors.

Fabian Bläse (2):
  rtl8192u/rtl819x_Qos.h: Adjust spaces to coding guidelines
  rtl8192u/rtl819x_BAProc.c: Adjust spaces to coding guidelines

 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    | 71 +++++++---------
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h   | 94 +++++++++++-----------
 2 files changed, 78 insertions(+), 87 deletions(-)

--
2.7.4

