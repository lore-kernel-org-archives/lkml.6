Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeCFBes (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 20:34:48 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:62899 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeCFBeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 20:34:46 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w261YQQd011325
X-Nifty-SrcIP: [209.85.213.46]
X-Google-Smtp-Source: AG47ELsQdl/rujHsJ3uneenGDoSRJ/HK5rgcv33Enr1t69ghODYyw3qvIJxF99c3Vd/E/Yeg3DSZq7vecX3cXlij5Kg=
MIME-Version: 1.0
In-Reply-To: <20180228093247.29648-1-suzuki.katsuhiro@socionext.com>
References: <20180228093247.29648-1-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Mar 2018 10:33:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASTRCy=MOVVAJhobnZ4SLvdWoy+wR=tovb-bLJLRhxs9Q@mail.gmail.com>
Message-ID: <CAK7LNASTRCy=MOVVAJhobnZ4SLvdWoy+wR=tovb-bLJLRhxs9Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: uniphier: add fixed regulators for audio codec
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

2018-02-28 18:32 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds regulators that have fixed voltage for audio codec
> on UniPhier LD11/20 Global boards. This patch fixes warnings about
> TAS57xx audio codec such as "tas571x 0-001b: 0-001b supply AVDD
> not found, using dummy regulator".
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

Applied to linux-uniphier.  Thanks!



-- 
Best Regards
Masahiro Yamada
