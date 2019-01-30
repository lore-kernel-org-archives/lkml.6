Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125B420857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbfA3XA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:00:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43879 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfA3XA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:00:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id z18so791075qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwvisFl3ym8ybE7hkwPtUj68rTjAeG0WAzKmdDl81zM=;
        b=VDATbCwNKhJofdM/WbAI3zX9g+FjLZP5fP3Uc+BRMpKa3FgGslkopf7xe+QVrHUtzT
         3GZGnSDzepEpowPKRZporQieqn2iVsxcHvdwynvRjlJiFqhJwM4194pIZV2dhxrUtEzg
         Ka896ur8VQEDvXlirEn7CvMIav+RrogiZxwOV2YUtJvw0HPTX2FtGY/RJ47UinHuF1x6
         Rii8/wL8rsge6uw45Y3yWnu+Bfo67QZ3ldtm6zlj+yVq3eGLrPPXduUEoIO8v85fc6Uk
         Yg0445AwpX50drRo5iZrlfgdtIuxg6sB8hgXx0t440ta0WZ1ezEEFrb3rAJU6CnHaGuc
         jfpQ==
X-Gm-Message-State: AJcUukd6JQhjyAPSGU5eiqnDh2+pTqcFqUD5NsYXfEW7sMu7lnRJ7bkq
        V/hHuKxr1v4+g0hUZfkZ6fSlLeCS/pONdR6nu+s4QQ==
X-Google-Smtp-Source: ALg8bN6wEGw/fP0cjF2MygESjFk9pXZ9+fggbK2dINbo1vNXDL3MCYLRLJZunE9dmZKwcphyYzEelwsHk8kKJgVAf8Q=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr28721678qkf.330.1548885635965;
 Wed, 30 Jan 2019 14:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar> <12f44672-ff9a-20cd-0f4c-44cf1c18bb5b@gmail.com>
In-Reply-To: <12f44672-ff9a-20cd-0f4c-44cf1c18bb5b@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 23:00:19 +0100
Message-ID: <CAK8P3a0TRRQ53UEjdFsmwGqvPgEfkm-7a3Ki7EDWP+dZniB+Aw@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/mach-ep93xx: Remove duplicate header
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sabyasachi.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 3:48 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> On 17/01/2019 15:37, Brajeswar Ghosh wrote:
> > Remove mach/gpio-ep93xx.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>
> Arnd, would you take it into one of your ARM trees?

Applied to the arm/soc branch now, thanks!

     Arnd
