Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A376FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C0E2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfBOPOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:14:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45423 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbfBOPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:14:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so1143249qtg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6HlYCGkavTor4Pj75JCcyYySifJWasU4FHKdrdWRQc=;
        b=egeN4U70i09mJ8J/ep2LGjzimQF3kpa8YRdjCqcJznR50i7YZ1whK8nbUJjENs3cq+
         NqCye+6JZVoaDCJC0d+Tmzo1Z3lUMEdAnNt7G+A1P9XS1hWhGILdoqRb307E/Lph5pmg
         R/f9HZqgPsULCZ+Mna1w+KDbPZHwDmTn3foGh+cHVXUaJsDiwYpSUFZwBEOSJsEU/j6P
         /KdOdfbUKkkggF8fO0x0E+nWT50cu2jS4P0DPy9TVjw0WL4VfPcrt+LjDxUg/0nQ3SCk
         a1jXwp+wpBRO5z0hixFAkwbxnGGpVsLhlyxDrP1n1b3F8PTg/FpUV+ICDo04WbvGfTqE
         1rnw==
X-Gm-Message-State: AHQUAubdbDwlHGFQrn1hYDAaZX2P/RSssMSJb0EbO+/0ZsRXVGdiydmZ
        i9vjzuJttbtKZZSXvixIIc4PVYf7lmPF0FT1EFg=
X-Google-Smtp-Source: AHgI3Ib1wtygyncDzVTYyCGG4NWpbK3xU8Ow2xxKOcG7kdJ3cUZnAYoqfcjan9+YMLtMoWGaOfUK/dCI6RS4Zg9Jhn8=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr7815279qtl.343.1550243682681;
 Fri, 15 Feb 2019 07:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20190212192838.GA12677@piout.net>
In-Reply-To: <20190212192838.GA12677@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Feb 2019 16:14:25 +0100
Message-ID: <CAK8P3a3naMESA7-4c3HSWiiS9QJvPM_TTzLAf4_ge_zeZrG5JA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: DT for 5.1
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 8:28 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> AT91 DT for 5.1
>
>  - Enable QSPI NOR on sama5d2 SoM1
>  - replace deprecated gpio-key,wakeup property
>

Pulled into arm/dt, thanks!

     Arnd
