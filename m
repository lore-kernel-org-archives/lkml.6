Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeENNLl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:11:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39640 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbeENNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:11:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Miller <davem@davemloft.net>
Cc: rahul.lakkireddy@chelsio.com, netdev@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        stephen@networkplumber.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com
References: <cover.1525253481.git.rahul.lakkireddy@chelsio.com>
        <20180513.201131.1649805811466916646.davem@davemloft.net>
Date: Mon, 14 May 2018 08:11:24 -0500
In-Reply-To: <20180513.201131.1649805811466916646.davem@davemloft.net> (David
        Miller's message of "Sun, 13 May 2018 20:11:31 -0400 (EDT)")
Message-ID: <87a7t2mlfn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fIDGJ-0003e1-CA;;;mid=<87a7t2mlfn.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Q6dDyJAP4aZhN9lyB6Kpn1tjXjoTW7Jo=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4672]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;David Miller <davem@davemloft.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1057 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.9 (0.3%), b_tie_ro: 1.93 (0.2%), parse: 1.17 (0.1%),
        extract_message_metadata: 29 (2.7%), get_uri_detail_list: 1.47 (0.1%),
        tests_pri_-1000: 12 (1.1%), tests_pri_-950: 2.0 (0.2%), tests_pri_-900: 1.65
        (0.2%), tests_pri_-400: 31 (2.9%), check_bayes: 29 (2.7%), b_tokenize: 10
        (0.9%), b_tok_get_all: 8 (0.7%), b_comp_prob: 3.4 (0.3%), b_tok_touch_all:
        3.5 (0.3%), b_finish: 2.3 (0.2%), tests_pri_0: 308 (29.2%),
        check_dkim_signature: 0.84 (0.1%), check_dkim_adsp: 4.5 (0.4%),
        tests_pri_500: 664 (62.9%), poll_dns_idle: 656 (62.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH net-next v8 0/3] kernel: add support to collect hardware logs in crash recovery kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> I'm deferring this patch series.
>
> If we can't get a reasonable review from an interested party in 10+
> days, that is not reasonable.
>
> Resubmit this once someone reviews it properly.

David I am out on vacation this week and last (the reason for the delay).

The last version of this that I looked at I gave my ack.  All of my ABI
concerns had been addressed. The only outstanding change I believe was
the Eric Dumazet's asking about something being reviewed.

I just glanced over it again and I don't see any new issues introduced
by the last round of changes.

>From 10,000 feet flyover design perspectie and from an ABI perspective
this patchset seems fine.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
