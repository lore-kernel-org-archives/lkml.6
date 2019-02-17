Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A0C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4220855
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfBQSEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 13:04:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42238 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBQSEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 13:04:42 -0500
Received: from mail.ispras.ru (localhost [127.0.0.1])
        by mail.ispras.ru (Postfix) with ESMTPSA id 60A61540093;
        Sun, 17 Feb 2019 21:04:39 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 17 Feb 2019 21:04:38 +0300
From:   efremov <efremov@ispras.ru>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] LSM documentation update
Organization: ISPRAS
In-Reply-To: <CAGXu5jJ8DaoXk4Vt-K_Tgvpe4=wgHZ3Z1Y=D8JzRHU9n=bvgtA@mail.gmail.com>
References: <cover.1549540487.git.efremov@ispras.ru>
 <CAGXu5jJ8DaoXk4Vt-K_Tgvpe4=wgHZ3Z1Y=D8JzRHU9n=bvgtA@mail.gmail.com>
Message-ID: <67ff280b6867b9a594ee16b2ad83bb7f@ispras.ru>
X-Sender: efremov@ispras.ru
User-Agent: Roundcube Webmail/1.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook писал 2019-02-11 22:28:
> On Thu, Feb 7, 2019 at 4:45 AM Denis Efremov <efremov@ispras.ru> wrote:
>> 
>> Recent "New LSM Hooks" discussion has led me to the
>> thought that it might be a good idea to slightly
>> update the current documentation. The patchset adds
>> nothing new to the documentation, only fixes the old
>> description of hooks to reflect their current state.

> 
> Do these fixes silence any warnings during the documentation build?
> (i.e. how did you verify the results beyond eyeballing the changes)
> 
> -Kees

This LSM documentation is not used during the documentation build.
At least I can't find it in the resulting build directory and at
the online documentation on the kernel. Most of the fixes are pretty
obvious and can be checked by comparing an lsm hook declaration and
its description in the LSM comment from lsm_hooks.h I tried to be
exhaustive in the commits description and in every case to reference
the original commit where the interface was changed without
documentation update.

> 
>> 
>> Denis Efremov (10):
>>   security: fix documentation for the sb_copy_data hook
>>   security: fix documentation for the syslog hook
>>   security: fix documentation for the socket_post_create hook
>>   security: fix documentation for the task_setscheduler hook
>>   security: fix documentation for the socket_getpeersec_dgram hook
>>   security: fix documentation for the path_chmod hook
>>   security: fix documentation for the audit_* hooks
>>   security: fix documentation for the msg_queue_* hooks
>>   security: fix documentation for the sem_* hooks
>>   security: fix documentation for the shm_* hooks
>> 
>>  include/linux/lsm_hooks.h | 127 
>> ++++++++++++++++++--------------------
>>  1 file changed, 61 insertions(+), 66 deletions(-)
>> 
>> --
>> 2.17.2
>> 
