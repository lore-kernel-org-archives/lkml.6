Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeDTQaV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:30:21 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:35565 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeDTQaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:30:19 -0400
X-Google-Smtp-Source: AIpwx4812W2LOkIdrHd9udDxq2geGMFAPNQEQGy4wamNtnWnz5rbwdxWd6fPZAAIDgKWuQ/8mjlh3kk0kUcVQtrOfYo=
MIME-Version: 1.0
References: <CAAeHK+wDMH_G=3UuGOda2t0g4TH4TmDAeyG-ydJwg9vmThd3eQ@mail.gmail.com>
 <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com>
In-Reply-To: <c61336a2-7c66-ea48-3daa-e644403d7a6e@arm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 20 Apr 2018 16:30:06 +0000
Message-ID: <CAKwvOdnKuFuqoWKpVJqVa1u8A0z2+vQp9j7+TsNh9qz3Yitk-Q@mail.gmail.com>
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

On Fri, Apr 20, 2018 at 1:13 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
> Clang isn't
> really supported to build the arm64 kernel anyway

Can you expand on this?  There are millions of arm64 devices shipping with
Clang built Linux kernels.

--
Thanks,
~Nick Desaulniers
