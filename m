Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeBGNJt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:09:49 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34477 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753731AbeBGNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:09:45 -0500
From: Fabien Dessenne <fabien.dessenne@st.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Corentin LABBE <clabbe.montjoie@gmail.com>,
        <linux-crypto@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>,
        Lionel Debieve <lionel.debieve@st.com>
Subject: [PATCH 0/2] crypto: stm32/cryp - add AEAD cipher algorithms
Date: Wed, 7 Feb 2018 14:08:53 +0100
Message-ID: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset depends on "crypto: engine - Permit to enqueue all async requests"
proposed by Corentin Labbe [https://lkml.org/lkml/2018/1/26/608].
stm32-cryp uses this updated crpyto engine to handle AEAD cipher algortihms.

Fabien Dessenne (2):
  crypto: stm32/cryp - add aes gcm / ccm support
  crypto: stm32/cryp - add stm32mp1 support

 drivers/crypto/stm32/stm32-cryp.c | 937 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 908 insertions(+), 29 deletions(-)

-- 
2.7.4
