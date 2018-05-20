Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeETGDf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 02:03:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45297 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbeETGDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 02:03:33 -0400
X-Google-Smtp-Source: AB8JxZorK0KlnDa+Kuno6GdslxvyA+RLwc/Ws5EHlemx7RKvYUerxl34scI//kj47M1a+SenAgiy3VX5FqpkY5eZzB4=
MIME-Version: 1.0
In-Reply-To: <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org>
References: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
 <d4c3b2ab-385d-fe7a-bdb1-2d497d620de5@infradead.org> <CAFkk2KRozscmd4kQSJKwKmY3WpTody7S5XZZObf8SKLF62k6+w@mail.gmail.com>
 <CAFkk2KRkEt3+786QvyjzPPAm+3HDe2+ydzZJpshfdKyUDQVfuw@mail.gmail.com>
 <CAFkk2KRvSxu+x-nb045=3L63KEk5h9URr5QYLPoYp6rqqTR4qA@mail.gmail.com>
 <3d9be2f2-3fbe-411b-8529-0e0847f01346@infradead.org> <CAFkk2KRWon_S--dxYw82cDyGXKTFA6jxrrQwstzLvHPs=6-dqQ@mail.gmail.com>
 <c4ec710f-b2bd-b9f0-c33a-159aa53ca73c@infradead.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 20 May 2018 08:03:32 +0200
Message-ID: <CAFkk2KThash4ShBEwPhObF4dm6S0a_7y9tzbKO4fan9Hfrg4KQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 5:45 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 05/08/2018 09:59 AM, Ulf Magnusson wrote:
>> Hello,
>>
>> I've added incremental search for jumping directly to a symbol now.
>> Regular expressions are supported as well.
>>
>> Some screenshots below:
>>
>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss10.png
>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss11.png
>> https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/ss13.png
>>
>> The last screenshot shows how things might look after you jump to a
>> symbol. The jumped-to symbol wasn't visible in this case, so show-all
>> mode was turned on automatically.
>
> Hi Ulf,
>
> Do I need to save kconfiglib.py in a special location?
>
> With (new) kconfiglib.py and menuconfig.py, I am getting this:
>
> $ make ARCH=x86_64 O=xx64 iscriptconfig
> make[1]: Entering directory '/home/rdunlap/lnx/lnx-417-rc3/xx64'
>   GEN     ./Makefile
> Traceback (most recent call last):
>   File "<string>", line 1, in <module>
> ImportError: No module named 'kconfiglib'
>>>>
>
> and then if I (being a Python novice) copy kconfiglib.py to
> /usr/lib/python3.4/site-packages/ and try again, I get 16 warning messages (below)
> and then this:
>
> A Kconfig instance 'kconf' for the architecture x86_64 has been created.
>>>>
>
> What am I supposed to do now?
>
> Hm, OK, I used the trick that you supplied a few weeks ago and I have the UI now.
>
>     ARCH=x86 SRCARCH=x86 KERNELVERSION=`make kernelversion` \
>         Kconfiglib/menuconfig.py
>
> so yes, a real Makefile target would be nice. :)

Gonna get around to it soon. It's a bit silly that you don't get the
menuconfig through the 'pip' install either. :)

Cheers,
Ulf
