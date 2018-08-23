Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08091C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A52147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3A52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbeHWVsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 17:48:02 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43129 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHWVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 17:48:02 -0400
Received: by mail-ua1-f66.google.com with SMTP id f4-v6so3794328uao.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNiSD5QNORsj1moYPUZ4hTaCCuj3/F5z/FW4H1YlxvA=;
        b=lVro/egp9FmE5QGkk044H6fiQE5Lr788sJLWkgouxUr48DsHoO6abZ6vE+O/Fccjo9
         bDHChsvIW5DZjiXQF3xUq3oRcv5Ra8jLeogORIP1CbJxpvQ+uIp2zMkQv4qsLT01RHMh
         2R5PAjzZ63cFoM9Kg3qm27SM33tIZQAEcmBI3Pgn2KevKe5XAJU0XhgC4X2uKD4bXPIr
         WNQy/cM/3RaHEU8jOu3axAs1YbEtdZvjJkFfdwGdidTH+mlzWWjcMbMO7BG4qjoP9NGo
         aMVrrVS9fshz+qhbLzM44XUizrCPCuSDWR6Y+tOHac7lWs7nmTolLzO8nTv/UPIhFwCq
         rnhA==
X-Gm-Message-State: AOUpUlHmU04iZNPdmrr7CUKoy4Twplj2L7O2DW8ooEnsTulsNGSATeOv
        Zy0gZ3gPhV7DzbyWhjOHMGJ9MiGGDSQ7AbbiH1PQkw==
X-Google-Smtp-Source: AA+uWPzBV04dEjam/QG9o6J4jV+/IJ7VIaNUu8c6T3a0DPZJxC6XM5+o7KpQpfXE6L5Van9Ec8oNpoCN4OjbYltBV/c=
X-Received: by 2002:ab0:48a4:: with SMTP id x33-v6mr40209933uac.138.1535048228386;
 Thu, 23 Aug 2018 11:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180823174359.GA13033@linux.vnet.ibm.com>
In-Reply-To: <20180823174359.GA13033@linux.vnet.ibm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Aug 2018 20:16:55 +0200
Message-ID: <CAMuHMdW4utnKZrEjAtWCUyfUj7qp1EXTj5B+fCryE23GHMLtnA@mail.gmail.com>
Subject: Re: Kernel-only deployments?
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Aug 23, 2018 at 7:44 PM Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> Does anyone do kernel-only deployments, for example, setting up an
> embedded device having a Linux kernel and absolutely no userspace
> whatsoever?

Isn't that basically the original porting guide from VxWorks to Linux?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
