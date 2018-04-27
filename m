Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeD0E2V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 00:28:21 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:53433 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeD0E2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 00:28:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w3R4SGNn010643
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AB8JxZoqi7hvR5l4DLFfnPkfqcc2ZlnSy0+5YvIlUQRnsSGlNDsDsfWOMoUbnaG2fFn8YBToRxgUKHudhTTHcjPoOCM=
MIME-Version: 1.0
In-Reply-To: <1524803118-32570-1-git-send-email-yamada.masahiro@socionext.com>
References: <1524803118-32570-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 27 Apr 2018 13:27:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6gc1CwvzQTUu+eC9vPO4R1tKtoEzOT-1anHAPEt=cmg@mail.gmail.com>
Message-ID: <CAK7LNAS6gc1CwvzQTUu+eC9vPO4R1tKtoEzOT-1anHAPEt=cmg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: stabilize ethernet of LD20
 reference boar
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-27 13:25 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Currently, the ethernet RGMII mode on the LD20 reference board is
> unstable.
>
> The default drive-strength of ethernet TX pins is too strong because
> there is no dumping resistor on the TX lines on the board.
>
> Weaken the drive-strength to make the ethernet more stable.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


To myself:

Fix the typo in the subject

  boar  ->  board




-- 
Best Regards
Masahiro Yamada
