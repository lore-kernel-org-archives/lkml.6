Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47B6C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39022085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfAUJke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:40:34 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37767 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfAUJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:40:33 -0500
Received: by mail-vs1-f67.google.com with SMTP id n13so12249798vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwDN2PoeIRDfiXS8gQMJSDzON1Ib+Zgi21D2jod52eg=;
        b=g8UGwvrTGA1voY74IAsYEJR4LHdz/WReEjled8f70g681mQ0sMTMTKAr+WHazS3Xcm
         Kyfl4CZsGgPLE56FgxtDqmVRkkjj+tdJqMIvXZIejkzrr5gLxhz5ipjiDgBnxwFMQiAK
         Xw8jqoUOjhC6wK4EL00NsJQxnQApYN8wqtihBWnlwlgMmSFAhiU/GIfhxkpEWpAIKNFN
         n4MTJzeKNdKsjaTwMfUP5eCGrs8NiqN9mcPky92JBcBB3vgBT4p5XamwkPnNU+veaijY
         OaYprIjdVxGw5sgjrnXXqL8fowdwthEIVREh8d6uE2JGv1Ww2HPIT+aDLmWXiTjb3Nxd
         AA6Q==
X-Gm-Message-State: AJcUukerRRluUaY99NoARxauLQgKX7oSxhmGGnQzsfjEQIacnYKS4Gmb
        qW4/1LhZiFbxv15xK9mKkCwhvI8N0IDPz34ryuA=
X-Google-Smtp-Source: ALg8bN7u4r3ClaikfRgUX0uXviGCHiexAA+W9cPEu06FMtYIvhGaSbpHhoXX2MmiwUlyRMNbrCyxAiQQCTQpgigtwRc=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr12251484vsm.152.1548063632586;
 Mon, 21 Jan 2019 01:40:32 -0800 (PST)
MIME-Version: 1.0
References: <d31f51f45a7e36d59aca55575edc69933cd4481c.1545445081.git.fthain@telegraphics.com.au>
In-Reply-To: <d31f51f45a7e36d59aca55575edc69933cd4481c.1545445081.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:40:21 +0100
Message-ID: <CAMuHMdVXgEMoT1VMKsy21yHfKq1UhQBK82z7g4Rq76UduAOnsw@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Clean up unused timer definitions
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 4:06 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
