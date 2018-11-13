Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94ACC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12D122360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12D122360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbeKMTi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:38:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50258 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731399AbeKMTi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:38:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0676A78;
        Tue, 13 Nov 2018 01:41:13 -0800 (PST)
Received: from sugar.kfn.arm.com (E110176.Arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B0D53F5CF;
        Tue, 13 Nov 2018 01:41:11 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yael Chemla <yael.chemla@foss.arm.com>
Cc:     Ofir Drang <Ofir.Drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] new HW version and co-maintainer
Date:   Tue, 13 Nov 2018 09:40:34 +0000
Message-Id: <1542102039-22256-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for CryptoCell 703 HW revision and a new co-maintainer.

Gilad Ben-Yossef (3):
  crypto: ccree: add support for CryptoCell 703
  dt-bindings: crypto: ccree: add dt bindings for ccree 703
  MAINTAINERS: ccree: add co-maintainer

 .../devicetree/bindings/crypto/arm-cryptocell.txt  |  1 +
 MAINTAINERS                                        |  1 +
 drivers/crypto/Kconfig                             |  2 +-
 drivers/crypto/ccree/cc_aead.c                     | 16 ++++++++-
 drivers/crypto/ccree/cc_cipher.c                   | 38 +++++++++++++++++++++-
 drivers/crypto/ccree/cc_driver.c                   | 19 ++++++++---
 drivers/crypto/ccree/cc_driver.h                   |  8 +++++
 drivers/crypto/ccree/cc_hash.c                     | 16 +++++++--
 8 files changed, 92 insertions(+), 9 deletions(-)

-- 
2.7.4

