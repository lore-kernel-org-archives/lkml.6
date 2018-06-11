Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /7cYJGFAHluAawAAmS7hNA
	; Mon, 11 Jun 2018 09:26:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7855C607A4; Mon, 11 Jun 2018 09:26:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 08D2B600D0;
	Mon, 11 Jun 2018 09:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08D2B600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeFKJ0x (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:26:53 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45211 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeFKJ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:26:51 -0400
Received: by mail-ua0-f196.google.com with SMTP id k14-v6so13034213uao.12;
        Mon, 11 Jun 2018 02:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oj1lNEGmFQv6nYkbkVYGbgV+1oJENp5Jw7x+wofn6Ic=;
        b=V2+X6TSgyRXCFUhSiM8yvFIfnOEkCNo674OlohdtHvtBMA+oZ+0A9y+4Nfa07pLCaK
         8U6x18Doa91fKIAxZ/YV+ADwA0WRKWiJZpM2O4H14fcE+ZCRtA48LJ7r0FoFhBDX33f/
         vdcqXbhg7/PV6OmU/xNEiICv8p9gJSJQUrtt3sblTQhqZQEIEk0Iea1yesAQJEoYy8lv
         tonip2zCI3N4UdHBFV1V2njSHd8+z4bkIb9CpOsJjNEsC9HzqWrgxWtlwYk6bq3tHD4f
         H7ZjNzahSIxl4PWprlyfRZwl1fWUzcPBAQ2ZV4cta8FOwtfjuoORogk8gGsHpI33vKb1
         NwXg==
X-Gm-Message-State: APt69E1QHL4CHiQpIijeCP4u+N5QnXnzJIDLZj+nmEyxLlgL/bVu+x8b
        QXB9QhgznWOrGGmR8E/O/CmJJQoiLwevjKVyOxc=
X-Google-Smtp-Source: ADUXVKJY3liCWI5GXFqM24pJgdjWULMjZx1oy9zrMDsN6/LcW0sXMZq7CLa8r0M0ZJBgFP1aaHeh3YFCz0BG8GTxp1s=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr11715910uas.26.1528709210946;
 Mon, 11 Jun 2018 02:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <5821a6dbe413b5a217ca1e24ddf8ebfa63ba6ef0.1527244201.git.viresh.kumar@linaro.org>
 <c6254ebb1f177468db6b8ac560ffb5a4a0b864f0.1527655562.git.viresh.kumar@linaro.org>
In-Reply-To: <c6254ebb1f177468db6b8ac560ffb5a4a0b864f0.1527655562.git.viresh.kumar@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Jun 2018 11:26:40 +0200
Message-ID: <CAMuHMdWbnBJuozvCE_Zt=08d06L6CynRw94qtOzeydTE_q5RLQ@mail.gmail.com>
Subject: Re: [PATCH V2 13/15] arm: dts: r8a77xx: Add missing OPP properties
 for CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 6:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
>
> Add such missing properties.
>
> Fix other missing properties (like, clock latency, voltage tolerance,
> etc) as well to make it all work.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
