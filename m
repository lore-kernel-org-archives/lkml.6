Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeBHUKr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:10:47 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42418 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:10:46 -0500
X-Google-Smtp-Source: AH8x224SMH3H0oyVVX4sY9P0/B3Cn7coRsRy5IoJ6oasftQ3Uo6g0MoPnOynE/uxFWcwJ+/C90TORQ==
Date: Thu, 8 Feb 2018 15:10:44 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cramfs: better MTD dependency expression
In-Reply-To: <CA+55aFzHtRbis95-D-nLB6v_FM8ZVPU6Wt=A04bG2zH+RukhaA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1802081500300.31719@knanqh.ubzr>
References: <nycvar.YSQ.7.76.1802072149330.7021@knanqh.ubzr> <CA+55aFzHtRbis95-D-nLB6v_FM8ZVPU6Wt=A04bG2zH+RukhaA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018, Linus Torvalds wrote:

> On Wed, Feb 7, 2018 at 7:08 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >
> > Viro once told me that my cramfs pull requests could go either to him or
> > to you. I have only this one patch at the moment, and since it depends
> > on a commit that recently appeared in your tree I'm therefore sending it
> > directly to you.
> 
> Applied.

Thanks.

> Although I'm not entirely convinced that the simpler dependency is
> easier to _read_ and understand.
> 
> It is clearly simpler, though.

Probably depends on the mental representation you make of it. If you 
consider driver A depending on driver B then having A <= B in terms of 
build level dependency is pretty natural. Maybe it is just me but the 
alternative always gave me pause.


Nicolas
