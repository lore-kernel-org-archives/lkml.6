Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeDDCLo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:11:44 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:42290 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeDDCLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:11:42 -0400
X-Google-Smtp-Source: AIpwx49HauBkHq0MbgpZ0YewCMefqRfQnEtHcwjAgVJfVFyNQ/gmr+yhVXUV4twnprhtIgTA7udQG1A8jQwK3XGPA6U=
MIME-Version: 1.0
In-Reply-To: <20180404010946.6186729B@viggo.jf.intel.com>
References: <20180404010946.6186729B@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 19:11:41 -0700
X-Google-Sender-Auth: A37dosY4B38e06Afy8XEsTYplhw
Message-ID: <CA+55aFxYunj-s2N60Q2Y63TsrhJKwqLa=-GJPMb6--RA_ud6Fw@mail.gmail.com>
Subject: Re: [PATCH 00/11] [v4] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 3, 2018 at 6:09 PM, Dave Hansen <dave.hansen@linux.intel.com> wrote:
> Changes from v3:
>  * Fix whitespace issue noticed by willy
>  * Clarify comments about X86_FEATURE_PGE checks
>  * Clarify commit message around the necessity of _PAGE_GLOBAL
>    filtering when CR4.PGE=0 or PGE is unsupported.

I couldn't see anything odd in this, but I only read the explanations
and the patches, and the devil is in the details.

But it all looks sane to me, and the added comments all seemed like
good ideas. Plus the performance numbers certainly speak for
themselves, even if the big changes are from that Atom microserver
that I probably personally wouldn't want to use anyway ;).

So Ack from me, maybe a weak review.

               Linus
