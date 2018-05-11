Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-57561-1526057161-2-10876906474200673194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526057160; b=JxisY6uR657CPVuwvo47wDNWXhHzM/V37/7W4cIgNLeIoONU6t
    gOTMOrYpHfZs+/xCWUjR4DB+qS7vu8TbupvqI32/f5XGmgV/9feZsYArV3JOF4v6
    H5hKXYi7ccIZPj9SR3tEJA/29ZMDHySTILN02ycy9jYrvY257kW8W/0IdqpxJuvq
    Wvp+/BcqG8EO9c2HH9TTp031NduQuPHeUCgzeNSlIff6eeQqTKHDNwrXmHIYnMJK
    zUB1G48vi5gG7S8tvajX0OdkDfW/haSR5ctEhx2Jy3aAinquKuI4C7sk/5L+ZiAO
    yr32gyiLpimnNkRvkx0/M2TjidJc0bkzmBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526057160; bh=YlwWPE0j/SQY/oGGtf1FrJ2R7+ojOkPmgRugUOgRD/
    U=; b=Ud2qgvqKNMoseq1NiA7jetUe47Ejm1TBzjXjZXpHdC2lwlfou/YQpF1SaY
    6k6EUQvfaeQWbOR5mfl27djXpoJWyM6S4E1drmm0uYVOHL/0NrSVC9MPbY+/RRIl
    jOYe0N71Zm97X4OHu+1iIbzestp23SOpDFpzxbNBqGejQ/VTc0i3f0H2IsrkAeix
    OUDkTOVPYoNr2S66+wI0YEg4B4vUyfmRJ9buKki1Rk+neN/7dpUotneCNLKJrH+y
    bEHUipOey597E/EmShJwWST0M9Uz8lVvt3kaH+MhU5GaGj5Osoy3f8H2FOAvmPzU
    loUbFXa0OyNW6BzZnZkuCf1BnGuQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linux-foundation.org header.i=@linux-foundation.org
    header.b=JDTMo7Jz x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=HxiCdFPC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linux-foundation.org header.i=@linux-foundation.org
      header.b=JDTMo7Jz x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=HxiCdFPC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNnQ4QTEwrYE1VpfigYifgKBQ0qDrRE+1SXNk2JbVHEjhDwYCIa77070XCEzpgtQLPlFh8zolzKm769h89Hw6VGnCR3GtiGV7h+OpdfatB3XzdteKCVE
    F4kjt0MD1Z0HsiNBkExTE4UndXxeGtDJaXgr5o71oeMNkXMSFHNHBuMpz4YZQojQWA3XXzfb5zpMGThxQyS5id5Y60tbJlDB389HUaDrrMmYwER6hGQ2hrsb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeEKQpr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 12:45:47 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:42830 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEKQpp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 12:45:45 -0400
X-Google-Smtp-Source: AB8JxZpA4fl/bOlQkAuUJgZoGdASHiKAwkRwphU1Z+mcYExf/f8d3cZriNsbqg7Kof/MxYD39ZpCmf8GEZ8qtrpSB1U=
MIME-Version: 1.0
References: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
In-Reply-To: <20180511093613.GA1330@comp-core-i7-2640m-0182e6>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 11 May 2018 09:45:33 -0700
Message-ID: <CA+55aFxYwH6dw=bsQJHEgkM_iZfVNerqn+RAXrrY2iufJag6Qw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] proc: instantiate only pids that we can ptrace on
 'limit_pids=1' mount option
To: gladkov.alexey@gmail.com
Cc: Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Solar Designer <solar@openwall.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Djalal Harouni <tixxdz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 2:46 AM Alexey Gladkov <gladkov.alexey@gmail.com>
wrote:

> +       /* Limit procfs to only ptracable tasks */
> +       if (limit_pids == PROC_LIMIT_PIDS_PTRACE) {
> +               cond_resched();
> +               if (!has_pid_permissions(fs_info, task,
HIDEPID_NO_ACCESS))
> +                       goto out_put_task;
> +       }

Where did that "cond_resched()" come from? That doesn't seem to make a lot
of sense.

                    Linus
