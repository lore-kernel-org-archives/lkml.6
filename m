Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2940596-1524139205-2-12282733712088907619
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
    1524139205; b=NUEdE0TxwBt5yxPKq63kkz9nH+f/k8nreU966scvnxtixHJwCF
    BACZ/nIOJlXMiHpMtbXrVyVFh+C21DqluQ7nrY2n/FhqlpmNCcE5yH4v2398I4Lp
    7ctT96z11oJCTbKMxgq0UtbkzSJpVtU1b/vkew82mqan1V7tkqbhzwVUU84cHEpo
    tAUb+hTxussdS7dpwckcTiRDYsUiV1x4kK7mRaLplxH872FGQY2oisNuoD5K74xQ
    8I0ybFhL3VYFOp4WnRLNlTgzGsIE45TwtlvfpHz6kEBJYKdvH0QFsoizNGFADzmT
    BwqO7qG1i3caUil1JNry9Oj0MkzkKhgu6Jcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524139205; bh=AYHhCOoMuBHSYnWiJxp6n5VK3pC6WyuzOnL/I10xtf
    0=; b=pvxi3Y+SkbMNsmg84o1BQLDBef/hfhVsq0OxV4gGfTJCdqYrc56pvNGeJP
    mJz5gazaKaE0C8k1+hlY+JWAqJYNYGp3wFjxSjeE/bOXrzKrWDRV4oEXA9kk6i80
    KUUcrzdsoUaJcfPMwpw/cDQilLUkgrZ5NzY2w7CQAobHCwBqnDHNv0kWRdoJFLKJ
    81ykCQqIytkcHJUIMp6IPtQI/4CcEwfMw29UjV72pGCQJEoAiNcoYT8bIcTmYKmp
    DwRvzKpsd9QweZ60nWV4KbZQkXw5Ikg5q9LQlLvM0+CgPrYGWNhJVKsj9A8t0tmH
    /WijA5RZEYzROZw+gSpGVHj4ZBTg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=K2RKe2xa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g5RssMCL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=K2RKe2xa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g5RssMCL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXxNDbqBuZrT4WS94b8pg+6MN6XG9Y5zMakDXJCntceHotE+nKXpM7cclsSTcDTVnMUIqXnnu47z+Q+uPzNdeKrvnspzB68IRQJQaded4lYRj6uISVZ
    55m83gFxbVJSc92Hmqr191ketRIggpmMc491/VU7Crf/enpQw7SxyHKp7sQoDMkqtgndedRtfBAvVLd7GK5YASUB0uxzpBU15I+GrlFiJBfCS2U1t4qCHHoS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=tBb2bbeoAAAA:8 a=aGTDQ-s0n3k2Yce2JUQA:9 a=QEXdDO2ut3YA:10
    a=l1He_3m2cmAA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeDSMAA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:00:00 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:32800 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeDSL77 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 07:59:59 -0400
X-Google-Smtp-Source: AIpwx4/iKrQ2ZsQMuUKLLs6hCAjW+MYICzqN8vzAXY68cOagcrb9gbg00Bb73QrDviUs0EFWvz36wBDMUQVuyOJ879I=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3vS1AWHGMmGchQOrkV40GESNuJHQfZF-YDtOwZ1Z18Dw@mail.gmail.com>
References: <CAK8P3a0-n-Qabdr+5hwjq8wa9nZHtFwcE32WsW8ZTbKjtpiBUQ@mail.gmail.com>
 <CAK8P3a3vS1AWHGMmGchQOrkV40GESNuJHQfZF-YDtOwZ1Z18Dw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Apr 2018 13:59:57 +0200
X-Google-Sender-Auth: v1a1AOlfoQJfqgAlyneS_gL2UzI
Message-ID: <CAMuHMdXNHaBVMqrQOfBuN+Ro4SC40B9OxCs9HsNM_c4fxcJT0g@mail.gmail.com>
Subject: Re: [tip GIT PULL v2] y2038: timekeeping syscall changes
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,

On Thu, Apr 19, 2018 at 1:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 19, 2018 at 1:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
>>
>>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
>>
>> are available in the git repository at:
>>
>>   git+ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
>> tags/y2038-timekeeping
>
> That one is still messed up. I changed my .gitconfig to have a
> different "insteadof"
> section, but for some reason that failed. Obviously the URL I meant is
>
> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> tags/y2038-timekeeping
>
> I've never figured out how to configure this correctly and try to
> manually edit the
> pull request, but forget to do that half of the time.

I use:

[remote "foo"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/user/foo.git
        pushurl = gitolite.kernel.org:/pub/scm/linux/kernel/git/user/foo.git

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
