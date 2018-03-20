Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbeCTPPj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:15:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20987 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeCTPPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:15:36 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w2KFFS7g031005
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AG47ELvTPUdoJJNxxL2YIHSJc4qSSqOiqvrrXWLXhXa1xl6VBRdeYwOAgLJfAeLgAzkeXvQgG7qgyeilhEM0p+GS+QQ=
MIME-Version: 1.0
In-Reply-To: <20180320024824.28902-1-suzuki.katsuhiro@socionext.com>
References: <20180320024824.28902-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Mar 2018 00:14:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+AwEjNpXP1PSrdkBH09OaePs+8f3eKiF=8MVm8fp4mQ@mail.gmail.com>
Message-ID: <CAK7LNAQ+AwEjNpXP1PSrdkBH09OaePs+8f3eKiF=8MVm8fp4mQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: uniphier: add syscon property for
 UniPhier sound system
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-20 11:48 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds syscon property for specifying soc-glue core into
> device-tree of LD11/LD20 SoC.
>
> Currently, soc-glue core is used for changing the state of S/PDIF
> signal output pin to signal output state or Hi-Z state.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Both applied.
Thanks.
