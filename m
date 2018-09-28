Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A404C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA93E206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA93E206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeI2E3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:29:18 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:54712 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726244AbeI2E3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:29:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2E086837F24D;
        Fri, 28 Sep 2018 22:03:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trip12_1ec4ee1321114
X-Filterd-Recvd-Size: 2031
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:03:31 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: Bad MAINTAINERS pattern in section 'SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER'
Date:   Fri, 28 Sep 2018 15:03:29 -0700
Message-Id: <20180928220330.31325-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	12851	SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
	12852	M:	Łukasz Stelmach <l.stelmach@samsung.com>
	12853	L:	linux-samsung-soc@vger.kernel.org
	12854	S:	Maintained
	12855	F:	drivers/char/hw_random/exynos-trng.c
-->	12856	F:	Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt

Commit that introduced this:

commit 6cd225cc5d8a6526b2bea41955882be55d4f109e
 Author: Łukasz Stelmach <l.stelmach@samsung.com>
 Date:   Fri Dec 22 17:48:35 2017 +0100
 
     hwrng: exynos - add Samsung Exynos True RNG driver
     
     Add support for True Random Number Generator found in Samsung Exynos
     5250+ SoCs.
     
     Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
     Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
     Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
 
  MAINTAINERS                          |   7 ++
  drivers/char/hw_random/Kconfig       |  12 ++
  drivers/char/hw_random/Makefile      |   1 +
  drivers/char/hw_random/exynos-trng.c | 237 +++++++++++++++++++++++++++++++++++
  4 files changed, 257 insertions(+)

No commit with Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt found

