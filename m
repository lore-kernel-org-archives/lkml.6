Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeEaUbu convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:31:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37985 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754434AbeEaUbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:31:49 -0400
Date: Thu, 31 May 2018 13:31:32 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrX3wXJM9=i1K_winBLygPHCJj2=Ebdsf_7y5xMo-kSrQw@mail.gmail.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com> <1527789525-8857-3-git-send-email-chang.seok.bae@intel.com> <CALCETrX3wXJM9=i1K_winBLygPHCJj2=Ebdsf_7y5xMo-kSrQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH V2 02/15] x86/fsgsbase/64: Make ptrace read FS/GS base accurately
To: Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC: Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <7A65BD11-6A84-4CDF-9FF7-34303BABBDD1@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2018 1:14:59 PM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>On Thu, May 31, 2018 at 10:58 AM Chang S. Bae
><chang.seok.bae@intel.com> wrote:
>>
>> From: Andy Lutomirski <luto@kernel.org>
>>
>> ptrace can read FS/GS base using the register access API
>> (PTRACE_PEEKUSER, etc) or PTRACE_ARCH_PRCTL.  Make both of these
>> mechanisms return the actual FS/GS base.
>>
>> This will improve debuggability by providing the correct information
>> to ptracer (GDB and etc).
>
>LGTM.

LGTM?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
