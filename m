Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031248AbeBNVAN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:00:13 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44526 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030902AbeBNVAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:00:08 -0500
X-Google-Smtp-Source: AH8x2251pam6zBZmmlZvcs9gpzd/jzoGiYOIQIAhrur6qeiFFErWLr/FN4Iz4ki98OS2/DHX3ALmZ1zaoC8lsOS2KAc=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <CAHC9VhTYYoFZYunARVS1M7O5RmnFzKXWdw-A-Mk11-g3z89Msw@mail.gmail.com>
References: <94279d21d4f6094c19921ea09e7e5093ac3a829c.1517635943.git.rgb@redhat.com>
 <CAHC9VhTYYoFZYunARVS1M7O5RmnFzKXWdw-A-Mk11-g3z89Msw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Feb 2018 16:00:05 -0500
Message-ID: <CAHC9VhRuRhNk1cnazkZrDnNb9Uanmn=WmCtq_PHskku++3375A@mail.gmail.com>
Subject: Re: [PATCH] audit: update bugtracker and source URIs
To: Richard Guy Briggs <rgb@redhat.com>
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 3, 2018 at 5:44 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Sat, Feb 3, 2018 at 12:33 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> Since the Linux Audit project has transitioned completely over to
>> github, update the MAINTAINERS file and the primary audit source file to
>> reflect that reality.
>>
>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> ---
>>  MAINTAINERS    | 1 -
>>  kernel/audit.c | 3 ++-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> Thanks for the revision, especially considering it was a really small
> nit.  I'll queue this up for after the merge window.

Merged into audit/next.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 845fc25..fba4875 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2479,7 +2479,6 @@ M:        Paul Moore <paul@paul-moore.com>
>>  M:     Eric Paris <eparis@redhat.com>
>>  L:     linux-audit@redhat.com (moderated for non-subscribers)
>>  W:     https://github.com/linux-audit
>> -W:     https://people.redhat.com/sgrubb/audit
>>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
>>  S:     Supported
>>  F:     include/linux/audit.h
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 227db99..5c25449 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -38,7 +38,8 @@
>>   *       6) Support low-overhead kernel-based filtering to minimize the
>>   *          information that must be passed to user-space.
>>   *
>> - * Example user-space utilities: http://people.redhat.com/sgrubb/audit/
>> + * Audit userspace, documentation, tests, and bug/issue trackers:
>> + *     https://github.com/linux-audit
>>   */
>>
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> --
>> 1.8.3.1
>>
>> --
>> Linux-audit mailing list
>> Linux-audit@redhat.com
>> https://www.redhat.com/mailman/listinfo/linux-audit
>
>
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
