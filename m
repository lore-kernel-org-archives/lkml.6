Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82092C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB4A206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbeLQQGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:06:38 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34955 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbeLQQGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:06:38 -0500
Received: by mail-ua1-f66.google.com with SMTP id d2so4612501ual.2;
        Mon, 17 Dec 2018 08:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yx9U6uBmbUqQRJgMPIcGKBl81VSv/ZeqLwuAS49Vzjs=;
        b=bAUXRbt7sQ4w/xM43zNgxHSZyankijmu3Rw34qZ7DqMQk0UwsguwxNWSWywdheqBZf
         lp8lFCCUjWLoY4KsggyqNlxvj2KVLaYel49xfYX1xvD6bToz5bYuerSZCr45/OYBpUCi
         clavPoo2NUc8Ikttagevj1Hrr/BrVqCDeuv5foixUL+QG5MdgUMXokJXZ3V+MYVj+Kr6
         Aiv4CQoeYVCUr2tj+VdZ5/UNB6HQPEaVQ5E9/ccVBgu0KWr02awsHl6n0LIsJoNs+8Xp
         e0tqUE1cEoKZVZuWc9zPnA3/3k1TojtCwEixgqgqNmzwSr1Fc7Gx2VDFpuvp8pTPrNoK
         wjww==
X-Gm-Message-State: AA+aEWZZLFzsad9y51oth7tx26vOkwPJJGRocyXwgIr/l4gUiw49Tcd0
        5DraE9nbziDnGTqPtxUUanPFPP//84NNdFh0Q14=
X-Google-Smtp-Source: AFSGD/Xj2ivgP7DwHCz7zHpR+yHm/SKA6LNuWP7IpFAcmenw5yJG7nB8okGcJXA63l2Oql2low4NMA7D6LbWEHqk4lg=
X-Received: by 2002:ab0:1393:: with SMTP id m19mr6240293uae.75.1545062795762;
 Mon, 17 Dec 2018 08:06:35 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-6-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-6-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:06:23 +0100
Message-ID: <CAMuHMdU9=o1pdvKj6GUeOXsB0XOts0X7E-cFBvOCf05q-R10eA@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: renesas: r8a774c0: Add PFC support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:10 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add PFC support to the RZ/G2E (a.k.a. r8a774c0) SoC specific
> device tree.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
