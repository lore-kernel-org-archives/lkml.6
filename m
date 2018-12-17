Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85799C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522A8206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbeLQQHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:07:05 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45509 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeLQQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:07:05 -0500
Received: by mail-vs1-f68.google.com with SMTP id x28so381163vsh.12;
        Mon, 17 Dec 2018 08:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2QSGY8LsKFCvC0d/zMzU5jcSNd7jQZSPNcxSPpXTRQ=;
        b=E6eGTCE9p+U9uwGqBC5SmeN7Zf5KnCt94SgqzF4shF4LfeXYKrzh+fjx6yutiARxNb
         8gaI+6SDFORrZz11jEMfxtXGseshXeBCz6AND0SSdlDLqCUwc8eoHNbnsuDpvJmwFQRq
         GjGgHNoACw6DaIO2AIMMpf2JF4IITu3RWfFLxUArZz7t/FzbdnF8osS3wrAKNUmQm3q3
         rZ8Prj+YnGkDSM+UYiBSTKNuXEuyviyp9o21U4zGlvuEJqR3LDry1EzLwypd2B9OB1Dn
         /AvsBMeOiNoK55vtsB3MVxMxpzPpsZBuk8oNQBi+cp5o44wNtcpIwxLK1/QJcr4Frb28
         2smQ==
X-Gm-Message-State: AA+aEWYELyInQEcMLf5BmkzyLx/5DylghUJrl6wGG6nFB6qcbPNIycIX
        gkDU+z8j8OkUOP99K/H0HlEkT+ONWGYIrf8kNUCmQhq2qyQ=
X-Google-Smtp-Source: AFSGD/X+Y9yJEux0d1taAclmPOoltZEfqhy1P+3961mtE6M86btN5PkoTnV7T+EN+ZuY52XJ8p/y4pt7vA1p6I4f4Iw=
X-Received: by 2002:a67:d119:: with SMTP id u25mr6242667vsi.63.1545062823512;
 Mon, 17 Dec 2018 08:07:03 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-7-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-7-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:06:51 +0100
Message-ID: <CAMuHMdX3j_pNFdCC4_uA74Cdb-bT+8eF8d5ccHBSq_VOJ43i=A@mail.gmail.com>
Subject: Re: [PATCH 6/9] arm64: dts: renesas: r8a774c0: Add GPIO device nodes
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
> Add GPIO device nodes to the DT of the r8a774c0 SoC.
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
