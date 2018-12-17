Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1007AC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD207206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbeLQQFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:05:01 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43645 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeLQQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:05:00 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so7989568vsc.10;
        Mon, 17 Dec 2018 08:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twPow9HV0yQjfnqx1aeih1PfFkyxF0lD0GGQwcMjInM=;
        b=gf0Rk/embCb4xpcJTNefAzMk61oo7uiRg44/u01iCr0CCLEL29oYx53HgJeQ3z5hud
         fttMktvoYUpbQpQKO+zh4yjsd+qgjcASXCvyS17nnRJ064q/ZJuC5DS+oKoY8r64SxnQ
         YGzM6NDEb597jg7MS8sVgL29quF2OHm3kBjmcHTX90XFJgD3lGnaYqkrpagBoUsmGpMZ
         aVGKPD/l/v4dT4AavNJWl1/jASd1e5GJmWvdLYuV63sEGij/tnXN5Ar6oryB8sboHeAU
         s++O8t4TDF9w87GvIVoWbyWowHzVsD0bnmor+p8f8WZ4r+XPitU8Wx9uji5/xooTPb09
         bI8Q==
X-Gm-Message-State: AA+aEWb15teqi40ggTMNy0pQTiJ18ttu5IT/2cBZ7g7l7WQ5SwmMc3Rs
        tbg/Z5TBcVjD8jxfGkl9uiavwBBp1Lk6GJECABE=
X-Google-Smtp-Source: AFSGD/Wr2xI3v4m7ZFIUq378zBDVYbHooIxtB8py0dKxvNt06h0w6hAY3oC9HOy2Zy5mIAhe6RTj8Dd+drFciPJW2Mc=
X-Received: by 2002:a67:f43:: with SMTP id 64mr6652737vsp.166.1545062699025;
 Mon, 17 Dec 2018 08:04:59 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-3-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:04:46 +0100
Message-ID: <CAMuHMdWVXupXM6fZcHcf-DcWB+bEziKFOT7dXrCQDXEspTW4HA@mail.gmail.com>
Subject: Re: [PATCH 2/9] arm64: dts: renesas: r8a774c0: Add SYS-DMAC
 controller nodes
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
> Add sys-dmac[012] device nodes for the RZ/G2E SoC (a.k.a. r8a774c0).
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
