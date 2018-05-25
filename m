Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967641AbeEYR73 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:59:29 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:36902 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967386AbeEYR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:59:28 -0400
X-Google-Smtp-Source: AB8JxZr0udcbBh9R7lmmRDqEfYwvm4Jc2YMHq7MTP5g1FDeyR0MicgtlFT5w7eiq9u/5y2/TyCYhBGbIZDzzeEehr0g=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
 <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com> <CAKwvOdkEHqv7Ut8H6Rb+gSvfWsMHqO=E3f7yxm=06m9yEn=h6w@mail.gmail.com>
 <26B017D5-4063-46CB-8768-B0E5E7CD3838@zytor.com> <CAKwvOdk_4g5PsRUoLgOeWEwt+d0diyD_Ycx6s7LQsJrSMsBEuA@mail.gmail.com>
 <319FB971-ABB6-4BE7-969B-D87D84853196@zytor.com> <CAKwvOdmryseROx=iSs6CZ86-tr90Fni8RC_w6Y7nFSXGW=508g@mail.gmail.com>
 <31A5469A-176F-451F-886A-ECD649DDC78C@zytor.com> <CAKwvOdkpWZC4vWK8hDdgUGseTmK4Hz5uDHn_mP9yc=jbfdVPmg@mail.gmail.com>
 <12a870df-5f9d-94d1-8318-42cfff1bedab@redhat.com> <CAKwvOdnq-H2M=psJMxo7k7HiEvZVY+z+4+geONwNZdBC9VmhvQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnq-H2M=psJMxo7k7HiEvZVY+z+4+geONwNZdBC9VmhvQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 25 May 2018 10:59:15 -0700
Message-ID: <CAKwvOd=TURLq4TUtfskoq-5+uPEXfguHaE=rWkUTBvjACO=4Jg@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: tstellar@redhat.com
Cc: hpa@zytor.com, Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 10:49 AM Nick Desaulniers <ndesaulniers@google.com>
wrote:
> gcc 8.1 and trunk inserts a `ud2` instruction (what?!) (let me see if I
can
> repro outside of godbolt, and will file a bug report).

Filed:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85927
-- 
Thanks,
~Nick Desaulniers
