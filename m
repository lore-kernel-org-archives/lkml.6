Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeEYMeJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:34:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39237 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEYMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:34:07 -0400
X-Google-Smtp-Source: AB8JxZqTzFo/OJtHpApsRw32m80aJ58BnRy2oDoHv7CMPdJp1ktlOnDQOqYjbNXLtm3u6OG2h5W6BQ==
Date: Fri, 25 May 2018 05:21:34 -0700
From: Olof Johansson <olof@lixom.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.18
Message-ID: <20180525122134.zigckjuxovguyc7a@localhost>
References: <CAK7LNATphrRyYvMXMMJz--UtfNk2BZLWHAp3XXpQLob5=5w2Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATphrRyYvMXMMJz--UtfNk2BZLWHAp3XXpQLob5=5w2Qg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 11:34:08AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Here are UniPhier DT (32bit) updates for the v4.18 merge window.
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
> tags/uniphier-dt-v4.18
> 
> for you to fetch changes up to 526f872b8492fbfb1a0f342e601bdc5ba322f16b:
> 
>   ARM: dts: uniphier: add syscon-phy-mode property to each ethernet
> node (2018-04-25 00:21:51 +0900)
> 
> ----------------------------------------------------------------
> UniPhier ARM SoC DT updates for v4.18
> 
> - add more properties to ethernet nodes
> 
> ----------------------------------------------------------------
> Kunihiko Hayashi (2):
>       ARM: dts: uniphier: add required clocks and resets to Pro4 ethernet node
>       ARM: dts: uniphier: add syscon-phy-mode property to each ethernet node

Hi,

Merged, but please spend a little more effort on the tag description (what are
these new properties giving you in functionality?)


-Olof
