Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeB1Bbt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:31:49 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:32142 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeB1Bbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:31:46 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w1S1VdSn004987
X-Nifty-SrcIP: [209.85.213.42]
X-Google-Smtp-Source: AG47ELvgsIVF+e9RN6Cb+SE2upgLKepMC3u647mZKozcfYMJlLg/tB3UoM78TdA6eSOutus4zhQUTEsGezhNwg6qsNY=
MIME-Version: 1.0
In-Reply-To: <20180227223611.vglxasfco524cdy7@ltop.local>
References: <20180227194828.GA29918@bombadil.infradead.org>
 <5a85a7cf-c59c-f338-2087-c9de799adbe8@infradead.org> <CA+55aFxNksRJEwsYFGY3_Zy+wqvQVu3h4Bq3Go3KZpbxE8F6fQ@mail.gmail.com>
 <20180227223611.vglxasfco524cdy7@ltop.local>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 28 Feb 2018 10:30:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjV8jH+BMd0_4v9GeXiizyY9+hAQiBs+sZnz4S3eGB5Q@mail.gmail.com>
Message-ID: <CAK7LNASjV8jH+BMd0_4v9GeXiizyY9+hAQiBs+sZnz4S3eGB5Q@mail.gmail.com>
Subject: Re: [PATCH] sparse doesn't support indirect_branch attribute
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28 7:36 GMT+09:00 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>:
> On Tue, Feb 27, 2018 at 02:12:28PM -0800, Linus Torvalds wrote:
>> On Tue, Feb 27, 2018 at 12:18 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>> >
>> > I don't mind the patch, but I did send a patch for this attribute on Feb. 13, 2018,
>> > to the sparse mailing list.
>>
>> I think the sparse plan is to just stop warning about unknown
>> attributes, because it doesn't really help users (at most it's a note
>> to a sparse developer).
>>
>> But sparse doesn't have the same regular releases the kernel has. Oh well.
>
> To compensate this, I sent a patch  to use '-Wno-unknown-attribute' for kernel
> builds. Masahiro Yamada has already taken it to the linux-kbuild tree.
> I'm not sure if it's planned for the next -rc or for 4.17, though.
>
> -- Luc Van Oostenryck


I am planning to send it in the next MW (i.e. v4.17-rc1)


If you want me to send this earlier as fixes PR,
please let me know.



-- 
Best Regards
Masahiro Yamada
