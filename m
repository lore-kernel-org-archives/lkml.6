Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeEYMeN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:34:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40832 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933196AbeEYMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:34:09 -0400
X-Google-Smtp-Source: ADUXVKICPMxC9pwsWzXRYuIsftI394ozqYOQLHmLFEL5Lg0FQXJn5c2E7Fw3+nOOfn6/ISn7QkNGgg==
Date: Fri, 25 May 2018 05:22:15 -0700
From: Olof Johansson <olof@lixom.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v4.18
Message-ID: <20180525122215.ylx35lkdcbr5qmkw@localhost>
References: <CAK7LNASUq_9osPdzbiMCbYzeqc=W3Yv7tB63V+5gXqcZ9QBtYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASUq_9osPdzbiMCbYzeqc=W3Yv7tB63V+5gXqcZ9QBtYA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 11:38:39AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are UniPhier DT (64bit) updates for the v4.18 merge window.
> Please pull!
> 
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> tags/uniphier-dt64-v4.18
> 
> for you to fetch changes up to b076ff8bddfba793d49bca14feb49a0e84f41843:
> 
>   arm64: dts: uniphier: add syscon-phy-mode property to each ethernet
> node (2018-04-25 00:21:14 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v4.18
> 
> - add more properties to ethernet nodes
> 
> ----------------------------------------------------------------
> Kunihiko Hayashi (2):
>       arm64: dts: uniphier: add clock-names and reset-names to ethernet node
>       arm64: dts: uniphier: add syscon-phy-mode property to each ethernet node

Merged, same comment as for the 32-bit pull request. Thanks!


-Olof
