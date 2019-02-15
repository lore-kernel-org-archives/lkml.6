Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5209321924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389393AbfBORCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:02:42 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40008 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389301AbfBORCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:02:42 -0500
Received: by mail-qk1-f179.google.com with SMTP id h28so2265329qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9zAIeq2Ol4m9ysnOUmt4bHtlKlrrmIDX6JCSKz/pRE=;
        b=QLwSFZHn64Ll6JXiLxC2UsBi+fvfcxnogpaL45/aVDVRxW7vuLXrXpw+FjL2cFnQnQ
         +/D2uWqR00HR4EWpkm4gH6N1jXpxgrjgpqUiJd43uvL7LFnC1I9k+j8t69qmnbpQaHwQ
         d7EM5wozZkMEVgpUCpEylxR2ibpMiE+RpzWePSYcKo4YMZbaElaB2goaIk0WnOF0BQSZ
         sOykYfkYqja6lu6gUcHteETkl/ip8FNX1cEGM+WCZHXHGIMszm0ype580Te3hcPE3/nM
         txe4y8MAd9xBrSflzhK14OW1KQViyhcpZJQx3u94pI/a5e8pzTM4bxJ3EAIcycIXhqxr
         rnwQ==
X-Gm-Message-State: AHQUAuZQawyI52hBGbb1yuty/tdMGXAf6An3EIHYgtFrq8tSDE764ffW
        gevTlOF0voKELN4Lr4PbgJoBjzE9hli8QZUTn+Y=
X-Google-Smtp-Source: AHgI3IbwmLqV3Zax5Lup19d5xghzKvGL2sRDkktZ1FER3kEV3EJDqpUp3luGQUbDVjbSOgqn9rAqzP8y+ECUxSWoBTw=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7767513qkh.173.1550250161012;
 Fri, 15 Feb 2019 09:02:41 -0800 (PST)
MIME-Version: 1.0
References: <1549044263-5862-1-git-send-email-santosh.shilimkar@oracle.com>
In-Reply-To: <1549044263-5862-1-git-send-email-santosh.shilimkar@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 18:02:24 +0100
Message-ID: <CAK8P3a3pspTHpVNDxwLG-GyajyjLN4nRz4k-3uUqwOP3xJzP3w@mail.gmail.com>
Subject: Re: [GIT PULL] soc: ti: couple of non critical fixes for v5.1
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 7:04 PM Santosh Shilimkar
<santosh.shilimkar@oracle.com> wrote:
> soc: ti: couple of non critical fixes for v5.1
>
>  - Fix the Clang warning for enum in Navigator dma
>  - Simplify code in ti_sci with DEFINE_SHOW_ATTRIBUTE macro

Pulled into arm/drivers, thanks!

     Arnd
