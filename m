Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280535-2-11655475127885484903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280535; b=kIYqE3EIEs0frN5VsPPeIKHBOcLg69chDXMtTT+I/QUpTuatv3
    uFvYeXwzgYqcYv6mZU3KjXsmRtoO2ru8YCNG98ncKhdC4EOKJCBAw2iWKDyfGR2L
    BEI1Ww5yNCy7YK2KmwaqWhB4r18pXKNH3WTv7k8Y600ctzlISeQZN88+5lhybuM/
    OTVXgYqngeFTScfVD85eZd6J3tuAoXGnc77aROPgLLmRQ5FTgxMWg0cGkXTrz4Uy
    YBWv7oC2K3x4rmU10xUDYaoH8qxJGY8x72cEBuNBK0vn1tIRi9vH3JEJG/3GZmZp
    Mt3i6zb1lWIVMB59OZdc4kFkAtNq7GY8kU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526280535; bh=XdbEW18x3LrTfOm7/WaNHialxR3/MyQ1TPqDImd9z3
    E=; b=NwI3rfM0MSfMJOR09+rqZZ5Y/DXr4rZy/9ZMv1ekyppXoO9y2CptBC8yc5
    k2vQ0XUZe5+t9MbqQ2PJRNxogmRX9tvkPo5mfBwoInT2lt+ZgZ2P68HZvHfh4mGS
    QWV5BeA9hCJbNUM2Oc9OQ3LP8JgigqtsYQzUhn9qNw+JB6je/slFmLzxKqaR0hdq
    8oycgesS3jICNrs+XaWO8kExbSGGzo6JYwug5i8m/gJUQB6rZw9dbVinB4MUpTi6
    5tN1rzfZqDXmg7gPhNCcs2H/HqPnNzxGPh+m9fOXqs8AUoW+OaxBch9OWvnz7rtJ
    DNv7/lweypNiymXa82FCr+AbsYZg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=KSfDRmeW x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=VA4jS+tI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=KSfDRmeW x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=VA4jS+tI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAUaTWHcOw5adw2LrFwarvB45eoQoecL0OVEN10i9sAiBSuIpsnveO3j9OSdF7TP/tMXopnGCm3NQbPzPhE2ZYoXul1bx3gJmEfiKPCVW7WkjWTLS93f
    LQp3/DIdGKJMZeqQU3168l6HvslsOK83qbRYMmVtN/1cZPgxPmGbkL1ZZZeBds1+5u7RSyjNvsRWKwwjbS5vPOgeEFwDaBl5PCWlcZa5usFP4uni8x6fknPu
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=8G9TCRtoaTifEwJRT8cA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeENGsy (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 02:48:54 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38668 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeENGsx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 May 2018 02:48:53 -0400
X-Google-Smtp-Source: AB8JxZqZ6/fyKSmFpso4/gv7A+MUFHKoMVTs1hdaEUyHcocmg45TStO9x/I2clcG5L89H7CuE3vtCTBiFCxlDYS6fyU=
MIME-Version: 1.0
In-Reply-To: <20180514064701.GC16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-18-ard.biesheuvel@linaro.org> <20180514064701.GC16596@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 May 2018 08:48:52 +0200
Message-ID: <CAKv+Gu9nud17L+FhMwbTb9AaVd0+qRgqXU1_c4K+GCH-=uhpxQ@mail.gmail.com>
Subject: Re: [PATCH 17/17] efi/libstub/arm64: handle randomized TEXT_OFFSET
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 May 2018 at 08:47, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> From: Mark Rutland <mark.rutland@arm.com>
>>
>> When CONFIG_RANDOMIZE_TEXT_OFFSET is selected, TEXT_OFFSET is an
>> arbitrary multiple of PAGE_SIZE in the interval [0, 2MB).
>>
>> The EFI stub does not account for the potential misalignment of
>> TEXT_OFFSET relative to EFI_KIMG_ALIGN, and produces a randomized
>> physical offset which is always a round multiple of EFI_KIMG_ALIGN.
>> This may result in statically allocated objects whose alignment exceeds
>> PAGE_SIZE to appear misaligned in memory. This has been observed to
>> result in spurious stack overflow reports and failure to make use of
>> the IRQ stacks, and theoretically could result in a number of other
>> issues.
>>
>> We can OR in the low bits of TEXT_OFFSET to ensure that we have the
>> necessary offset (and hence preserve the misalignment of TEXT_OFFSET
>> relative to EFI_KIMG_ALIGN), so let's do that.
>>
>> Fixes: 6f26b3671184c36d ("arm64: kaslr: increase randomization granularity")
>> Cc: <stable@vger.kernel.org> # v4.7+
>> Reported-by: Kim Phillips <kim.phillips@arm.com>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Tested-by: Kim Phillips <kim.phillips@arm.com>
>> [ardb: clarify commit log]
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/firmware/efi/libstub/arm64-stub.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
>> index b9bd827caa22..541b82fdc8a2 100644
>> --- a/drivers/firmware/efi/libstub/arm64-stub.c
>> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
>> @@ -97,6 +97,13 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>>               u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
>>                            (phys_seed >> 32) & mask : TEXT_OFFSET;
>>
>> +             /*
>> +              * With CONFIG_RANDOMIZE_TEXT_OFFSET, TEXT_OFFSET may not be a
>> +              * multiple of EFI_KIMG_ALIGN, and we must ensure that we apply
>> +              * the offset below EFI_KIMG_ALIGN.
>> +              */
>
> When referring to config variables in comments and changelogs I'd suggest a bit
> more verbosity:
>
>   s/CONFIG_RANDOMIZE_TEXT_OFFSET
>    /CONFIG_RANDOMIZE_TEXT_OFFSET=y
>
> ... because at first I thought (based on the name) that
> CONFIG_RANDOMIZE_TEXT_OFFSET is an actual integer offset value - while it's a
> bool. The =y makes the bool nature obvious.
>
> ( Similarly, when negated the canonical way to refer to it is
>   !CONFIG_RANDOMIZE_TEXT_OFFSET. )
>

Fair enough.

>> +             offset |= (TEXT_OFFSET % EFI_KIMG_ALIGN);
>
> The parentheses are not needed here I think.
>

Nope.

Will you fix this up when applying? Or should I resend?
