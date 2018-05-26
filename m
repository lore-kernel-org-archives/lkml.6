Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032429AbeEZUvj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 16:51:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52901 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032377AbeEZUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 16:51:38 -0400
X-Google-Smtp-Source: AB8JxZpj88xHrTRJPnmqJ7Qi9pE+O5I1XEbnipmYnqoOVVd5DDmRcv3sYzEIxBJTcmFcbf3nggxtbg==
Date: Sat, 26 May 2018 11:45:42 -0700
From: Olof Johansson <olof@lixom.net>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: at91: DT for 4.18
Message-ID: <20180526184542.rjjqwfgwlibf7fpn@localhost>
References: <20180525225033.GA26989@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180525225033.GA26989@piout.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 12:50:33AM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> I'm a bit late for this very small PR, as I had to extend the expiration
> date for my GPG signature key.
> 
> Two small DT changes that have no functional impact.
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.18-dt
> 
> for you to fetch changes up to a642693882ce417683012a211ca9d6e65bae1dc4:
> 
>   ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier (2018-05-14 15:29:52 +0200)
> 
> ----------------------------------------------------------------
> AT91 DT for 4.18:
> 
>  - small DT improvements without functional changes
> 
> ----------------------------------------------------------------
> Dmitry Torokhov (1):
>       ARM: dts: at91: sama5d4ek: use canonical compatible for touchscreen
> 
> Hernán Gonzalez (1):
>       ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier

Merged, thanks.


-Olof
