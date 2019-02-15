Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25518C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3A9217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="l/OVYs43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfBOANi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:13:38 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:53186 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfBOANh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:13:37 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1F0DYZN010259
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:13:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1F0DYZN010259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550189614;
        bh=MCdVTYrxWT51ahRDJrWzWV93+APa0whUUx6krSzdkzI=;
        h=From:Date:Subject:To:Cc:From;
        b=l/OVYs43FR056G7L8FNoh5dmEPjy6479+CjE3ufMDACzMbTPjseX2RSHqIc5GnmYl
         T3Eb4SO6f7CXF95j+6XUPBD/1PD1nkxGW1UrjWjJ3Elau8mXha4GaDQl/Z9SsReN5Y
         ++/DR+RBq2cDX4TDL5YqOdznNRJaia6MZHMNryqu/RFyLZmeq0X3wdB5yYYEcL/Qdp
         BMwb/q71/yB+DtSi2mxXNtY7JsyEffvu/bwMryC4hAbnLaMFo2BpXf9xyXyp1zpMZQ
         p7Mi/6FleFsEXLnZMvIbyd4A/3v3rxQRXfmQPVshDY3pcn1AWe0YcbudK561cU7xlm
         hFrsnTaIpRF6A==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id e81so1677126vsd.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 16:13:34 -0800 (PST)
X-Gm-Message-State: AHQUAuaclsytMKnac+And8AItmYdKz1nk2Nce1URWgzJ/5o2eqw3ycUp
        ElUSZL4dQQ6DtXpJGn1/wtid6hwA0EjomqrTbT4=
X-Google-Smtp-Source: AHgI3IaxjPC+fVyohsCGKpe3R9ayn9eioAAWkTvzLxzBJYAo+2nzUp0gZELZzZp9mkcVZbbkwt2KmQ2jSnWeRgVEC2A=
X-Received: by 2002:a67:485:: with SMTP id 127mr3551734vse.54.1550189613569;
 Thu, 14 Feb 2019 16:13:33 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Feb 2019 09:12:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
Message-ID: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.1
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,


Please pull UniPhier DT (64bit) updates for the v5.1 MW.

Thanks!




The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v5.1

for you to fetch changes up to 519904a42ff8c2ed23651f33c256d009c656a50b:

  arm64: dts: uniphier: sort labels in the same order as in dtsi
(2019-02-15 09:04:30 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v5.1

- Add PCI Express controller nodes

----------------------------------------------------------------
Kunihiko Hayashi (1):
      arm64: dts: uniphier: Add PCIe host controller and PHY nodes

Masahiro Yamada (1):
      arm64: dts: uniphier: sort labels in the same order as in dtsi

 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts |  4 +--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 47
++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    | 10 +++++---
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 47
++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 5 deletions(-)



-- 
Best Regards
Masahiro Yamada
