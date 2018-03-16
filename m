Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeCPOxX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:53:23 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34242 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753568AbeCPOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:53:19 -0400
X-Google-Smtp-Source: AG47ELuh73i7kAya6D42U/9IvmULzX/DlaFesY9oQJlm09Z2lqw1B8EfsSi6glzvllRLF6q9ogGtQ9dTDfy9AQft0Jc=
MIME-Version: 1.0
In-Reply-To: <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 16 Mar 2018 15:53:17 +0100
Message-ID: <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
Subject: Re: arm64 kvm built with clang doesn't boot
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Hines <srhines@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kernel-dynamic-tools <kernel-dynamic-tools@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 3:13 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> I wasn't aware of that discussion, but this is indeed quite annoying.
> Note that you should be able to restrict this to arch/arm64/kvm/hyp/*
> and virt/kvm/arm/hyp/*.

That works as well (tried it, the kernel boots). I've also tried
compiling without the flag for virt/kvm/arm/hyp/*, it boots as well.
