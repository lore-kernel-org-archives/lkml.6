Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31DC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E6920851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E6920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbeLCKWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:22:12 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36280 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeLCKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:22:12 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so10409971oix.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xm0b3sAKjRneHEehA6TP4ig8A5dgikOgA6HKklipVnM=;
        b=RPiPfl39nphweAh8IpsIRujTytuIICMGU05g3sTZjmLXeiPXPdtz+BntAOiZvoR6nU
         IiigfBZMdvKRvXJfieYhmNANGFo1jmGhGR0ebSId8LA1Wf/p5LmZGTVvIwZ4svWzozHC
         K9AKoPD+8qH9ji5ZvHHnCIaJ8PMLMPDfGpN9sOC8IoeDwcalbEbnmg2RmCuIbETsKZyd
         hafA6wDYmXATwtk/fTxFqf60he28WJ2/W82ZovvHU/rsRFXGYMP3xY5sitATeEoNQcJs
         5Nz4+zUwyi4CQLEaImxiBzC7xQCStFHem688VuSycZZVxEo0DP3rMfklhEQaSj5f9Hmr
         K/zA==
X-Gm-Message-State: AA+aEWZuwU+whjaEr4AHm6FJOsxD9yuhJ7zQyDJDb0kvTlBTpus3lUMX
        CEau3bWnX7Jz+KEdjVcfSY1ls3XxASWA9F8HFJsvkQ==
X-Google-Smtp-Source: AFSGD/XeoOrxHSV7ALb4IJCzqjVP6vZFRWfQNW1n6n1EtWII8WBUAxuKM5n8eC9fTnYihjzZxbpzloxFxPJd/FhtOeg=
X-Received: by 2002:aca:195:: with SMTP id 143mr8947495oib.322.1543832506964;
 Mon, 03 Dec 2018 02:21:46 -0800 (PST)
MIME-Version: 1.0
References: <1539892534-16917-1-git-send-email-daniel.lezcano@linaro.org>
 <e21423b4-ec9c-ae6e-0b1f-c33e659b3cb0@linaro.org> <CAJZ5v0gHDzY9W0UG9QUDGTZGDD74ovRCj4dDFbksH0b4AoMvjg@mail.gmail.com>
 <d8a5aef3-fd22-1ce5-37f5-1c8a9db0168e@linaro.org>
In-Reply-To: <d8a5aef3-fd22-1ce5-37f5-1c8a9db0168e@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Dec 2018 11:21:35 +0100
Message-ID: <CAJZ5v0hRgBShA_MkqTtvX+Y9QVYKKyLW5jtTzEsNpZYaRTcEFQ@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Add the SPDX tags
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 11:15 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 03/12/2018 11:12, Rafael J. Wysocki wrote:
> > On Mon, Dec 3, 2018 at 11:07 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 18/10/2018 21:55, Daniel Lezcano wrote:
> >>> The SPDX tags are not present in cpufreq.c and cpufreq_schedutil.c.
> >>>
> >>> Add them and remove the license descriptions
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >> Hi Rafael,
> >>
> >> I think this patch passed between the cracks.
> >
> > Well, please resend. :-)
>
> I can resend, but can't you pick this one directly?

No, I can't apply it, because it depends on a patch that was not applied.
