Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F29C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA000206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbeLQQHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:07:53 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44862 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeLQQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:07:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id g68so8005159vsd.11;
        Mon, 17 Dec 2018 08:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEmt9UQL888+1tOfiArcrhyu/Q4JRD75G78ZJLqzNGI=;
        b=H9mZclj6vI6fsjOmgeeJVKuPRksmjaz+uCKILM6e8fGEM5NKVmOFdWFZRFgMZfhr/5
         ysXUpfAsCXsf22aQ/q6V9ZswreHHqF+axBbDZE8QC7DVOyUrOVCi/EqfZS6GDNz4pWf8
         8mDwLfLUME35IwKPRSg7kK8UsH08+M+Jq8ET9yfBRGFkGLL8AbdKfXydHbnH5Qy2lk8D
         Kh2CtEM8Cwh+l2EOf92ieNLnRetGBjp75awHzj7IsjgNY6/EiQVWDzckI0sm1p4uDC1D
         Dj1fR646qcUtdjkTUQEpJp1RHGuK5StA49HA4/ivkOkyoJC3qupHcMNs2TQieTDK3Lz6
         Fnww==
X-Gm-Message-State: AA+aEWZ2efUkSAGw8v5KGKeDblM0e+wRtPh7OlBnpg9gHie8wedOU+dN
        2tTx9Mxv8BjLMDY0e3Y3OQ/wrsWiMa9TT3+mkzg=
X-Google-Smtp-Source: AFSGD/U/4u48KlbYVfsqNL0eznJmiQ9JwTkJrUmR5mKJTVmjDJz9oIvTw+kx1rWHq5t3cdHxmypcYqKSXiHN3u9MfuU=
X-Received: by 2002:a67:c202:: with SMTP id i2mr6060818vsj.11.1545062869420;
 Mon, 17 Dec 2018 08:07:49 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-9-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-9-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:07:37 +0100
Message-ID: <CAMuHMdUW7Ji+amR93HoNJjTu_+HdMrtJOUMcZ-cQGBPaMnPeZw@mail.gmail.com>
Subject: Re: [PATCH 8/9] arm64: dts: renesas: r8a774c0: Add watchdog support
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
> Add watchdog support to the RZ/G2E (a.k.a. R8A774C0) SoC
> specific device tree.
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
