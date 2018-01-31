Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeAaT5j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:57:39 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:56587 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeAaT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:57:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <87372oph61.fsf@xmission.com> <87a7wwnkce.fsf@xmission.com>
        <87607im26i.fsf_-_@xmission.com>
        <CA+55aFz+uhHRRDPHW_OU+MXmrpKdE3Eb=okczd5_0STaTDe8sQ@mail.gmail.com>
Date: Wed, 31 Jan 2018 13:57:28 -0600
In-Reply-To: <CA+55aFz+uhHRRDPHW_OU+MXmrpKdE3Eb=okczd5_0STaTDe8sQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 31 Jan 2018 11:30:58 -0800")
Message-ID: <878tcdls2f.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1egyVi-0000gA-Jr;;;mid=<878tcdls2f.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Z1C61og4of4R4hBUEBJvbJ/Mu/RTPXco=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 200 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.9 (2.0%), b_tie_ro: 2.6 (1.3%), parse: 1.39 (0.7%),
        extract_message_metadata: 20 (10.0%), get_uri_detail_list: 1.67 (0.8%),
        tests_pri_-1000: 12 (6.1%), tests_pri_-950: 1.80 (0.9%), tests_pri_-900: 1.40
        (0.7%), tests_pri_-400: 23 (11.4%), check_bayes: 21 (10.7%), b_tokenize: 8
        (4.0%), b_tok_get_all: 6 (2.9%), b_comp_prob: 2.5 (1.3%), b_tok_touch_all:
        2.8 (1.4%), b_finish: 0.75 (0.4%), tests_pri_0: 124 (61.7%),
        check_dkim_signature: 0.58 (0.3%), check_dkim_adsp: 3.1 (1.5%),
        tests_pri_500: 9 (4.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] siginfo fix for 4.16-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jan 31, 2018 at 8:19 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I had a brain fart when I received Stephen email about a compile failure
>> in linux-next.  I thought the powerpc call to memory_failure had not
>> merged yet.  Instead it simply failed to compile :(
>>
>> Linus can you please pull Stephen's fix so that powerpc builds correctly.
>
> I fixed this up in the merge already, afaik. Or is there some other failure?

My bad.  I missed you fixed it in the merge.

I received a kbuild failure against linux-next this morning, and I
realized the build failure was against code that was already in 2.15 so
I should have patched and fixed that myself.

At which point I assumed the failure was because my siginfo code had
been merged into your tree.

Looking again you definitely fixed this in the merge.  So I don't know
the story of the broken kbuild of linux-next.  But I assume it will
sort itself out when the dust clears.

Apologies for the noise,
Eric
