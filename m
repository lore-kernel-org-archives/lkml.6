Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933396AbeCGMfD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:35:03 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:46459 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933251AbeCGMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:35:00 -0500
X-Google-Smtp-Source: AG47ELs70DLrrEEqeqlzOzafkaRmrSxTy9zENibENue84i+9V8EkyFxmG87uAVwYs0skgsBYkhF6swPYhq3enY9bfCo=
MIME-Version: 1.0
In-Reply-To: <20180306205920.GA786@kmp-mobile.hq.kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl> <20180227211539.5708-2-kernel@kempniu.pl>
 <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
 <20180304050813.GA3129@marvin.atrad.com.au> <20180304194426.GA1428@kmp-mobile.hq.kempniu.pl>
 <20180305231650.GA25693@fury> <CAHp75VeB6PjacT4V_gsVOYCvJJK2fT3Oi6HONHdqJyCn+CeWNw@mail.gmail.com>
 <20180306205920.GA786@kmp-mobile.hq.kempniu.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Mar 2018 14:34:58 +0200
Message-ID: <CAHp75VeOO8tBYWuVbm+2pFB0QeCsW7EoGhzPUY_7q+4bYKb4PQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Darren Hart <dvhart@infradead.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w27CZAsv002673

On Tue, Mar 6, 2018 at 10:59 PM, Michał Kępień <kernel@kempniu.pl> wrote:

> #define OP_GET_CAPS     0x0
> #define OP_GET_EVENTS   0x1
> #define OP_SET          0x1
> #define OP_GET          0x2
> #define OP_GET_EXT      0x4
> #define OP_SET_EXT      0x5

This one looks pretty much okay (logical pairs IIUC).

-- 
With Best Regards,
Andy Shevchenko
