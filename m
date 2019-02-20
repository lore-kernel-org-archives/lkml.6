Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448CDC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201D82146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfBTIFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:05:01 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46928 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTIFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:05:01 -0500
Received: by mail-ua1-f68.google.com with SMTP id j8so7889338uae.13;
        Wed, 20 Feb 2019 00:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAXWCHdAsewZ7l/K1BfcQRuKtTT0dLwjlewBz8+cQH8=;
        b=C+u8oABb+gbVrA/4G6dkexI+iQNSfOsngyFeNJBLW37W1MwxJi4n3pMYCiyPZvz/9e
         LhOxXEyPsR12TwyoYclzqyDjaNm5Yv/Asf9fkRxOK2HEeAUThbfEuN2BMOVFOgmfP1+u
         Ob1GJqnYwilExJHcuw8mbUsZRiSh1+3D8uszxo8XErTU67kW/dnZ4DxsYuw4fTJXcF3J
         ceri0ftGt5XW/v9O2YK6P8Ow9mwIHYpF3tE7x4tlOU5GkhqJS0cztwyXT8WDMD3RDZd0
         7zwRxDztCLG2T5uYOxETB3rJ2p5OCn7asbeadPcjKrGkDa3B4vcgOHAZDIIBegNtRkuL
         dtpg==
X-Gm-Message-State: AHQUAuYFP1Qdz8JKwu34VHmy2Lhb4YqbxJ9S3bKvqzYIzYW20SUgI2pD
        Uc+fUHRlD5KtUfYYUqFTXE+231nx2x+WgtSwrdk=
X-Google-Smtp-Source: AHgI3Ia+oXYBa+u3ZcawHlKx//EEgh/TBTsg5MSrY+kJgKVgRsqCXQtMu+pFryNhewYMyQIb8oLdHHa2pJ+v8nffH/U=
X-Received: by 2002:a9f:30dc:: with SMTP id k28mr10105441uab.75.1550649900487;
 Wed, 20 Feb 2019 00:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20190220052435.20508-1-jiada_wang@mentor.com> <20190220052435.20508-2-jiada_wang@mentor.com>
In-Reply-To: <20190220052435.20508-2-jiada_wang@mentor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Feb 2019 09:04:48 +0100
Message-ID: <CAMuHMdX7P_qeSSfWeUV1skkkD5BTCaZO8ys9FhdtjPZ4mP_UJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: renesas: r8a7795: use extended audio
 dmac register
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 6:25 AM Jiada Wang <jiada_wang@mentor.com> wrote:
> Basic audio dmac register only supports busif from 0 to 3,
> in order to use busif4 ~ busif7, extended audio dmac register
> need to be used.
>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
but please consider my comments to the cover letter.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
