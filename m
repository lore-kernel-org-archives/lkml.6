Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-253466-1527499199-2-9624857945470567137
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527499199; b=UB+8QVeqKeZtztVa6I8fRqQjSA/5fOv4VtSiWnuRXK6TRX0hmD
    5Hs2PUHzmNLlrdESLqWQMAelVcoK7wGw6ZnJdsf6gMzRzKRuBQAMa6WHTpPDXa5M
    VTyQMtBCOuy/xxXWrnrZo4Qycb+hVTtftPjgtVWsQv8ZEcZvEr8ptZgSl3cZbW9a
    EfYwtquCvC19DKj2jCs8WblVfu5LvTQKqfXWgogVDyAecmhNOgo0WusnwPRja/Zu
    tp6+gTOUGeeMItFg9FNhkW804b4GdBLf3bMjL7smsuv/wtNaZD9859M0JQlRWR86
    PV7x7d1gpyDBCDPiUR0VZhvgu5uL5lm4L7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527499199; bh=qB3y1DSfeQ5ZP8E+zNFqFQhI7HLv4FzTIzRlorhy8D
    U=; b=eOrPxyP4y056G8uwqbePWOgoL8zu+1bmnFyEsC78G31xP4R7cSsLUhELm7
    Kc0h5NZQwmMd4WFQTkE+mnb1K1bGjGNsHAjEGQS7T3iRJdMLtl4wEJGxxd7+L3Hw
    rQeP4hW8Weq/mUEDZ2X61JelQaI7mZYhskQRc6Ywrte85+HgUZDpH2z5ehAhT1Dx
    UVXDea8eaE9+N4Ss1O8TzaNLe8dP+cVqmsFYr6aCEr6PDAzcRIpuXuLmRWGX4mwM
    7skrL0QEbIvqkKUjBWhvIki4YS8fWaA60W4+DKDC4ZQ2dRylRKi9bXS0sk1NBfqs
    UdfwzARmCaWwr8FLJEfdtubaC/Uw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=AcWcOhNw
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ajA/Pm00;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=AcWcOhNw
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ajA/Pm00;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN8KMscFb18YjJXckOCmLXRLqlZwBOlplOi19bTaspwrIZ/AsBynmFiqrgdyUKNYBrSg78NH1ko1WAZvUShcDt0tWPstaUQH8JfgL0rEYVtUMBywcpRg
    pYftIM4CNmVeRdOkl3ikPqko3jhuQ9+pmViryo/pbd4sSvorNsIxVpKUILTHteN4YEurY3jLAN60dSWaSb8SclrKpk6Cyz8go2w3x9Au7bk+ZjKpDm5B7QEW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hAG5_4vcAAAA:8 a=VwQbUJbxAAAA:8 a=PtDNVHqPAAAA:8 a=6Fu7hv2xAAAA:8
    a=tBb2bbeoAAAA:8 a=VeD6qxPExNqVWWePgFgA:9 a=QEXdDO2ut3YA:10
    a=8Bh8Pg2EFav9IBZ9i9Tn:22 a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
    a=OCr_TKDY-yBPQKLGgHr3:22 a=Oj-tNtZlA1e06AYgeCfH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbeE1JT5 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 05:19:57 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45338 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753984AbeE1JT4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2018 05:19:56 -0400
X-Google-Smtp-Source: ADUXVKIf9JrSFyw4Jp6NUbtQOG+m865V7fuj53wq6ogOCno607ZTKRz8ZTAyXrsDxr+vXtHoOXR8S23fIwc0e1tQYJc=
MIME-Version: 1.0
In-Reply-To: <20180420145514.GP3094@brightrain.aerifal.cx>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-16-ebiederm@xmission.com>
 <20180420145514.GP3094@brightrain.aerifal.cx>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 May 2018 11:19:55 +0200
X-Google-Sender-Auth: zU6cjyyyw831x_2CPz2arPhDhJo
Message-ID: <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 16/22] signal/sh: Use force_sig_fault where appropriate
To: Rich Felker <dalias@libc.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 4:55 PM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Apr 20, 2018 at 09:38:05AM -0500, Eric W. Biederman wrote:
>> Filling in struct siginfo before calling force_sig_info a tedious and
>> error prone process, where once in a great while the wrong fields
>> are filled out, and siginfo has been inconsistently cleared.
>>
>> Simplify this process by using the helper force_sig_fault.  Which
>> takes as a parameters all of the information it needs, ensures
>> all of the fiddly bits of filling in struct siginfo are done properly
>> and then calls force_sig_info.
>>
>> In short about a 5 line reduction in code for every time force_sig_info
>> is called, which makes the calling function clearer.
>>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

>> --- a/arch/sh/kernel/traps_32.c
>> +++ b/arch/sh/kernel/traps_32.c

>> @@ -599,20 +593,17 @@ int is_dsp_inst(struct pt_regs *regs)
>>  #ifdef CONFIG_CPU_SH2A
>>  asmlinkage void do_divide_error(unsigned long r4)
>>  {
>> -     siginfo_t info;
>> +     int code;
>>
>> -     clear_siginfo(&info);
>>       switch (r4) {
>>       case TRAP_DIVZERO_ERROR:
>> -             info.si_code = FPE_INTDIV;
>> +             code = FPE_INTDIV;
>>               break;
>>       case TRAP_DIVOVF_ERROR:
>> -             info.si_code = FPE_INTOVF;
>> +             code = FPE_INTOVF;
>>               break;
>>       }
>> -
>> -     info.si_signo = SIGFPE;
>> -     force_sig_info(info.si_signo, &info, current);
>> +     force_sig_fault(SIGFPE, code, NULL, current);

/kisskb/src/arch/sh/kernel/traps_32.c:606:17: error: 'code' may be
used uninitialized in this function [-Werror=uninitialized]

http://kisskb.ellerman.id.au/kisskb/buildresult/13366052/
http://kisskb.ellerman.id.au/kisskb/buildresult/13366048/
http://kisskb.ellerman.id.au/kisskb/buildresult/13366072/

>>  }

> Acked-by: Rich Felker <dalias@libc.org>


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
