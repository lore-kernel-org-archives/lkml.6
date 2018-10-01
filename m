Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B28C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFC520684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFC520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbeJATzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:55:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34452 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeJATzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:55:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id x23-v6so13901687qtr.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 06:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clpmkpYr4SKKPLCQoDmcJmgtfc0PJ0l1GfiPvNa19Sc=;
        b=n5KApk0zC+K8JnkfxT+OLeSb4x3Puvre72uhRnsF8o5VNzPQBydLTJrArok52cGv0A
         t5LcXYPzh6rtelOjqGoz9FfXp/S7fBo3l6qiV1dRFnz6a1JrxgZBMwQQnSQ5OIV7Uj4k
         9OYwjsPgnYvOT7NKc3g+qGkq9cfgb9YN2v4xe/SdGM+9lNtky2UF3zMYW0R7lDxoi5Uc
         435fHCGFR5NMOH2DEi/9SjUrhXh23j/EgTp7n3UYCx+jRLI1bX14JOBjxjdBpA47XsF3
         3zs599wXcYPUCTVkzHR0ydOlaAN8LjdFRl0vSdnj/S8ApbwIpzM743/s+IiIGH4FuE+2
         awjQ==
X-Gm-Message-State: ABuFfojbU4CVzaA8c5uGZ1tfovVANTyoOPxqb3/IMi6LrGxtm25meRNl
        +vGXbySpVbhkyop9pjnwb5KDmA3LYwGHhnt0BTQ=
X-Google-Smtp-Source: ACcGV61Po3q6iZDQqOh3KyU+0gG+jUIe6ILjW/ogsK0yGpMXAwWMcQCyy1R3teFW/ryueGUqK6SBxFcVgBFRW9VZiqk=
X-Received: by 2002:aed:3f08:: with SMTP id p8-v6mr8388491qtf.185.1538399880567;
 Mon, 01 Oct 2018 06:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180928224615.19862-1-nm@ti.com> <19176740-b38f-8ae9-a9a2-85d6f7a9c590@oracle.com>
In-Reply-To: <19176740-b38f-8ae9-a9a2-85d6f7a9c590@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 15:17:44 +0200
Message-ID: <CAK8P3a0CqDFbNOcLH-mEGfxb2HyzDNiuUWf5zAo1ndehQs9S2g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Drop dt-bindings/genpd/k2g.h
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 2:07 AM Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
> On 9/28/2018 3:46 PM, Nishanth Menon wrote:
> > Drop include/dt-bindings/genpd/k2g.h which disappeared from kernel tree
> > some time back, however MAINTAINERS file was missed to be updated.
> >
> > Fixes: d16645054d2f ("dt-bindings: Drop k2g genpd device ID macros")
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Dave Gerlach <d-gerlach@ti.com>
> > Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Reported-by: Joe Perches <joe@perches.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >
> > A big oops.. Sorry about that. will do better next time. I tried to relook and
> > I think we have'nt missed any other files.
> >
> > Based off next-20180928 tag.
> >
> > Santosh, any chance you could pick this up -> Thread:
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1776470.html
> >
> Could you please apply this to arm-soc tree if its not too
> late ?
>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Applied to next/soc, thanks!

      Arnd
