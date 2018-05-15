Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeEOWkU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:40:20 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35039 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeEOWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:40:19 -0400
X-Google-Smtp-Source: AB8JxZrp1yXxofx/qQOJLE/sPhHViGZn2o2sg+K8WGZ7eiltqqDgCVJ1w0+pWNvTy00Yd5veHECMPQ==
Reply-To: ahs3@redhat.com
Subject: Re: linux-next 20180515 - ACPI disabled..
To: valdis.kletnieks@vt.edu
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <50539.1526419088@turing-police.cc.vt.edu>
 <CAHp75VdwDPumYBphE0BTE=ngsvGkWKuOr9QjBv4c+yw-1pKBWg@mail.gmail.com>
 <664f2475-9718-d38e-7270-3426c94f86e8@redhat.com>
 <58438.1526423130@turing-police.cc.vt.edu>
From: Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8d3890a3-9875-63fb-bb42-311febec5700@redhat.com>
Date: Tue, 15 May 2018 16:40:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <58438.1526423130@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 05/15/2018 04:25 PM, valdis.kletnieks@vt.edu wrote:
> On Tue, 15 May 2018 15:49:15 -0600, Al Stone said:
> 
>> Not off-hand.  Could you please send me a copy of 
>> /sys/firmware/acpi/tables/APIC
> 
> cat /sys/firmware/acpi/tables/APIC | od -x 0000000 5041 4349 0072 0000
> 3903 4544 4c4c 2020 0000020 4243 3358 2020 0020 2009 0107 4d41 2049 0000040
> 0013 0001 0000 fee0 0001 0000 0800 0001 0000060 0001 0000 0800 0202 0001
> 0000 0800 0103 0000100 0001 0000 0800 0304 0001 0000 0c01 0002 0000120 0000
> fec0 0000 0000 0a02 0000 0002 0000 0000140 0000 0a02 0900 0009 0000 000d
> 0604 05ff 0000160 0100 0000162

Thanks.

>> on this machine?  The commit cd8c65a6442b that I wrote looks like it got 
>> pulled in on 20180430, which if I'm understanding correctly, seems to 
>> have fixed the problem.  Did this work before 20180415?  I assume it 
>> did.
> 
> 0430 is what I'm running right ow, and it works.  Everything before that 
> too. It fell over sometime between 0430 and 0515,

Oh, I see.  I had read "0515" as "0415", hence my confusion.

- -- 
ciao,
al
- -----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
- -----------------------------------
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiclaKI7ZGQ+4GJLWUwywAtdhsWwFAlr7Yb0ACgkQUwywAtdh
sWwshQ//XvOPtjH5kB/OHR0jGP5LQ+9iiyJa40P6UhsW4dTFZbWLWOvhzqrdBJD2
dyA7Xz3ig4zULS1ZAmIpubMixgekGa9VaMtJMumw4CiwqkuphLNnB6gFqZ5QkWS4
YyGwW6zz2RSONf5Lq3K65mr+6cDHMhdtidtEunXzMOC6Ny8ELC52hIr295NpnyXn
sv72SVdy9kQYHfxRv7K1IIbMKJZYRBN3TCoWFFJHbJH0stiLnCk+O+57QcsCKNWH
ECJ6z8+kELo3BD42PLk7cRYoUKnyPsrGn+fAQvLD9rnknjVRPKhVjRilI9qr/HCo
pmj0N9xNcEI0WK2feyN3vzYPeZbzwsxIiiCwd9E+bQIrwq8nI+fbhV6egFZlbwcR
89w3Zhu31s7umcopLLHAEstm4STKOZGS54PdGQFku/Nff4GVes+vvjP1wC3yMEDL
kUeOt5tLWgexEMOdXqo9YaMz2AUeog2Duk1PL27EiHjc4eGbSt1Yb9SgRFln03rH
Orozfqjjwv6G4yWkz6sjZ/0T6ODWa+CW8qTr2WjFH2l2sj3ZT3DoemN4GkYo3O7x
oI+7lKoY31L+GQnKluW6EceliANVmLlgNhlQv5v9i9NYFrgwj8UucJfJVQdJWVKk
uJxhGITkkResHoPOfEuHsJ9Ks5wI22L6RiO9OTX2rr7accsA+aY=
=Vj8z
-----END PGP SIGNATURE-----
