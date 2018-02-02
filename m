Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeBBUzS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:55:18 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36236 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeBBUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:55:10 -0500
X-Google-Smtp-Source: AH8x22415gWTNhnpCIZC3ewBiQ7sTJCTSViKNbHIBdaZz0Q28ZawfS235yVFV3RglcsuBsyLEB9B34XEz4ybGjaLxiQ=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1802021523390.1842@knanqh.ubzr>
References: <20180202161550.2106846-1-arnd@arndb.de> <20180202162104.2300532-7-arnd@arndb.de>
 <nycvar.YSQ.7.76.1802021336090.1842@knanqh.ubzr> <CAK8P3a3dgFjXP3wub+J5-_67MS2Mm_twktD=cyoY2pPro+AWzQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1802021523390.1842@knanqh.ubzr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 21:55:09 +0100
X-Google-Sender-Auth: oqvbV_efjCIIp9rf8QogNpgtU4M
Message-ID: <CAK8P3a3R79Hd7QWdskfRscA1UndQGPaLP3rcKdykEOqPr1ja=Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] Kbuild: lto: pass -m32/-m64 to to LDFINAL
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 9:38 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 2 Feb 2018, Arnd Bergmann wrote:
>
>> Do you have a git tree with other changes for LTO on ARM? I'd
>> like to try that as well.
>
> I currently have only 2 other patches.
>
> You need commit 75fea300d73a that just hit mainline (you may cherry-pick
> it easily if necessary).

Ok, I apparently have that already by basing on today's linux-next.

> Then the following:
>
> ----- >8
> Subject: [PATCH] HACK: enable LTO on ARM
>
> Without the ${KBUILD_VMLINUX_LIBS} move the build fails with missing
> memcpy all over the place. Didn't figure it out yet.

Added that now as well, thanks! I'll see what comes out of it. Have you
tried arm64 already? I suppose I could do the same change there and
see what happens.

      Arnd
