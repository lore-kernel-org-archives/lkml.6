Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF6C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063E7206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbeLQQGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:06:21 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46315 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeLQQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:06:20 -0500
Received: by mail-vs1-f67.google.com with SMTP id n10so7984793vso.13;
        Mon, 17 Dec 2018 08:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFXOXiq6mQ59zPBKpWaKSBAGfi5aX5ZW0Jrp6oBICs4=;
        b=X2mQUTdPUH9A5Tgk6wm9J02pQHbrLtf3+YJD1JT90lHM4tcPy8msxqDzdngZ9/Jjvq
         wvhyk3ANxp+UXZzkakKSZQD+4MWMqgrSyBlrzhKXvBYVa94L+1zPmPH7jXwBx5Ley7sO
         4Fn4uQL5awJbZJr5SErlir5W1dKbGnztPSu6aaRypq6P+Ddf5RFtOISYZwokbGG//cp4
         zSuiS5CJOhulzVi1bq8TbvuJ/0Q//7HiBp4IC+wqh1ZCdp/1FyJW4cqSMV4s6bWwz1qG
         kc+Sr4vpajsShPSgTBxA/SZ+e7ChXfoY2BZawbsAN5c+q9aZqaOnbGranGedQzHoc3x4
         5LKg==
X-Gm-Message-State: AA+aEWZ9u1TE3oXIW68TALAJBTDKByVWGuqHTvPwMP7E5nZG/44p8Ngr
        Zd7nBP8KQuhutH5P1e3nBA5lc5KiXU2A0RNwgT8=
X-Google-Smtp-Source: AFSGD/W9ZIjSQ7at6OCD/+slRap87o/EvbOjfK6JCB4X2hsa9DQ4ORv+iUvn8cZ3TEBPJGfALzTlRJuXXGq9VthQ5Bk=
X-Received: by 2002:a67:d119:: with SMTP id u25mr6241170vsi.63.1545062779322;
 Mon, 17 Dec 2018 08:06:19 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-5-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-5-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:06:06 +0100
Message-ID: <CAMuHMdWZm1ArZij+QPgG5qLk3AfRgegO-rD=H8YLW9jTZ6qR0Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] arm64: dts: renesas: r8a774c0: Add INTC-EX device node
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
> Add support for the Interrupt Controller for External Devices
> (INTC-EX) on RZ/G2E.
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
