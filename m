Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521461571; cv=none;
        d=google.com; s=arc-20160816;
        b=yWwo+QN28MNFoMabqFoythsITRFPyiYR+KoiB2XHwUPgpMEJQ37euft5mdf0U3iI8B
         U/aXJbUEBq+NbRKVHdmjvT9hhcZzP7i2mMnmO87MC+clGUgUUj/V2OXScd3QMWmEnXib
         kh8lZhXs3yp7AYtAqTdEZ+feAGxhcAA6xOct3CVayoN7yKu2YQT//HgGb+A4W34b7JyC
         je2jb7AHQhpTL8urdtEyO0vcKFhEgpVsijohGWuw+2Cr4soKODRB1bPL+4ED/sxS3OZ2
         vVbbFsrTzWUSPfn9W/Pb8A2IFs6dE2u2hMJ8MzFUYQ7pkaa6K2Fz8ObHVioTkfhhE66n
         tnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xfbJWKdwvP8DwBGOvewiCM++7Q8qR+fbX3XWqddogo0=;
        b=fdGhpG7WLuSG7kNasYvITKv/gEiuDZlx8tET7Ng/+GllYgEqh9wYwTGfSPlLMClejW
         zLbhsVfukZLcoZZ1ryfpPam8Lj25Ew/SEz6NhLq1qbTSCtU8vMvX4tjeyr5Pyx+I9pC6
         HM3K/VwUEmok3lraDr/ER9Ztcok3IYAkn8/Ox+3ZVR9GZJBxIJJxLLsFgEhupslLeTf4
         j5QbOePeQeCjn6z9yVnYqogkfl0g7I6aIk06uYJYH7rbbsBAtqOcJSyMJTq5GF2g9qBQ
         9M4LC6KfRu0wfl0Tq03wlZJ9OEFQrDnJYKGap5cFf2p6awn3hguiTsnYkiuUVvCAlDpn
         Ua1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=isw8oAtv;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=isw8oAtv;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELv6MVht3UM7v9Ls4kAHT73FeN2DIIqWnYGonADXiGXzyc74TfPo/cXY1/t8kBl2foUh24Y1A47WGpiGvJCa9XU=
MIME-Version: 1.0
In-Reply-To: <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
References: <20180319091721.18193-1-brgl@bgdev.pl> <20180319091721.18193-5-brgl@bgdev.pl>
 <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Mar 2018 13:12:51 +0100
Message-ID: <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL boiler-plate
To: Peter Rosin <peda@axentia.se>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357056282465424?=
X-GMAIL-MSGID: =?utf-8?q?1595368089335159694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-19 12:03 GMT+01:00 Peter Rosin <peda@axentia.se>:
> On 2018-03-19 10:17, Bartosz Golaszewski wrote:
>> Replace the GPL header with an SPDX identifier for GPL-2.0.
>
> Great care should be exercised when dealing with copyrights of others.
>
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  drivers/misc/eeprom/at24.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 2a4154eeb1bd..0e06201d33c9 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -1,14 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>
> This should be 2.0+

Indeed, thanks.

>
> Also, use a // style comment for the SPDX line in C files.
>
> Cheers,
> Peter

I'm seeing both /* */ and // style comments used for SPDX headers - is
there any reason not to use /* */ here?

Bart
