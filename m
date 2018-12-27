Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCEFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC99208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 15:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DqPv2SzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeL0POK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 10:14:10 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:60222 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeL0POK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 10:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0YLe2lWrbOUu3QJqkj/z4Ailqp2oY93NPqvnx4CrwQk=; b=DqPv2SzHpISGOxrsDCtEWQdDHC
        LATtVrDtbQjWAYXjTVIw8N2XM8zos0f8GnSkJ3BF+jhwSja9LTJi+gz0GDa7egxATI8Ouj1498p+w
        I2p081EZH8fiqN2UJ4Qmkta60egGSj8v4YvKRQZxUC3MHAa3k36YAOxCgJiGWZDiEUW0=;
Received: from p200300ccfbcbef001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:ef00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gcXMA-0003PL-OC; Thu, 27 Dec 2018 16:13:54 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gcXMA-0007ko-Hc; Thu, 27 Dec 2018 16:13:54 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] hwmon: devicetree support for hih6130
Date:   Thu, 27 Dec 2018 16:13:47 +0100
Message-Id: <20181227151349.29753-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds devicetree support for hih6130, so it can
be properly auto-probed using devicetree files

Andreas Kemnade (2):
  hwmon: (hih6130) add dtb compatibility tables
  devicetree: hwmon: Add bindings documentation for HIH6130

 Documentation/devicetree/bindings/hwmon/hih6130.txt | 12 ++++++++++++
 drivers/hwmon/hih6130.c                             | 11 ++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt

-- 
2.11.0

