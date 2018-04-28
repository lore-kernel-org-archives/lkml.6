Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeD1VmQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 17:42:16 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39388 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeD1VmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 17:42:14 -0400
X-Google-Smtp-Source: AB8JxZpnAJaBpWx7c6Wri/kpB6+8H4p33RK3y4+fwvQnyuFczbt7HaFdy828ecV2KEfwUC9CgLTTJ5xcmmzw7FRgst4=
MIME-Version: 1.0
In-Reply-To: <bd125268-a685-ba6e-efc4-130a0621855f@infradead.org>
References: <CAG=yYwnMXFxHxCnYNWCb-HhpAb21kc5_e_6q-N_DRGhMVurPMQ@mail.gmail.com>
 <bd125268-a685-ba6e-efc4-130a0621855f@infradead.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 29 Apr 2018 03:12:12 +0530
Message-ID: <CAG=yYwnq1KwAmKL5t=KFTMcRY9rDFM_5XBDNpbvzM-8J-U7TKQ@mail.gmail.com>
Subject: Re: PROBLEM: error due to conflicting types during build of kselftests
To: Randy Dunlap <rdunlap@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3SLgQ0C023780

anyway my current is gcc (Debian 7.3.0-16) 7.3.0

may be you can try ... make -C tools/testing/selftests 2> error.txt

On Sat, Apr 28, 2018 at 5:08 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/20/2018 11:03 AM, Jeffrin Thalakkottoor wrote:
>> hello,
>>
>> the following is the error found...
>> -----------------------------------------------------------------------------------
>> protection_keys.c:421:5: error: conflicting types for ‘pkey_set’
>>  int pkey_set(int pkey, unsigned long rights, unsigned long flags)
>>      ^~~~~~~~
>> ------------------------------------------------------------------------------------
>>
>> to reproduce this error...
>> make -C tools/testing/selftests
>
> Hi,
>
> I can't reproduce this problem.  What is your gcc --version?
>
> Thanks.
>
>> Details about software:
>>
>> Linux debian 4.17.0-rc1+ #1 SMP Thu Apr 19 18:59:45 IST 2018 x86_64 GNU/Linux
>>
>> GNU Make             4.2.1
>> Binutils             2.30
>> Util-linux           2.31.1
>> Mount                2.31.1
>> Linux C Library      2.27
>> Dynamic linker (ldd) 2.27
>> readlink: missing operand
>> Try 'readlink --help' for more information.
>> Procps               3.3.14
>> Kbd                  2.0.4
>> Console-tools        2.0.4
>> Sh-utils             8.28
>> Udev                 238
>>
>
>
> --
> ~Randy



-- 
software engineer
rajagiri school of engineering and technology
