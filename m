Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3599C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854D2218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KGZdLsnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfAaSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:06:57 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:43814 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfAaSGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tRFOfSyhn4LH0ecWRKhtpodsokTbHxM76TWr6xoC+cY=; b=KGZdLsnLwbk0Z3PxsZtAymVRsn
        ci8LxAmsQNAx1D8CsHAAH3BW0fMpl0ykaFeWiVO8gp51/DiQtNdqwdmossJv7HuFD8w5S68xWlyw/
        LxwTPvW3QNebHI8kNGG5FJjsGn1SZsotVFdWGlz6pajsInMgbYmr9erKUpeobC2WWz3M=;
Received: from p5dcc395f.dip0.t-ipconnect.de ([93.204.57.95] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpGjb-0001Ig-QL; Thu, 31 Jan 2019 19:06:43 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpGja-0003mW-NE; Thu, 31 Jan 2019 19:06:43 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org,
        tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 0/2] arm: dts: gta04: add gps support
Date:   Thu, 31 Jan 2019 19:06:38 +0100
Message-Id: <20190131180640.14480-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for gps for gta04. Formerly
it was a single patch, now a non-controllable regulator was
added for completeness sake and to satisty binding
requirements.

Andreas Kemnade (2):
  arm: dts: gta04: add ldo 3v3 regulator
  arm: dts: gta04: add gps support

 arch/arm/boot/dts/omap3-gta04.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.11.0

