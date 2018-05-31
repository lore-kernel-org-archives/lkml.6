Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeEaUZy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754184AbeEaUZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:25:52 -0400
X-Google-Smtp-Source: ADUXVKK0cmoVgPQEcpDIrsygziPwMB0C/Qn5s63sk72d98Utt3TskR9657i0vWyEI3INmae6T//7zW/I4QA+tU9PILw=
MIME-Version: 1.0
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com> <1527789525-8857-7-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1527789525-8857-7-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 31 May 2018 13:25:39 -0700
X-Gmail-Original-Message-ID: <CALCETrUL0sV3f4z=S0y-fwPE82pp8BTGDGkvi=MPHak8-zwBnQ@mail.gmail.com>
Message-ID: <CALCETrUL0sV3f4z=S0y-fwPE82pp8BTGDGkvi=MPHak8-zwBnQ@mail.gmail.com>
Subject: Re: [PATCH V2 06/15] taint: Add taint for insecure
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
> When adding new feature support, patches need to be
> incrementally applied and tested with temporal parameters.
> For such testing (or root-only) purposes, the new flag
> will serve to tag the kernel taint state properly.

I'm okay with this, I guess, but I'm not at all convinced we need it.
