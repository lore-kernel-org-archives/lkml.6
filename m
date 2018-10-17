Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F0ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52152150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52152150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeJQXrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:47:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38394 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:47:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so30565171qtf.5;
        Wed, 17 Oct 2018 08:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Gwf09yNydj2Sv/57PUQC1xF7qbVXIWzAS4JkD4Sc+8=;
        b=VrmsXmrp0ZnGsxKty8+/al/IgTfQ2XbeGPDvZU0al2z2Cljkn8R6U+9cdnELSeBL/I
         m/BGdIdIpltB/02Jwz57D3bq8faY+7O82YnA+YMOb3Q5lY5JAsnOc+sqOTEVj0oP/YwR
         WkCow8YsSzeMmZnfvLfqkQNaX8M4fAk8SydzKZhVmHCTzL6cesdHQj1p1iZU2n7eE4bd
         THf1N3NDVARNWDhIYVkIYeIz4acF4287fhbsW1I3CERNWnhqSQBmpmj8mouxAsmIb1Ms
         dB6aIwq5uEKSQBgQXiaO9Pc2HNYa8rcIQQNwmwDovQqqQpudQnRvHK0JDr8LafM5XJq6
         c/cg==
X-Gm-Message-State: ABuFfohGhba/m70tbHs4Mv4iDicONrLjQGCA3iPEgub3FJDNyRTeZa3a
        c2sh9uoy4M1AlfDI4prmlkLLS1KgnII15swFnjk=
X-Google-Smtp-Source: ACcGV62mCuZuDzhFXk4tOE77LClBvaPF/AlgTxs7gOQQgp7fCKKC3YUfMxRDP1XW+mc91JA3zI0AKWls2X3N51LkB5s=
X-Received: by 2002:a0c:e150:: with SMTP id c16mr27019851qvl.161.1539791481229;
 Wed, 17 Oct 2018 08:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <139bb600da725b1e251f0b465b24a865622a6f57.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <139bb600da725b1e251f0b465b24a865622a6f57.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:51:05 +0200
Message-ID: <CAK8P3a1zJfGg2KhxW5=83c6e98uYeZord+VK9166bYo9YJgDGw@mail.gmail.com>
Subject: Re: [PATCH V9 20/21] MAINTAINERS: Add csky
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:31 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Add a maintainer information for the csky(C-SKY) architecture.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
