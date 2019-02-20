Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75723C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1D0206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfBTPOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:14:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44974 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:14:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id d2so1866084qti.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 07:14:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQRnv0vrIQNIvYtV8Fbol+CbnW4W74tpn1ESfd8zZg8=;
        b=Qfhtqz/pTRslaxX6swWiUZrIpdxui3zUDW7lT+85me4qarbNBfzj6xn5YwNWpjt2Ct
         t4sQwnL/0N8FMB7EY1zzOIG7bOHyCO1Xx00Aox6zwzGegQCHBgMMnfZZBTRPZhzalNg0
         6gTonwHwReAGOMTFWNF+dwY4vwXp2PVguwgE3D1/Ot1bVijRQOZHC0ACb4p7lq7x05ED
         2RdgK1xS9ZLON63k869/nbOhkxGyYLrEROJv50AqAAHWiKqJpAtzqftkDSCzgmddNkIO
         D941iq1E2DBQ8BMtpu+LZVaFtnzBTf8oOVG0EYP7iUED3tgpAbh1zfuI7mofcJfemMmg
         x8PA==
X-Gm-Message-State: AHQUAuaJ9h3ZHS9gRO0geTGcpd0kWqm07TKE9IAyxVg1400Ackie+ByI
        g9HZJswPcMla7id2/MTwNq5X/1P1GrGt3pZ9vVd32Q==
X-Google-Smtp-Source: AHgI3Ibrg5qiTE3LPSw67wXgNpL6BlWxaKTfPW8KXgJ6fVxLNFUkBEAL72nEcEyqxVcwrQDRJgO4KYqFAU94GBZEv6o=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr25652734qvi.149.1550675680142;
 Wed, 20 Feb 2019 07:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20190219210953.1840-1-leoyang.li@nxp.com>
In-Reply-To: <20190219210953.1840-1-leoyang.li@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 16:14:22 +0100
Message-ID: <CAK8P3a2O+x_tRHWs9SNeEMkLhf-XpunifkNiEa76GCN2_NeanA@mail.gmail.com>
Subject: Re: [GIT PULL] updates to soc/fsl drivers for v5.1 take3
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:09 PM Li Yang <leoyang.li@nxp.com> wrote:
> The following changes since commit 3c0d64e867ed78a782a8a00d3b519396d9c5a2db:
>
>   soc: fsl: guts: reuse machine name from device tree (2019-01-11 16:08:43 -0600)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.1-3
>
> for you to fetch changes up to bd3bd3b36df725645036748e58a8c35c8d2cbf91:
>
>   soc: fsl: dpio: fix memory leak of a struct qbman on error exit path (2019-02-19 14:59:39 -0600)
>
> ----------------------------------------------------------------
> NXP/FSL SoC driver updates for v5.1 take3
>
> DPIO driver
> - fixed a use after free problem
> - fixed a memory leak on error path

Pulled into arm/drivers, thanks!

     Arnd
