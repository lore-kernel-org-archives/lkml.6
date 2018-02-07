Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeBGTDq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:03:46 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:39999 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754495AbeBGTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:03:43 -0500
X-Google-Smtp-Source: AH8x227c3hcrlMw0O7NQnhRcrw0C4eHLicyRa0MAplS+qP2qjhkuGOR/rQbVVpIwIOdyJ4zr2XZM3ALPUzt3GQJSm98=
MIME-Version: 1.0
In-Reply-To: <20180207184933.GA25201@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic> <20180207184933.GA25201@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2018 11:03:42 -0800
X-Google-Sender-Auth: f1XRnowWwYPc05uEcLwCuJxtXKk
Message-ID: <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION a2e5790d841658485d642196dbb0927303d6c22f
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 10:49 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Right, we picked UD0 because we _thought_ everybody agreed it being 2
> bytes, just like UD2. This is now not true anymore?

Both UD0 and UD1 are documented to have modrm in the latest Intel SDM
I can find (Order number 325462-065US, December 2017):

  https://software.intel.com/sites/default/files/managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf

for the direct link.

           Linus
