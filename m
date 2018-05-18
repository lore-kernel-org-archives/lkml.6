Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeERRkT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:40:19 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36280 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeERRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:40:18 -0400
X-Google-Smtp-Source: AB8JxZqhSJbaUtECjMdUgIsOnREshdA9OuzUQjJbQcBJHMkgvIo77ujxNrtCFyRVQCpLgY0L6YekyzNh4IIu5pMS98A=
MIME-Version: 1.0
References: <20180518170202.11458-1-samitolvanen@google.com> <05d14ac7-0feb-63a3-e7ef-b8ca1ae2fd1d@arm.com>
In-Reply-To: <05d14ac7-0feb-63a3-e7ef-b8ca1ae2fd1d@arm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 18 May 2018 10:40:06 -0700
Message-ID: <CAKwvOdm1kYedukCq=g74AvqJHp6KC03oNoouQy2nkvfo4idoEw@mail.gmail.com>
Subject: Re: [PATCH] arm64: kvm: use -fno-jump-tables with clang
To: marc.zyngier@arm.com
Cc: Sami Tolvanen <samitolvanen@google.com>, christoffer.dall@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:30 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
> I'm going to ask the question I've asked before when this patch cropped
> up (must be the 4th time now):

> Is it guaranteed that this is the only case where LLVM/clang is going to
> generate absolute addresses instead of using relative addressing?

It seems like if there's requirements that only relative addressing be
used, then the compiler should be told explicitly about this restriction,
no?
-- 
Thanks,
~Nick Desaulniers
