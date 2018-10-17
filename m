Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112CECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F042B2148E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F042B2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJQOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:54:52 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40041 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeJQOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:54:51 -0400
Received: by mail-ua1-f66.google.com with SMTP id c21so4366382uap.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 00:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipRaMNnwUo3jtCM9UTKaUbD7k8u2odRKzg0HcIsapzw=;
        b=PxF4JNvXOyaDCX1HVbyXJ+zRPqQ/XtQgwkTm46NdLsS86gKjZNMVD1DNOfiXpfdylC
         32kJ/X11lS5Rgtmq4XJD4f9v7BdJYp/ZQkeNjUzoU86+PdH3vBYibunknkynlLbN8lGs
         gtAP6nuwM4JteYdLUyi7JuYpUgjnznvu1s864BrOFbs1kRGjYZ421+mn1pg5toerC64m
         JS+xP8HS3kQSq3fVh57TG1CQww6NSDvDH0E32teNtNoEszUaF6gtbzTDA5wjB+JRX1h8
         EFxj45HjvVPvJzUs9hVamva5G9fT5EVAWirtHUrLlUGzk+FaD7/HBQTYCM9tDtZFx/AL
         +cjg==
X-Gm-Message-State: ABuFfohyt8aQxe2sVgLSTOp/qIR/Mpq5uuoGKBwtn/Ev/EdjPEFrcDpJ
        7c1xGzLuEPpCWA5khtYtVbt9RpjnQB/yoRauYfo=
X-Google-Smtp-Source: ACcGV60HvL4k8Cw5GiQqIpKmzTK0c+t1rEe2wK2fr3fm2L7iaw8sMo1JEL0xoPPy+UDAzx4+kMsSjw53DXw1yz1zpvI=
X-Received: by 2002:a9f:308a:: with SMTP id j10mr254525uab.28.1539759637935;
 Wed, 17 Oct 2018 00:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181016232130.728-1-tobin@kernel.org>
In-Reply-To: <20181016232130.728-1-tobin@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Oct 2018 09:00:26 +0200
Message-ID: <CAMuHMdUKxHhvWHpQZ=ssghsZBRa4YqTFrvYj1h8jP1bdZQEqNQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] drivers: tty: Fix kernel-docs comments
To:     tobin@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobin,

Thanks for your series!

On Wed, Oct 17, 2018 at 1:23 AM Tobin C. Harding <tobin@kernel.org> wrote:
> My first patch set using kernel.org email address.  I've been so careful
> with this one I'm expecting some epic fail :)

WARNING: Missing Signed-off-by: line by nominal patch author 'Tobin C.
Harding <me@tobin.cc>'

The From line in the body of the patch emails doesn't match the SoB.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
