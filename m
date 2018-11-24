Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9DCC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E4620868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 03:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E4620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davidnewall.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbeKXO2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 09:28:34 -0500
Received: from hawking.davidnewall.com ([203.20.69.83]:46078 "EHLO
        hawking.rebel.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeKXO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 09:28:34 -0500
Received: from [172.30.0.109] (124-169-190-170.dyn.iinet.net.au [::ffff:124.169.190.170])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by hawking.rebel.net.au with ESMTPSA; Sat, 24 Nov 2018 14:11:40 +1030
  id 0000000000064BC2.5BF8C875.00006B31
Subject: Re: Official Linux system wrapper library?
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Daniel Colascione <dancol@google.com>
Cc:     nd <nd@arm.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <87efbbvrx9.fsf@oldenburg.str.redhat.com>
 <a50dbc52-b5e8-6684-508d-b96ad8d70d4f@davidnewall.com>
 <b0c3ecce-c4d0-246d-d702-21674f950e34@arm.com>
From:   David Newall <glibc@davidnewall.com>
Message-ID: <98843299-f064-8582-76d8-46217de2626f@davidnewall.com>
Date:   Sat, 24 Nov 2018 14:11:38 +1030
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b0c3ecce-c4d0-246d-d702-21674f950e34@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/18 1:53 am, Szabolcs Nagy wrote:
> On 23/11/18 14:11, David Newall wrote:
>> On 24/11/18 12:04 am, Florian Weimer wrote:
>>> But socketcall does not exist on all architectures.  Neither does
>>> getpid, it's called getxpid on some architectures.
>>> ...
>>> I think it would be a poor approach to expose application developers to
>>> these portability issues.  We need to abstract over these differences at
>>> a certain layer, and applications are too late.
>> Interesting.  I think the opposite.  I think exposing the OS's interfaces is exactly what a c-library should do.  It might also provide
>> alternative interfaces that work consistently across different platforms, but in addition to, not instead of the OS interface.
> you don't understand the point of the c language if you think so.

I understand the point of C, thank you very much, and we're talking 
about the C library, not the language.  I don't understand the point of 
your rudeness.

