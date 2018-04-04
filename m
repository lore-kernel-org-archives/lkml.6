Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeDDWDk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:03:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36837 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbeDDWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:03:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Alban Crequy <alban.crequy@gmail.com>,
        Iago Lopez Galeiras <iago@kinvolk.io>,
        containers@lists.linux-foundation.org,
        Daniel J Walsh <dwalsh@redhat.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org, Michael Crosby <crosbymichael@gmail.com>,
        Stephen J Day <stephen.day@docker.com>,
        Alban Crequy <alban@kinvolk.io>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jess Frazelle <acidburn@microsoft.com>
References: <20180404115311.725-1-alban@kinvolk.io>
        <87tvsrjai0.fsf@xmission.com> <20180404184250.GA9997@mail.hallyn.com>
Date: Wed, 04 Apr 2018 17:02:27 -0500
In-Reply-To: <20180404184250.GA9997@mail.hallyn.com> (Serge E. Hallyn's
        message of "Wed, 4 Apr 2018 13:42:50 -0500")
Message-ID: <871sfuiqa4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3qVE-0000n2-3O;;;mid=<871sfuiqa4.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jT4ndV4hVPS5W+jsBPgnuZEu48ipyWR8=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"Serge E. Hallyn" <serge@hallyn.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 224 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.9 (1.8%), b_tie_ro: 2.8 (1.3%), parse: 1.00 (0.4%),
        extract_message_metadata: 11 (4.7%), get_uri_detail_list: 0.54 (0.2%),
        tests_pri_-1000: 5 (2.4%), tests_pri_-950: 1.01 (0.5%), tests_pri_-900: 0.89
        (0.4%), tests_pri_-400: 18 (8.0%), check_bayes: 17 (7.5%), b_tokenize: 3.6
        (1.6%), b_tok_get_all: 6 (2.6%), b_comp_prob: 2.2 (1.0%), b_tok_touch_all:
        3.2 (1.4%), b_finish: 0.76 (0.3%), tests_pri_0: 96 (42.7%),
        check_dkim_signature: 0.34 (0.2%), check_dkim_adsp: 4.6 (2.0%),
        tests_pri_500: 85 (38.1%), poll_dns_idle: 80 (35.5%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] [RFC][WIP] namespace.c: Allow some unprivileged proc mounts when not fully visible
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> It looks like a cruft free cousin of proc that is just processes would
>> be applicable to your usecase.
>
> Just to check - is that something you're working on?

Only to the point of reviewing code, and I don't have a version to
review right now.

Eric
