Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeFAG6u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:58:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45313 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeFAG6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:58:47 -0400
X-Google-Smtp-Source: ADUXVKIOn3woCH0FFMJHd5Qqhj74tV+TvBLUQD1yeTnT6nm7zf5CMAS1uF0gX1jVmWpuRSDQxTuE2Sz9bArxvomM6i0=
MIME-Version: 1.0
In-Reply-To: <87po1bd7ky.fsf@xmission.com>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
 <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com> <87h8oqhagl.fsf@xmission.com>
 <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru> <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
 <778ab3d0-b6bc-fdb5-669a-40222e5020d4@yandex-team.ru> <e3a1076d-cfd7-a034-dd08-2d74fbf751f3@oracle.com>
 <3e2c285a-1bf8-f71d-1b74-4d6465c29a54@yandex-team.ru> <3bdd6b27-0a46-5802-8671-07268cecc1c7@oracle.com>
 <87po1bd7ky.fsf@xmission.com>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Fri, 1 Jun 2018 09:58:45 +0300
Message-ID: <CALYGNiPyjJQ2dZHtF+Ug5TFjEcK2O9anLDDDG0JftXtykPAoEg@mail.gmail.com>
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 9:05 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>
>> Ping? Any additional comments on this patch?
>
> Konstantin's v5 no.
>
>   I am uncomfortable with unnecessary flexibility.  I don't want to
>   encourage the increased usage of pids to identify namespaces.  I saw
>   no arguments in favor of pids to identify namespaces from Konstantin.
>
> Your v4 updated to reflect Andrew Morton's concerns in the changelog
> yes.

Ok, whatever. If I the only blocker then let it be v4 design.

>
> Eric
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
