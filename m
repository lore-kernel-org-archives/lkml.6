Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeERTVR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:21:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35753 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeERTVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:21:12 -0400
X-Google-Smtp-Source: AB8JxZos99Q2lRvkRHF+cY/SrJ3rXEAIOjBc49CBXGnfA9VWZy75/3rt+2txJf8QZqEmfYJ6eCTRi4gPLc4O+t9GJew=
MIME-Version: 1.0
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net> <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
 <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com> <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
 <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com> <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
 <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com> <6A3E90AA-7838-4C2A-B628-908F34902B75@vmware.com>
 <CA+55aFysH5iiJWCVFu1J6GQfN2G1AbMcHyc4RhpnrnPjtM3L0Q@mail.gmail.com> <C481FBCA-2FA6-49B6-84DC-83FF03F539B9@vmware.com>
In-Reply-To: <C481FBCA-2FA6-49B6-84DC-83FF03F539B9@vmware.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 12:21:00 -0700
Message-ID: <CA+55aFz4vKF-xC+A=DOozkPMVyLHPC5xMqW+y6pg9D7W-c2BQw@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: namit@vmware.com
Cc: Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4IJLKcv014650

On Fri, May 18, 2018 at 12:18 PM Nadav Amit <namit@vmware.com> wrote:

> Gnu ASM manual says: "Each time you run as it assembles exactly one source
> program. The source program is made up of one or more files.”

Ok, that counts as documentation, although it's confusing as hell. Is it
one source program or multiple files again? I see what they are trying to
say, but it really could be phrased more clearly ;)

                     Linus
