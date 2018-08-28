Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F815C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85BA20658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85BA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeH1NPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:15:07 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45754 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeH1NPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:15:06 -0400
Received: by mail-ua1-f66.google.com with SMTP id q7-v6so543583uam.12;
        Tue, 28 Aug 2018 02:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4jfFKrjFAvM7OjumMhR+2oWxwP7fOssLvPEywy2tQ4=;
        b=dnZloe2Bbq+A1J4RCARH+K79HEP5u1JguXPjLgAvMpeHCuu4wy+UqCwSRVQ33uwdup
         qlLl9+JhwbNYfYjwMze9NUkthIJdBsVtPeCEtlcW8BkXAzEs7/ZGuJ+x9DC/H+UjCa+B
         lObKuoIeXdLSJFBnlSVl8klgJRN3mZL0++W8/MukgXeGELrY+ajVJuc9+jWutqSWV3px
         6QMnWx+ZJ4Xlb0EqgDnS3aH108RDjojZIytgo4uZ/AyXQVNlSj4fIhvdMyk3Jl0NRJCC
         42sCFcQ6BdDauwLrJYi5KOa2IUVJ5GDw5uJZqPn9XoH5B711wf1rJr2fsnOrFhX140yg
         RMiA==
X-Gm-Message-State: APzg51CAV/EvnEfNlrZw099DqKazc2WNhCoNvr2AcHACr9bjGqtwrdiK
        SP8MgRfxGBMCIoEpe6tiQwEs5TxJC35tvsh8CZI=
X-Google-Smtp-Source: ANB0VdbW++DOtiiQbNYOSzc0E3UI5QVdYq6tn2S8xqOXnqvfaitF8CL0+R88jlUJrshjaCcPUZHLttyNyXpzzXlofIA=
X-Received: by 2002:ab0:a85:: with SMTP id d5-v6mr408727uak.130.1535448260981;
 Tue, 28 Aug 2018 02:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com> <20180821220233.9202-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180821220233.9202-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Aug 2018 11:24:09 +0200
Message-ID: <CAMuHMdWcrpzit40X_z_hJrCSgupnnucPF0nciPiAiJP8EOX+TA@mail.gmail.com>
Subject: Re: [PATCH 01/11] clk: renesas: use SPDX identifier for Renesas drivers
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Aug 22, 2018 at 12:02 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>  drivers/clk/renesas/clk-div6.c            | 5 +----
>  drivers/clk/renesas/r8a7795-cpg-mssr.c    | 5 +----
>  drivers/clk/renesas/r8a7796-cpg-mssr.c    | 5 +----
>  drivers/clk/renesas/r8a77995-cpg-mssr.c   | 5 +----
>  drivers/clk/renesas/rcar-gen3-cpg.c       | 5 +----
>  drivers/clk/renesas/rcar-usb2-clock-sel.c | 5 +----
>  drivers/clk/renesas/renesas-cpg-mssr.c    | 5 +----
>  drivers/clk/renesas/renesas-cpg-mssr.h    | 5 +----
>  8 files changed, 8 insertions(+), 32 deletions(-)

Any specific reason you skipped all other files in that directory?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
