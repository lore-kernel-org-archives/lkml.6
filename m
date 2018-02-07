Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbeBGPjq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:39:46 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:28299 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeBGPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:39:44 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w17FdQi6012607
X-Nifty-SrcIP: [209.85.217.182]
X-Google-Smtp-Source: AH8x226y0Hx3BlHsTr+0OTlEjIj+dcTq2O4qGzrR8rbOfqz1FwDdtXEFdQqzzzDSUc+LLwOG87n79jDQIP0rq0ZTMaM=
MIME-Version: 1.0
In-Reply-To: <1517643898-2801-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1517643898-2801-1-git-send-email-Julia.Lawall@lip6.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Feb 2018 00:38:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNBYVK+Fjyx_31KFCx67Y2XxuCxTw9aSPrkWB+9h4fNg@mail.gmail.com>
Message-ID: <CAK7LNARNBYVK+Fjyx_31KFCx67Y2XxuCxTw9aSPrkWB+9h4fNg@mail.gmail.com>
Subject: Re: [PATCH] coccinelle: deref_null: avoid useless computation
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-03 16:44 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> The effect of the rules ifm1, pr11, and pr12 is only used in the final rule,
> which depends on context && !org && !report.  Thus these rules should only
> be performed in those circumstances.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---

Applied to linux-kbuild/kbuild.  Thanks!


-- 
Best Regards
Masahiro Yamada
