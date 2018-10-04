Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54175C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2456520652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2456520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeJDWB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:01:58 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:46059 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:01:58 -0400
Received: by mail-qt1-f176.google.com with SMTP id l2-v6so10188300qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KCNOoo/KLA7POEP5bu5zw7rxdYhzEHfmQ+1R3OVLqo=;
        b=cLGPytSvvR/krnUKUmx5IDEIxoDmY7Pl0Izk80TIEp6l0apwEwmC8X499qr4c9p5XN
         BSBuP9cJofH0Lp4xvgJA6isloDImNUhNS4iu8dO4RhptAJp89hM6itSFQwDbWW+ulysZ
         ncXKjG/lM/psKXp19G9/9AVncOsFxB6yL3hje/K2r9YY1gz4UaVmwBDZ+i0XycfPBMZO
         /gtPrXUaEuU+69t2tzcM5WkPs+n2AfiTkudVm6GF4QzccJG6U/tcOc1nGlcMBaWPrCBt
         QGtPb24B6X4QNTBlizHFKMGMaj+b7Zp1v6DnQ6HL3T2IxsGIL9DcTIY17rsm1r4wtz/0
         gMNA==
X-Gm-Message-State: ABuFfojxh7PVDeDClAxZ6wPeGTsraXeOOydumWXTFx0/txjnqO7YaHF7
        96Py0MzomP61Vc+EHHBoGB8Ng43+Y1mOEBjpXsQ=
X-Google-Smtp-Source: ACcGV613o9T8cIyGzJIMgn/RVzYyEb1qacZsRBYKuH6QZh8LXpT5/wLJXDFbQBbSq3XHu40SxaWh7Mev7wvIKP44ATE=
X-Received: by 2002:aed:210e:: with SMTP id 14-v6mr5887611qtc.9.1538665696552;
 Thu, 04 Oct 2018 08:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAR90vJA6vyEP_6_zmW_CAoxrHQC8-iAK0ixn6+o2uQfkg@mail.gmail.com>
In-Reply-To: <CAK7LNAR90vJA6vyEP_6_zmW_CAoxrHQC8-iAK0ixn6+o2uQfkg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 17:07:59 +0200
Message-ID: <CAK8P3a13q8TYaWvc1iF+V+pOdSc-dLLfFJUTnAD+_dDmD3_x6g@mail.gmail.com>
Subject: Re: [GIT PULL v2] ARM: dts: uniphier: UniPhier DT updates for v4.20
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 2:54 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> UniPhier ARM SoC DT updates for v4.20
>
> - Add more clocks to NAND controller nodes
>
> - Add SPI controller nodes
>
> - Add SD controller nodes
>
> - Add USB 3.0 and its PHY nodes
>
> - Add PHY nodes for USB 2.0

Pulled into next/dt, thanks!

     Arnd
