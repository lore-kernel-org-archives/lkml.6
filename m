Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C9ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CA62082C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 18:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CA62082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeIXADz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 20:03:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41828 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeIXADy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 20:03:54 -0400
Received: by mail-vs1-f65.google.com with SMTP id e128-v6so796614vsc.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 11:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeHPlCVqBwkAXY8YwjHPIvgFF2XGz91SrWlXTBH924s=;
        b=SYjFVAtIsvQipoPyyeJ4/yfWwZRpL1J/nrtqj+EeotU4pxr1u109Pfwy9ym2IxjPR3
         LVBYDOUI4h1y6Hnjq2eqhxpK3rMd8nLJM4I+plOIdvNcz5ZnyhdjPuHOnDfCHojJqsYv
         pzHc7Xk1zJh8JsXd07AQ7dQvFyyasZvy9CmQjyp5BejCCpMUuzNCrtOyO8BNqPgg/7s7
         +zxVLAzEXsQuqjOPJA7AWOu5rqaNj74SgPkYDU0rmSvcFHPwAeK4lzYqgUrm/YAS/xqq
         AdrG8GZC/hLm8FDqaFGUnmyTz4uiz2VJ4cfKrUhzUmO6TfpYwzjTU+yV8EvMzdloHb9l
         N3JQ==
X-Gm-Message-State: APzg51BG34QMpBzQX6gc0SvMfUjDSYAXGDtjtFKo6kJ3yOQlljIGYyF/
        f6hr4BnEaKwebIGr81licsHDv07SQtxVNDhbCjxFFw==
X-Google-Smtp-Source: ANB0Vda+2kikOhCVWKmUbrETavP6jJTDVy7ETWoSImbg96oDoOlXUqF7WjWYFGSxqW7++VA2I7IlWS8Qb0JACJx3oCs=
X-Received: by 2002:a67:f785:: with SMTP id j5-v6mr1289597vso.96.1537725936217;
 Sun, 23 Sep 2018 11:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180923175547.GA4462@kroah.com>
In-Reply-To: <20180923175547.GA4462@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 23 Sep 2018 20:05:23 +0200
Message-ID: <CAMuHMdU5NnL6n_KbBRGdmV5XGsBkDsfzJKuiNB=hhqt0_mON1Q@mail.gmail.com>
Subject: Re: Linux 4.19-rc5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Sep 23, 2018 at 7:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> As almost everyone knows, it's been an "interesting" week from a social
> point-of-view.  But from the technical side, -rc5 looks totally normal.

Thanks for, and congratulations with, your first non-stable release!

> As usual, please go and test this thing, and let me know if anything
> technical isn't getting addressed that needs to be.

Oops... non-technical... you might want to drop the "stable" from your
future rcX tags ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
