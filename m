Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBBC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A492206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbeLQQHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:07:32 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33385 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbeLQQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:07:31 -0500
Received: by mail-vk1-f195.google.com with SMTP id d201so2961841vka.0;
        Mon, 17 Dec 2018 08:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcEy5g5+pMfpGpqJHU0Swt65d2yFYeN2tB0w5Sx3elY=;
        b=b6rvFS/ycM1lQ4bjKUp3iW4SR8HlxA7kS0PLHCCoNeGRmHs2Z9GyJch/yW8MHC0D+L
         F1uPkmRMUMrHqeStxWTXYlr2MGGKqrm3OZylOmSFPoEHISjtS9V05h4T3lfrKQ97YDRz
         toQY1KafAJznNjiBhzMM94mjZZVP6KrgMnvMe8nLVe+s+e6yfvzK4mG82vDif1RJHKgW
         GnyvVDa8qC96rHQKPigeurIiFqcBBIMuiFi4jWloS2heLriqSlzBijclYBa/3C31NhEp
         MywfN/8doMC1Ulhxd77AzLbvxEBdfjidcdHGyjkGqjiUo1/10UeI7XYAkX/OiZFXnh6G
         FbTg==
X-Gm-Message-State: AA+aEWbMEAAgXL+NQ8CtVyHtHm6frSBEeGC2bNcmCarmyKdfYEgdaZT9
        uCGpG12SRVCfXqEYaiZl3VnT6bVFmL3m1l6p8KM=
X-Google-Smtp-Source: AFSGD/W7DHvx/bS9cKmv/wP/gcV43Quk1pGmdSNjVF9f7sTp7JCKhjBHAQ+2vyt/AggisNiNUu3Ugv6ZKGUqos7/2CU=
X-Received: by 2002:a1f:298e:: with SMTP id p136mr3861012vkp.40.1545062850356;
 Mon, 17 Dec 2018 08:07:30 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-8-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-8-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:07:18 +0100
Message-ID: <CAMuHMdWHTPTaNr56Xf5CSFXRt99BmUsh6o0DJAF2TVO+mQEN0g@mail.gmail.com>
Subject: Re: [PATCH 7/9] arm64: dts: renesas: r8a774c0: Add Ethernet AVB node
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
> This patch adds the SoC specific part of the Ethernet AVB
> device tree node.
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
