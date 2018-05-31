Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755969AbeEaSFa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:05:30 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56865 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbeEaSFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:05:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
        <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
        <87h8oqhagl.fsf@xmission.com>
        <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
        <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
        <778ab3d0-b6bc-fdb5-669a-40222e5020d4@yandex-team.ru>
        <e3a1076d-cfd7-a034-dd08-2d74fbf751f3@oracle.com>
        <3e2c285a-1bf8-f71d-1b74-4d6465c29a54@yandex-team.ru>
        <3bdd6b27-0a46-5802-8671-07268cecc1c7@oracle.com>
Date: Thu, 31 May 2018 13:05:17 -0500
In-Reply-To: <3bdd6b27-0a46-5802-8671-07268cecc1c7@oracle.com> (Nagarathnam
        Muthusamy's message of "Thu, 31 May 2018 10:41:20 -0700")
Message-ID: <87po1bd7ky.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fORww-0003Jb-NS;;;mid=<87po1bd7ky.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sSwYiAl/QCKHWjCEqYwwEt3ycQNcfepA=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3918]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 654 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 5 (0.8%), b_tie_ro: 4.5 (0.7%), parse: 1.18 (0.2%),
        extract_message_metadata: 64 (9.8%), get_uri_detail_list: 0.83 (0.1%),
        tests_pri_-1000: 23 (3.5%), tests_pri_-950: 2.00 (0.3%), tests_pri_-900: 1.60
        (0.2%), tests_pri_-400: 60 (9.1%), check_bayes: 58 (8.9%), b_tokenize: 24
        (3.7%), b_tok_get_all: 10 (1.5%), b_comp_prob: 3.1 (0.5%), b_tok_touch_all:
        2.3 (0.4%), b_finish: 0.77 (0.1%), tests_pri_0: 468 (71.6%),
        check_dkim_signature: 0.83 (0.1%), check_dkim_adsp: 16 (2.4%), tests_pri_500:
        23 (3.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:

> Ping? Any additional comments on this patch?

Konstantin's v5 no.

  I am uncomfortable with unnecessary flexibility.  I don't want to
  encourage the increased usage of pids to identify namespaces.  I saw
  no arguments in favor of pids to identify namespaces from Konstantin.

Your v4 updated to reflect Andrew Morton's concerns in the changelog
yes.

Eric
