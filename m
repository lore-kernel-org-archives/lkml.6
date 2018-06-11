Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IdyzEx1IHlt1EQAAmS7hNA
	; Mon, 11 Jun 2018 10:00:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 76BC860792; Mon, 11 Jun 2018 10:00:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E32D260385;
	Mon, 11 Jun 2018 10:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E32D260385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeFKKAy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:00:54 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38668 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932263AbeFKKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:00:51 -0400
Received: by mail-ua0-f193.google.com with SMTP id 59-v6so13134136uas.5;
        Mon, 11 Jun 2018 03:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VMt0EOaNhKaFA/W1kimySARUj6R+hfkA9PGx0gMRyI=;
        b=dj6SdELqCr/xxPPWNVNkGldjUbrJ7ANc9hNmzre1x2xBOCxP4+KTFLhofv5A/HoY4B
         Wqo0A2jjKQlYdax7KTfRQxhC0xjLWgHASJy76EwvQgR4phfgXYkk4NO9S1d70Dx3hQcQ
         qTECjRXH8/h1yq+m2J2U3sUNkLrFSFkmq+DT7xQOd1uzPI8hlCVJk/uOwfw+SJfN5C9w
         h6PEWGrBsRgmPAkfr7YSfh6m1y3eE8Dzi0GQ7hFzYb2El66AW0l7StMb6A01s9FjwE2i
         hhFZQsJk297viGorp+QZXgvl4f8twLOKaMraP7j/svo0bsPvPQr0SWdzIzib+pQX/EyL
         VE+Q==
X-Gm-Message-State: APt69E1xJlN/tZhM0DPBFtkRnI4yRnGx5W+Kt43x9tYF44eJ4gNfpMIB
        6Y2h5jcNEvO+1KwIW8tr2kwSnD4b9IcBKV7RqGg=
X-Google-Smtp-Source: ADUXVKL6fmx2f7n1FFPWje45chs9udrQJ5MGVRb6KOZN2wbpLMM4BiAS39fOjgPCeZnm6nqGpu3grcaVPRPMm+cMark=
X-Received: by 2002:ab0:5922:: with SMTP id n31-v6mr11709374uad.114.1528711250899;
 Mon, 11 Jun 2018 03:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <1528187462-47093-1-git-send-email-michel.pollet@bp.renesas.com> <1528187462-47093-3-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1528187462-47093-3-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Jun 2018 12:00:39 +0200
Message-ID: <CAMuHMdWoE=+sEUtFdPKk4eBGtOn8f7bUPV-HLAvEETuqgVMeVw@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] dt-bindings: clock: renesas,r9a06g032-sysctrl: documentation
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Michel,

On Tue, Jun 5, 2018 at 10:36 AM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas R9A06G032 SYSCTRL node description.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
> @@ -0,0 +1,32 @@
> +* Renesas R9A06G032 SYSCTRL
> +
> +Required Properties:
> +
> +  - compatible: Must be:
> +    - "renesas,r9a06g032-sysctrl"
> +  - reg: Base address and length of the SYSCTRL IO block.
> +  - #clock-cells: Must be 1

(repeating myself) No clocks/clock-names for the external clock inputs?

"RZ/N1 has 3 clock sources, 1 reference clock inputs for RGMII, and 2
 reference clock outputs for RMII/MII."

The rest looks fine to me.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
