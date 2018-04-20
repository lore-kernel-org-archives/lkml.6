Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeDTQnS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:43:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44623 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDTQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:43:16 -0400
X-Google-Smtp-Source: AIpwx4+Nv67JZKqSlh3TFrjm1kBO+wdvwKTUj6ScnDeZIeM+vMxITHDVC+B6gdoI01ll0ukcvN7lX5L3/W+fzLwI7SA=
MIME-Version: 1.0
References: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
 <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com> <CAKwvOdnKuFuqoWKpVJqVa1u8A0z2+vQp9j7+TsNh9qz3Yitk-Q@mail.gmail.com>
 <8b3e95df-a429-2f84-565c-3caed8e30e28@arm.com>
In-Reply-To: <8b3e95df-a429-2f84-565c-3caed8e30e28@arm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 20 Apr 2018 16:43:05 +0000
Message-ID: <CAKwvOdmhNH4PYNwH+tsZc4uQQJVhOOHSph2YdDCHcyWNyFMxyA@mail.gmail.com>
Subject: Re: Clang arm64 build is broken
To: marc.zyngier@arm.com
Cc: Andrey Konovalov <andreyknvl@google.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        LKML <linux-kernel@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 9:36 AM Marc Zyngier <marc.zyngier@arm.com> wrote:

> On 20/04/18 17:30, Nick Desaulniers wrote:
> > On Fri, Apr 20, 2018 at 1:13 AM Marc Zyngier <marc.zyngier@arm.com>
wrote:
> >> Clang isn't
> >> really supported to build the arm64 kernel anyway
> >
> > Can you expand on this?  There are millions of arm64 devices shipping
with
> > Clang built Linux kernels.

> How many of these devices run a full-featured mainline kernel?

> Sure, Android is building the kernel with clang, but that's with a pile
> of out of tree patches. At that point, I'm not sure we're talking about
> the same arm64 kernel.

Do you recommend that we only work with ARM licensed SoC vendors with no
out of tree patches?

--
Thanks,
~Nick Desaulniers
