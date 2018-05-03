Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeECQXt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:23:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53104 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeECQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:23:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
        <20180428091823.h3iajtxkqdwdcpst@gmail.com>
        <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
        <CA+55aFyVEJtiRjcazfTst7swGNXXZFHByHO5++-Foq6TDZWjTg@mail.gmail.com>
        <86ff0f5c-0215-798a-2ab8-71fe1677255c@linux.intel.com>
        <20180502140008.GE2851@pd.tnic>
Date: Thu, 03 May 2018 11:23:40 -0500
In-Reply-To: <20180502140008.GE2851@pd.tnic> (Borislav Petkov's message of
        "Wed, 2 May 2018 16:00:08 +0200")
Message-ID: <87vac4r9mb.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEH1G-0000GX-VX;;;mid=<87vac4r9mb.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+l1EHhLgAScVt3JLAj3mTGJBn+r0/56Wg=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3132]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Borislav Petkov <bp@alien8.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 129 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.3 (1.8%), b_tie_ro: 1.55 (1.2%), parse: 0.68 (0.5%),
        extract_message_metadata: 12 (8.9%), get_uri_detail_list: 0.67 (0.5%),
        tests_pri_-1000: 7 (5.5%), tests_pri_-950: 1.22 (0.9%), tests_pri_-900: 0.99
        (0.8%), tests_pri_-400: 15 (11.3%), check_bayes: 14 (10.5%), b_tokenize: 4.1
        (3.2%), b_tok_get_all: 4.0 (3.1%), b_comp_prob: 1.39 (1.1%), b_tok_touch_all:
        2.4 (1.9%), b_finish: 0.57 (0.4%), tests_pri_0: 83 (64.1%),
        check_dkim_signature: 0.59 (0.5%), check_dkim_adsp: 2.4 (1.9%),
        tests_pri_500: 6 (4.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFD] x86: The future of MPX
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Sun, Apr 29, 2018 at 09:44:00PM -0700, Dave Hansen wrote:
>> The loss of the GCC support is definitely a bummer.
>
> https://gcc.gnu.org/ml/gcc-patches/2018-05/msg00027.html
>
> Will go into gcc9.

So we should see this in a released version of gcc in about a year?

Eric
