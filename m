Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeERTXN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:23:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38907 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbeERTXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:23:12 -0400
Date: Fri, 18 May 2018 12:22:50 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+55aFz4vKF-xC+A=DOozkPMVyLHPC5xMqW+y6pg9D7W-c2BQw@mail.gmail.com>
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com> <20180518075853.GD12217@hirez.programming.kicks-ass.net> <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com> <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com> <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com> <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com> <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com> <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com> <6A3E90AA-7838-4C2A-B628-908F34902B75@vmware.com> <CA+55aFysH5iiJWCVFu1J6GQfN2G1AbMcHyc4RhpnrnPjtM3L0Q@mail.gmail.com> <C481FBCA-2FA6-49B6-84DC-83FF03F539B9@vmware.com> <CA+55aFz4vKF-xC+A=DOozkPMVyLHPC5xMqW+y6pg9D7W-c2BQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: Linus Torvalds <torvalds@linux-foundation.org>, namit@vmware.com
CC: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
From: hpa@zytor.com
Message-ID: <102B8072-91D5-4D28-82C9-64D5AA73802C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2018 12:21:00 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Fri, May 18, 2018 at 12:18 PM Nadav Amit <namit@vmware.com> wrote:
>
>> Gnu ASM manual says: "Each time you run as it assembles exactly one
>source
>> program. The source program is made up of one or more files.”
>
>Ok, that counts as documentation, although it's confusing as hell. Is
>it
>one source program or multiple files again? I see what they are trying
>to
>say, but it really could be phrased more clearly ;)
>
>                     Linus

At least we have a solution!
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
