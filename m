Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E1EC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EDE2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfBTIFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:05:15 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38443 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfBTIFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:05:14 -0500
Received: by mail-ua1-f67.google.com with SMTP id p9so7907266uaa.5;
        Wed, 20 Feb 2019 00:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCfikV/o5bpgXE4j02lG18Da4dSxFHCIWOEUQU7wWxI=;
        b=aDPjJwQj8pZuEGBAZ59Wi4LiaknZb6ALQYAL2yindZx/8+KHaegAUKyVFTxwh1XVLa
         kKh8QPaIWnNfDV2DsPnWGIrSgoLpvrvlsL3/APQhaf7TlFrfKwq1BaWDjUraCRs49DxJ
         3pt8hWBzaULAE6sZPwhpX3k14ojRdlKsEylnhVTR2vhgYMsUz+dJyYyXnkeS1y+zXBDL
         WztytIZgac3Yx9oL3Haj9eZMcXhZv1PMP7Lr3OVoIwqcyRP9s+hLmzU+vA8fLQYTPk1N
         0CSbzAzGU/N0+L1f3ieQ65Pc1UmzNdXFHQ6yiZa2Z9xPbkgX7KTb6bTWnH8bkVTtRQy1
         W8pA==
X-Gm-Message-State: AHQUAuak/eI60B8orivflf2fvpkLonlt1ritSOAL+QazXOYDawr6MtO0
        3XmuYgggYFfdgRdwHvawGMB1+pGpeKx7xY5bucA=
X-Google-Smtp-Source: AHgI3IbqE/X+inhkskZAFlpeGlhOvjrq6UA5nstek35iIri9KqMtrPjax6JMPKg5ZOyWCE/m7CM4d2HW6lZ2bOSjego=
X-Received: by 2002:ab0:7191:: with SMTP id l17mr17073428uao.28.1550649913671;
 Wed, 20 Feb 2019 00:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20190220052435.20508-1-jiada_wang@mentor.com> <20190220052435.20508-3-jiada_wang@mentor.com>
In-Reply-To: <20190220052435.20508-3-jiada_wang@mentor.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Feb 2019 09:05:02 +0100
Message-ID: <CAMuHMdVVo7LkYu6taKBndssmHMHS5U=nw+FnBoUXuF-r19Yuiw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: renesas: r8a7796: use extended audio
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
> need to be used
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
