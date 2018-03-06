Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752866AbeCFJox (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:44:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35516 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbeCFJov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:44:51 -0500
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: introduce SM4 symmetric cipher algorithm
Date: Tue,  6 Mar 2018 09:44:41 +0000
Message-Id: <1520329484-23317-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016) and
related tests.

SM4 (GBT.32907-2016) is a cryptographic standard issued by the
Organization of State Commercial Administration of China (OSCCA)
as an authorized cryptographic algorithms for the use within China.

SMS4 was originally created for use in protecting wireless
networks, and is mandated in the Chinese National Standard for
Wireless LAN WAPI (Wired Authentication and Privacy Infrastructure)
(GB.15629.11-2003).

Tested on arm 64 and 32 bit.

Gilad Ben-Yossef (2):
  crypto: introduce SM4 symmetric cipher algorithm
  crypto: introduce SM4 testmgr tests

 crypto/Kconfig       |  25 ++++++
 crypto/Makefile      |   1 +
 crypto/sm4_generic.c | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto/tcrypt.c      |   3 +
 crypto/testmgr.c     |   9 ++
 crypto/testmgr.h     | 131 +++++++++++++++++++++++++++
 include/crypto/sm4.h |  28 ++++++
 7 files changed, 441 insertions(+)
 create mode 100644 crypto/sm4_generic.c
 create mode 100644 include/crypto/sm4.h

-- 
2.7.4
