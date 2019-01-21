Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ADBC37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05722089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfAUUtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:49:08 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:40334 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfAUUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:49:07 -0500
Received: by mail-qt1-f177.google.com with SMTP id k12so25029592qtf.7;
        Mon, 21 Jan 2019 12:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaBK4XeuqC88UVowCeUDOukzrGG02Sj5zlxTwu6Zo/0=;
        b=pwXaoRk3KUXWTFPJlgyzTzOL9CdtqyodipooqaFAejc18tD6omMfOO+rg+QHGMaIU9
         wBTnqOtHZof66g+hp6usA7TzBtYAFx5MtR2+g1LNrYy5O38l7VqTSPhBOk8Qpsi5ouqK
         745WyykcBfvk2F02B2Nds2NbT/X+zPSh5DLISiTnCYmo4DjU5OQD6OYd2rYQL1ECxC2F
         RLqk7glg9VEwNe//pHvKeybz/DVn5kah1zafY1k3PINibluZkv6+yyqfIXePJvRofn9t
         vQ9PiZokAUT5w5OlSjVZADZm5tXErdnJ8q1YYI5P90w8Z6M1Kk2MdBwBcCzNMzTIDxVJ
         M8wg==
X-Gm-Message-State: AJcUukeo4me5BYPvaFHeyagc2Ggyz7QF5TAFepzQ0IcuAEG0KtEss8L1
        Oz2IKtN6T9pZhrDnAJRbkfo9WeK3p7/tpwF7WvLUXw==
X-Google-Smtp-Source: ALg8bN5q49QYLqNMNJWt1p9N+w4SsRoQIh8X5ibLCp/3FdLVf7wNe0hht1A2b9bA0Jmr59CG56pdpEKW737Qh0ZkCmY=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr28811819qta.152.1548103746668;
 Mon, 21 Jan 2019 12:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20190120153044.71775e03@canb.auug.org.au>
In-Reply-To: <20190120153044.71775e03@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Jan 2019 21:48:50 +0100
Message-ID: <CAK8P3a28_hxweVAXn0tdE83fpTcNMdOnuuva=Z4J9-jv6skyMg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the y2038 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 5:30 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Arnd,
>
> Commits
>
>   e6f8f282d174 ("timex: use __kernel_timex internally")
>   683569ef2b4f ("time: Add struct __kernel_timex")
>
> are missing a Signed-off-by from their committers.

Fixed now, thanks for the report!

    Arnd
