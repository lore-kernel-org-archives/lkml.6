Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeA3VAt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:00:49 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:60221 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeA3VAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:00:47 -0500
Subject: Re: [PATCH v2 00/10] Remove empty help texts from Kconfig files
To: Ulf Magnusson <ulfalizer@gmail.com>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        mcgrof@kernel.org
References: <20180130192349.8420-1-ulfalizer@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9cbe668e-fe6b-d525-176d-a1e07541f789@infradead.org>
Date: Tue, 30 Jan 2018 13:00:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180130192349.8420-1-ulfalizer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 11:22 AM, Ulf Magnusson wrote:
> Empty help texts are probably either a typo, a Kconfig misunderstanding, or
> some kind of half-committing to adding a help text (in which case a TODO
> comment would be clearer, if the help text really can't be added right away).
> Best to flag them, IMO.
> 
> Changes since v1:
> 
> Forgot to send the cover letter to linux-kbuild.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Ulf Magnusson (10):
>   net/sched: kconfig: Remove empty help texts
>   video: fbdev: kconfig: Remove empty help text
>   mmc: kconfig: Remove empty help text
>   Staging: rtl8192u: kconfig: Remove empty help text
>   Staging: rtl8192e: kconfig: Remove empty help text
>   lib/Kconfig.debug: Remove empty help text
>   MIPS: BCM63XX: kconfig: Remove empty help text
>   MIPS: kconfig: Remove empty help text
>   arm: vt8500: kconfig: Remove empty help text
>   nios2: kconfig: Remove empty help text
> 
>  arch/arm/mach-vt8500/Kconfig              | 1 -
>  arch/mips/Kconfig                         | 1 -
>  arch/mips/bcm63xx/boards/Kconfig          | 1 -
>  arch/nios2/Kconfig                        | 1 -
>  drivers/mmc/host/Kconfig                  | 1 -
>  drivers/staging/rtl8192e/rtl8192e/Kconfig | 1 -
>  drivers/staging/rtl8192u/Kconfig          | 1 -
>  drivers/video/fbdev/Kconfig               | 1 -
>  lib/Kconfig.debug                         | 1 -
>  net/sched/Kconfig                         | 3 ---
>  10 files changed, 12 deletions(-)
> 


-- 
~Randy
