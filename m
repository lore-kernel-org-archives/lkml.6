Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeEaURG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754071AbeEaURE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:17:04 -0400
X-Google-Smtp-Source: ADUXVKJC5PQI0D4vgQbmyMf6Ego9eLjct8w/K4Y2Kqid5D/NaI+bYSzR5TfcMk6+kqhobRddb0dGYgt/nqPwF4C1Ab0=
MIME-Version: 1.0
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com> <1527789525-8857-5-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1527789525-8857-5-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 31 May 2018 13:16:51 -0700
X-Gmail-Original-Message-ID: <CALCETrU2cxbvG3FjYAYhtcy4zx78ysJb1593URdWNggYwPwsng@mail.gmail.com>
Message-ID: <CALCETrU2cxbvG3FjYAYhtcy4zx78ysJb1593URdWNggYwPwsng@mail.gmail.com>
Subject: Re: [PATCH V2 04/15] x86/fsgsbase/64: Factor out load FS/GS segments
 from __switch_to
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:58 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Instead of open code, load_fsgs() will cleanup __switch_to
> and symmetric with FS/GS segment save. When FSGSBASE
> enabled, X86_FEATURE_FSGSBASE check will be incorporated.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
