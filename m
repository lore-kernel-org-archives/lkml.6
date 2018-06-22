Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC40024294
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC40024294
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeFVNWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:22:02 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37470 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeFVNV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:21:59 -0400
Received: by mail-vk0-f65.google.com with SMTP id w8-v6so3895693vkh.4;
        Fri, 22 Jun 2018 06:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AY91DYJ5newMHEXGSTRy2JU6WaaXgsRpphSctV5iJ6k=;
        b=Boohnx/gR3vkCoTWVnExbe3KXCqntIBks28H/uw5jCbLFFt2/YKRC//R3B3mpBXuqQ
         nDyNITChH2lsBH5DTeynO+EKxmgF7ONbprXkqBPdcZSaR/6LIN44i0BYZGIgfnwe9x2i
         zNu3wyZU+mjHyZNfc3KhzUyVunl4j3DyHDMN5f5b0JVkzujVShC1DgKMuK4N3PRMY2NS
         l1JVXYlP5HQ9AGZRLm6KYJZ0UIKXdIa7Q+Tj6LJr4W3bmGdqR7fIqn5LhIQr9K/jCYUr
         WMiaSe5RpyCj1QTzWdQtCYYrveGMmBZl19a68c8jVQIQ4uIq19PtZjecg+dXFM1QaQgB
         4ZpQ==
X-Gm-Message-State: APt69E24krfi4J9LbItJBEujAdkc1ZV/gZpYbVv5QfS97YdzMkEBlDxi
        smxggRwdAIBj6KPylcjzJbehkPxPD+gkb9u+CRk=
X-Google-Smtp-Source: ADUXVKJbrUb0Xrpkmt1jL3RccwShs8InZHZC3d/rV2wZOZizhfcDL7WuvnDTJVqJk+GiZ169T0Eg0vvn+wGqNP8GFFs=
X-Received: by 2002:a1f:644:: with SMTP id 65-v6mr932714vkg.159.1529673718320;
 Fri, 22 Jun 2018 06:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com> <1528973829-25493-2-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1528973829-25493-2-git-send-email-michel.pollet@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 15:21:47 +0200
Message-ID: <CAMuHMdUr+PT540D+MK5kuAsZW+4MRu5KE+kid6QZkMacRjAsXw@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] dt-bindings: Add the r9a06g032-sysctrl.h file
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 1:02 PM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the constants necessary to use the renesas,r9a06g032-sysctrl node.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, queuing in clk-renesas-for-v4.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
