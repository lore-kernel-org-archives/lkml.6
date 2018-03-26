Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCZHcb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 03:32:31 -0400
Received: from foss.arm.com ([217.140.101.70]:37302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbeCZHc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 03:32:29 -0400
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: ccree: cleanup and hardware keys
Date: Mon, 26 Mar 2018 08:32:17 +0100
Message-Id: <1522049540-10042-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanup and add support for CryptoCell hardware keys.

Gilad Ben-Yossef (2):
  crypto: ccree: remove unused enums
  crypto: ccree: enable support for hardware keys

 crypto/testmgr.c                        |  43 ++++
 drivers/crypto/ccree/cc_cipher.c        | 348 ++++++++++++++++++++++++++++----
 drivers/crypto/ccree/cc_cipher.h        |  30 +--
 drivers/crypto/ccree/cc_hw_queue_defs.h |  28 +--
 4 files changed, 366 insertions(+), 83 deletions(-)

-- 
2.7.4
