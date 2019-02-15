Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FCC222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfBOPUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:20:43 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:36528 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfBOPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:20:43 -0500
Received: by mail-qk1-f177.google.com with SMTP id o125so5894792qkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xbayz+nu1qpytE7iYRRc5A0uJlCr69al+zVCAWIlcsg=;
        b=i8kFVbg/0L/FzVzLO/qcDCbXGOes6HsZ74uxRMtZRwUSPozJ2LGv1lw8vjkAW+Jywh
         u1cTGyaGcPLPgtKVsjfyCOuLJkVC02gq1vKq+Hb+XSmYENBjr43meeEDTagl//nH3zZP
         nRrNbJTBL0xQw7OnJ8SM3cfGkXbM8tFJ6jlMg/xRYDswvVT+a4uswa/23GOYXE7wT5zP
         5JMG5/SuhWXYrhjw3875jiZys3jKmJFTsxB3H7/WN6/1gVDoonbtcJgrfi47xsxQM8cd
         9CNVdVbzkfGoEXIGrh6kTPrsY7Uw3ni9/XLTLZemo6+jpoOeWCnXiT8Z3oNUPR6NAPtv
         Qyxg==
X-Gm-Message-State: AHQUAuYKEepiJKEKJC5y8VH/SrgShkF3Z3hUjdWfD4SQmswcQwgTHMrt
        NdhHDCx7MyMyqlGCy8wUaG+t9lVUR+2wCLliAck=
X-Google-Smtp-Source: AHgI3IZgyHH0gTJEGsYgPUvQ5JAkl4lYxSQcy50CMJQ6iOKf7E7b2gGvYYMTCHGgyL2TgQRU9OW0BvY4+bp83dGR3uw=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7414886qkh.173.1550244042133;
 Fri, 15 Feb 2019 07:20:42 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
In-Reply-To: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 16:20:25 +0100
Message-ID: <CAK8P3a19FYb1UJtkL18x523_h_EE6J=VS4U8UyjMg==SRWSbMg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.1
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 1:13 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v5.1
>
> - Add PCI Express controller nodes
>

Pulled into arm/dt, thanks!

      Arnd
