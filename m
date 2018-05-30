Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeE3Uwl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:52:41 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36227 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbeE3Uwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:52:38 -0400
X-Google-Smtp-Source: ADUXVKL2jFRiTVcR0/Af62aWEYfdw2BvZuAXbKtXpaw6LYMWctnXc10d4qhvr9z+8QDujcwzUkMw8A==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next: manual merge of the regulator tree with the arm-soc tree
Date: Wed, 30 May 2018 22:52:46 +0200
Message-ID: <2022143.cJUAM8Fsdd@z50>
In-Reply-To: <20180530150711.2c7c1fe9@canb.auug.org.au>
References: <20180530150711.2c7c1fe9@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 7:07:11 AM CEST Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the regulator tree got a conflict in:
> 
>   arch/arm/mach-omap1/board-ams-delta.c
> 
> between commit:
> 
>   0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables")
> 
> from the arm-soc tree and commit:
> 
>   6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
> 
> from the regulator tree.
> 
> I fixed it up (see below - it may be better done) and can carry the fix
> as necessary. 

Hi Stephen,

Your fix looks pretty good to me, but anyway, I will test it and confirm in a 
day or two, as soon as I have access to the device.

Thanks,
Janusz
