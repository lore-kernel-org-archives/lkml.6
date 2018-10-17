Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2D3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820B92150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820B92150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJQWxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:53:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34773 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:53:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id o17-v6so30389653qtr.1;
        Wed, 17 Oct 2018 07:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1pXowANAu6AYNttwMg0tThvxv5oSyiXWYijrgcD5Cs=;
        b=Ie7Zjfu2rKlj/acs+Q5fyJb8Ioo0lqt/bd7Z2okpkbuV9TsYyFIh+xnxg3fVV5Un+2
         KHBnG3dKVN465tz2rk/epIXodoAG+wU3SQ+1lYeS7Q2BMTDW4PCIF99GXtygry60+ilM
         X15HCNep6ctS8PjYEzCaWezyGvLuveVhLQr0AAIXyHMSP30Hmh0g+GTotxk/RTfW3pB9
         ne/U3aPKkO58ZeEeQSNnyPlTueOhpbmq8/9b9Cy2NAfi3mkwpQQi7bw3qdx4a7lgkGqD
         LDDy9vYqqL3iNCWBrXuoNWsyPgY0vauXoEQvRYU2/U1AdtKwzFx841ofbErl9xzE++cx
         pTOg==
X-Gm-Message-State: ABuFfojaf297Ym6/eQdxOb4RPBvlu7iAjwqjOWH5mpI2KLH5/B3f1c8l
        UsnXMzFoAA5B4S/DV2jr7VvxOg9Whr8rd5XE1SU=
X-Google-Smtp-Source: ACcGV633/xmSz3PGO06IAdpIwbcZWVTlllpZJYI7tggmzLmibsnm2ddHgkeY9oc2Vk0SRy/OlQ1h+DkyGoVBY+WpevY=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr24631280qtd.319.1539788218605;
 Wed, 17 Oct 2018 07:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <9ae20a094ce79774f2a1c84468221ad73a38e90a.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <9ae20a094ce79774f2a1c84468221ad73a38e90a.1539655731.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 16:56:41 +0200
Message-ID: <CAK8P3a1HXreXNn+1UX2LFttttqcqD6J_1TLL4+yaPRe3GTJS8g@mail.gmail.com>
Subject: Re: [PATCH V9 02/21] csky: defconfig
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

On Tue, Oct 16, 2018 at 4:59 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds csky defconfig.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>



Reviewed-by:  Arnd Bergmann <arnd@arndb.de>
