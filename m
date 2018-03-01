Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELsRS+EPgXYGtM6q2+hcwlHcK5jQQkMAXei5h/MDJ47nGaxgjeRNkaHs845sIQM3oKsBrUlp
ARC-Seal: i=1; a=rsa-sha256; t=1519863447; cv=none;
        d=google.com; s=arc-20160816;
        b=yJkAl7EK+YNc7p9Tffn9o1n9YGz6Ykzy1gcAmLcMACOl7FiCMvXjUPVlm0JQQqXy75
         oKD881eYL7DiWZ7EKi0tcv6G6kTkv8McY3gxOAmVkNEBJAnBlQKyb6HiJZ5mrj63ZbUe
         p7QZdLmTYcfjmOOLklEUHp8sTUHB0kzCtwaEsvkzkEZ1u9uZDmN/+Ccv0gnY1UbtgdQJ
         b0SKYmSY8q4ehKNjldfwT3iK1h2J+J9F0VpXL4pTP8HGv07YvDLNGekH59R549LQTiKK
         DuCs8g+yDccshxkiA/p6GBnppEf6rVrw+AES/FN9N6mw3jYPvE6/XrLOJ3G1eKkx1R28
         ZgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=xUIikl3EOVxsfw61OTIgaXvLivNeO5Cpr7DxdQJrD1Y=;
        b=FEKnzazSIgdU4ompTsiEu0BON65af1iH0872NLaxydJrxlgPlqOgdn9IB8Mvk5kE01
         spPIchwofuKalmgL3RkwFDTUpAKAX/slEkTVgmV1drIFuvJKbUNioNQAq8iXprfvJtZe
         yfI0Pc3ABiT1PVL3/jnmzW4CxMOnYH4+XCRviIiBTFoXmqFYw4MMqa/WsO9eKb38lghR
         F5QNVwnfYyLXpFjydHg4W3n4dpxEjTmB5PLk29ZtfDKUO/MU5lOLlUwr79xvG4nG2fhQ
         sYYQFE0Kao6fwkY8+7KdIWq0h0T65CsAXbDYE2409nowOiI3AdbZOHuhtu8oXtD9VjOq
         VtjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=iaJ0MMoj;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=iaJ0MMoj;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w210HAIk028053
X-Nifty-SrcIP: [209.85.217.180]
MIME-Version: 1.0
In-Reply-To: <a83b79e2-3db1-efb4-9122-46708b36b58a@infradead.org>
References: <CAK-=9LoRtOjN9_jCxtHf_fLeh3NpW6KOgYNuD09PKbDkCaCajg@mail.gmail.com>
 <1519853553-10626-1-git-send-email-arvindprasanna@gmail.com> <a83b79e2-3db1-efb4-9122-46708b36b58a@infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 09:16:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQuoc1fc4mLzrixUjsrbtZceZ7aY_4SHNFeGxAan1JaGQ@mail.gmail.com>
Message-ID: <CAK7LNAQuoc1fc4mLzrixUjsrbtZceZ7aY_4SHNFeGxAan1JaGQ@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: Update ncurses package names for menuconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Arvind Prasanna <arvindprasanna@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593692334191779770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-01 6:47 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 02/28/2018 01:32 PM, Arvind Prasanna wrote:
>> The package name is ncurses-devel for Redhat based distros
>> and libncurses-dev for Debian based distros.
>>
>> Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com>
>
> Thanks. Looks good to me.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>


Randy, thanks!  Eagle eyes!

I will replace it with v3.



-- 
Best Regards
Masahiro Yamada
