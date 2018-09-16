Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BCDECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5852086E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 19:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9UZlpXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5852086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeIQAfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbeIQAfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:35:44 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872EA2086E;
        Sun, 16 Sep 2018 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537125109;
        bh=c31YqLBlgSgvpWyIRSxqtR20zAnnThg3bW4jPYw6Rm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q9UZlpXaAlZuOxFxUKsTEKbFQwkjF03Ei/cqCQufkIejZqsYs5Knr0h2f1jDOk9A+
         A/rnhzOmfugR/bHQAW4PpSXzMITKr1zy/FZDFobTZdMTRqAUKQihbkex4er/wd1iRs
         LmDf9JYFQZYH7vwEfKO2GgTYfNxLbzqZ5Xivq0tw=
Received: by mail-qt0-f174.google.com with SMTP id z8-v6so13426512qto.9;
        Sun, 16 Sep 2018 12:11:49 -0700 (PDT)
X-Gm-Message-State: APzg51Dzu+Y26+MlHjDvj2h1ZcwZ74OVH/kdITFa7KK8D2ivm9KQq33v
        LSwZWcGN/6YEXYtmnLR8yXrWO2+SB369Mwi4SA==
X-Google-Smtp-Source: ANB0Vda3J01WsgLwwGY0rC4ETy399/1xxikuWYECl1tfxGJ6W9NhFpmP84uNo3lBmcPRa2Nhai0xikx6tkFc2MR40lU=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr15702522qtd.101.1537125107716;
 Sun, 16 Sep 2018 12:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180915133459.GA11537@pc-sasha.localdomain>
In-Reply-To: <20180915133459.GA11537@pc-sasha.localdomain>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 16 Sep 2018 14:11:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Q3vRDmPRP+UB+eP3Qh=C3rknD7Q-4Np1gxCwCKSrtUQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Q3vRDmPRP+UB+eP3Qh=C3rknD7Q-4Np1gxCwCKSrtUQ@mail.gmail.com>
Subject: Re: Inclusion of commit e54192b48da7 into stable tree?
To:     alexander.kapshuk@gmail.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 8:35 AM Alexander Kapshuk
<alexander.kapshuk@gmail.com> wrote:
>
> Is this commit queued up for inclusion into the stable tree?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/of/base.c?h=next-20180913&id=e54192b48da75f025ae4b277925eaf6aca1d13bd

It will be. It only landed in Linus' tree on Fri. Any commit with a
stable tag gets picked up.

Rob
