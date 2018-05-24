Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034199AbeEXSND (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:13:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33306 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032628AbeEXSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:13:01 -0400
X-Google-Smtp-Source: AB8JxZoqT7m13wGubovIZ3laKwPp0od3AF+hg9AilJBY4lkHO/KsSKlstOrrSQhxQ+Ut7stY273NseVzjzD6h5R5h6E=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <CA+icZUWR0Pg7z+GhgbB+MBKR2FQtP2x3Mdq5gebJvumJDc1j1w@mail.gmail.com>
In-Reply-To: <CA+icZUWR0Pg7z+GhgbB+MBKR2FQtP2x3Mdq5gebJvumJDc1j1w@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 May 2018 11:12:49 -0700
Message-ID: <CAKwvOdk_3VKdaSHJv2-jRA-DM7n0cjN4gN4mQ3EET7FHiaSD-w@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: sedat.dilek@gmail.com
Cc: hpa@zytor.com, Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 3:33 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> with reverting...
> commit ab94fcf528d127fcb490175512a8910f37e5b346
> "x86: allow "=rm" in native_save_fl()"

> ...I had success to boot into a paravirtualized/strong-stackprotected
> Linux-kernel v4.14.43 on *bare metal* (Lenovo ThinkPad T470).

preping a patch in
https://bugs.llvm.org/show_bug.cgi?id=37512

will send shortly.
-- 
Thanks,
~Nick Desaulniers
