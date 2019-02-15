Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9C222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfBOQ6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:58:38 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:38059 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfBOQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:58:38 -0500
Received: by mail-qt1-f176.google.com with SMTP id 2so11630400qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnmqEcnVe22uqilIXW6353Oi+MEwnNIwNE+n77BIoys=;
        b=eKzu3j0xRASvx7ZWStmeiqmhCIpkrKpKpTUxi9QIvR+Im0Yh8PNasiwixHSK4ChuLi
         qIsySfVtkvSCTqsUxpVW3L76l53dvsDdBUM8LmF9ECpVGU7TJjINikEY8V5waMAmRFzZ
         XCbd1uSUjXT44E3Q83TFZddgVJxydRlbXZZch8bTdN3+TKgte8d+OeEQugYt+uobQKLr
         xfPgulKinSk70n1oQBniiG39toDNTXNfp5PTcn5FycdK2OKf9D/moLs4sL+K8nAr53qP
         JkIG3MFUabQF0zcBZ1XvWIKIfZb/+/HujIZ9YoLKAYMszOZnvH5CBo9G0YzDwtH4kARu
         jPwQ==
X-Gm-Message-State: AHQUAua6nCY0v5YUK83uuPWQp30gK39pnz1kbWZzaw7ok5kI99PPO0gY
        w5EIgNmmWfNGYwLtoaPq6nMCyhdrRJm1H6Ty7Zq3uA==
X-Google-Smtp-Source: AHgI3Ib5CwljJQuLh7lcAZOmNriuFJ6O+ikTT5hEwKeyTDVSlArny4wfaT7T/2dUNcYKZkiRDvOpTpnq6P/FWXfaKpU=
X-Received: by 2002:a0c:c60f:: with SMTP id v15mr7903362qvi.40.1550249917555;
 Fri, 15 Feb 2019 08:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20190204085629.GA14098@jax.urgonet>
In-Reply-To: <20190204085629.GA14098@jax.urgonet>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 17:58:21 +0100
Message-ID: <CAK8P3a3-fq8YnkYgCB=+PWV88mfamf5ySi1s0yWcEDtKrjqRxA@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys for v5.1
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 9:56 AM Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this TEE subsystem enhancement. A tee bus driver framework
> is introduced in order to support an OP-TEE based RNG driver.
>
> The last commit makes changes under drivers/char/hw_random which
> also are acked by that maintainer.
>

Pulled into arm/drivers, thanks!

    Arnd
