Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B2DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122B221B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfBOQoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:44:21 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:44744 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387475AbfBOQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:44:21 -0500
Received: by mail-qt1-f174.google.com with SMTP id n32so11510812qte.11;
        Fri, 15 Feb 2019 08:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q60BJ1d1y8oEzvaIodbA/xifyUjxKZuIgEUeDDLJwsQ=;
        b=Zsk7tOF0LAu6HCZv//FjBwvk1RvL6P412TxNQQKGBDjLnqhc0WKQgYjFbzqUgXG9H0
         Ok1hOuAofdjQ86VNSH8c9Emh3EOD9dhtS+Z8M6lw+jqVOr2QEoEFCvjdKkaOMTFxrud+
         jeino2jM2KLl6DW3Ya3Ocp+O9I2Z0gokLCq2V2ek4AlexfOarUxgEyI8Xo1XUnYj9Vcl
         rGnSPAoAnIyxthdB1pLd/CJfc/Sr5ecjk62klcQDzNoAlVEUiTMB9uKPDtxu41S0qxJk
         7u/ENjaRbF6U1OQjvnQCYCmpXi7tGlAHOlTTeyVkM3gTFmPZixJVEwZ0MoJYKa+GWUVb
         nTZA==
X-Gm-Message-State: AHQUAuZ3NGhcWsJJSdrx9D7mlJAvG8pn1I22OENRPcf+w6NMVliVu3zV
        /NIOZkrN4SgDJwRUceK18bsEKgy7f+e4M7Q9GkU=
X-Google-Smtp-Source: AHgI3IZtGhsy5acwyASJwIrXMKlBgiMBU09kcBOCncX+EYallZwjBySqe47JuVeV+dJ4jGvLqtJ9XjThsI92uBt9SLU=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr7798585qve.180.1550249060051;
 Fri, 15 Feb 2019 08:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20190211195448.19983-1-krzk@kernel.org>
In-Reply-To: <20190211195448.19983-1-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 17:44:03 +0100
Message-ID: <CAK8P3a1U19+EjyuZCESj0zj4CRTUpGKyMP6_rk9QV--FdBGdcQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: samsung: mach/soc for v5.1
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 8:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung mach/soc changes for v5.1
>
> Two fixes: one for handling timeout while booting secondary CPU of
> Exynos and second for S3C24xx DVS notifier.


Pulled into arm/soc, thanks!

    Arnd
