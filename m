Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-122591-1519954116-2-5972790371393922527
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519954115; b=elXJc1fS4bZS0LjdBOdDDTrYKz+F3gBrOdr8BIDQp6eGGCa
    0kq+MJU1XSVUKqHaelhSBy7LFYB98wHmbKuSo4FjkuzRHANhVO2wrkE4GUwhkPga
    rAlwuPLnP29ukwGJGFh+UZESKXpTz2TT2hInyzZecnOV7AtVcQRAimILpUhXgkfl
    DXWEdJowNuvlVIUxV7+hTdI8Je9Hghm+cXWpojBYkrWMpagvjFcnRPXKZoB3ztMJ
    pkpouYJJNhgy7TEI/zLYLdRcVIOBmFTWsJjIJhc55euYirmwj6FMzzkGzMxbo2Vo
    FhF0ym/lLZ4E7vZdNKVL7h48u5F6OfhX3VSscmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519954115; bh=q
    4lbwK5lA+8z6Znl60VwtFU3Hq3bCWjmmv+Ne4BlOx8=; b=W4BS2oUt6YBeiW3UZ
    Bu6A5nPXWPpKpVIMZXEekKQKHpPJaTawMgceP7mk3vUN3ForHPte7y/IA6SeLmLV
    h714x4XB6rsD8aGG3zOym7HdTxgfE2L5Blba/haGu/2ZfuSBY5uEmJJCW1p00l6m
    qjKx2T5YKZ1Wj/CE+E9oJiXk88e3GrsGFnFvT4gGlIfs92/UFxP3q3lE7xAJMwgy
    4HVrP7X/wyeE4ZpfOSO0KU5VLfCnuuTuHR0CKzgrMTTxRWmCw9UjKhrr3HDuVQEO
    O0JWgwN50W2gcTvumsb+mV1t82D4VDf3Etnt4plWUnxCLy/X8CYcoTLTLSK5Pd55
    VfrLw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsiP873LU5GH0vkgtNGnbxZbKPpHwUHtOq52GzF/KrSnlnEPD+8gBkAfwRxyJn56uTLuJqEzzb0/fBIVoXX5Fo=
MIME-Version: 1.0
In-Reply-To: <20180301205436.GE4059@eros>
References: <20180301051911.1314-1-quytelda@tamalin.org>
 <20180301051911.1314-3-quytelda@tamalin.org>
 <20180301063721.GD4059@eros> <20180301111500.lxge4yqfyi2najt6@mwanda>
 <20180301205436.GE4059@eros>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Thu, 1 Mar 2018 17:28:26 -0800
X-Gmail-Original-Message-ID: <CAFLvi239G_PpzUtzV2W1pi5fW+N-KW_W2O+h_-fTfv=-FwdDCg@mail.gmail.com>
Message-ID: <CAFLvi239G_PpzUtzV2W1pi5fW+N-KW_W2O+h_-fTfv=-FwdDCg@mail.gmail.com>
Subject: Re: [PATCH 3/5] staging: ks7010: Factor out repeated code into
 function 'ks_wlan_cap()'.
To: "Tobin C. Harding" <me@tobin.cc>
X-Provags-ID: V03:K0:9FVGCvHTeDnqyMlXS/oAxWbHA7O7DNlIB0SJHbQ+2c4z9uykHJ7
 agiMc8IukQBp1sUZQexPNCgzafafUgSyQ/qG7ZRiIjrSqgdKnPEW9i+uW0kOFB7SMdLXuwO
 kc1NQsyYZd0x4jK7ECO8XduHppE32aTSYwCjM2m3dd58b5VJzDuX27GUqFBJWAIYNSz6qa4
 GZ7UetCy4QdNwzX9YmKsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BC09yLJG9o4=:F6hJ7aV9DxKhBMsbBN0wvr
 E/l5a5F1XRRSzqN3C1QO38tDjdGXHSG1lbwsMrLcC2aDfLKZmnOQu+VC4tk/ZSPBPefn5Sb6R
 OtUC089gZHK4nze3fzNHE2Bq0OeaURp0t91a/4kJnPoBTe9+02EczBioxs/wnoj7vyVNKEyXZ
 3PP0gNyNfciEN/9DHkMQLSCd53KAw7P1/ePTLgsua6VOWeOmnhf8NqJR+lZp4/ym47D6mA/IH
 ui+OMo6prbUpB5DC+YfLWes1ENGGY4MfljhDaqHt4hFNHp3Baq4hgz2AJLFoaeZtBA0G3TdxV
 Sk0e3X+x021k9bimrr7g6WmH0z3ELRezl7zzQroFM58TB5xbzoa5ZMNc0T6SDtpr0NN02t3OR
 FqQ8pBOCo1OpvpKwob3rXKMGfi4w4V/CPTdux+Iz4gJ32+Shvl+bJpgyLS8RVB1GivHNKkLKn
 GGN6J8leHQIfVJ+c1xqImkHyP0XbJV1zcTPDObUN+iHYjtuQHxht84OVNv9T9D2YXLYCKeXNH
 tLIl67J3fjH/JCmQGYZCzniIC8x3+NTJhG67wXAdC0ISk9kE9Wc0FsEBWD0i0XbrgJhGbbifm
 3W9zZ51BPBHMKQBlhd97mcZBygdrHFP1Dt2ST9xEFnqUy3NjO7/NvzD7RZWXP3Su2WiIJFiX9
 4uP5HthP3slO0t0ksIx9MEoUaQivTAWZecvyvPwYdGzKnrt/xfGEPDtusbVFjbYI6uSDrW93A
 6AGoaXnrHstsRNrHsHA5spAvMJve7SbYVKf5FtgHcGkzBFmc0SWYehbfGhQ=
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, wsa@the-dreams.de,
 Greg KH <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tobin,
I understand your point, and I've read submitting-patches.rst.  I made
that wording choice because I was looking at some older commits that
were worded like that.  I'm fairly new to the kernel workflow, so I
was just trying to emulate something established, and it sounded less
stilted than my imperative attempts.  However, I will word my change
logs in the imperative as best I can in the future.

Thank you,
Quytelda Kahja

On Thu, Mar 1, 2018 at 12:54 PM, Tobin C. Harding <me@tobin.cc> wrote:
> On Thu, Mar 01, 2018 at 02:15:00PM +0300, Dan Carpenter wrote:
>> On Thu, Mar 01, 2018 at 05:37:21PM +1100, Tobin C. Harding wrote:
>> > On Wed, Feb 28, 2018 at 09:19:09PM -0800, Quytelda Kahja wrote:
>> > > The code that generates a WLAN capability mask is repeated in five
>> > > functions.  This change refactors that code into a new function, which is
>> > > called now in each of those functions.
>> >
>> > Perhaps in future something like:
>> >
>> > Code to generate the WLAN capability mask is duplicated five times
>> >
>> > Add helper function to generate WLAN capability mask, refactor code to
>> > use newly defined function.
>> >
>>
>> I honestly don't see the difference between that and what Quytelda
>> wrote?  I understood the original changelog just fine.
>>
>> regards,
>> dan carpenter
>
> I had a feeling that the sentiment of the suggestion I was trying to get
> at didn't come across, thanks for pointing it out.  I was intending to
> suggest not using sentences like this
>
>         > This change refactors that code into a new function, which is
>         > called now in each of those functions.
>
> And instead use, as suggested in submitting-patches.rst, imperative mood
>
>         Refactor code into new function ...
>
> FTR I find the English bits of kernel dev (and programming in general)
> the most difficult even though English is my first language.  I would
> like to write it better.
>
>
> Hope this helps,
> Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
