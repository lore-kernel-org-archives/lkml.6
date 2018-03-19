Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521474197; cv=none;
        d=google.com; s=arc-20160816;
        b=W7xaqHNtV9A3n/oiH6VGpxSHv/p78AFpaXG3UjpTNFU2q67aLaZI4QNTIfp/DynnjU
         Loso16bLSI6nAef+Xtq6Jia5wuIeiQSEECWGUzWA6OXlKnIOY5sR5whc38MjgjvVjoHT
         1V12/4XzK4Ay+AtuiIWtaRvEwQRlryjkRRglzkyVT7fK13ETbtHlSBxGTktrQ1rcam2C
         bJmVMd/FAWaoaVqMPLIwQZCC0EDqG8n+s3q+iuwOCHt2+Bv6mbIAmkyKtU6zV91BTI9n
         bitYlEA5IplGZl7pwdqz4nf5DjGvX1iOWJBFVh/XdiHrEati9wU4HGPe7EVnVLUwoEML
         8lJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UCy2hIR5BT3ip1ga5BtzCA9frRSNw1Wa7FzFRXQItaQ=;
        b=eNSaw9K9uEP3MzMcigcS3FfdB6ES+ZQEUUA4bRKWrmndMmkCg+QGP+NAYuMYk2mjqM
         R44cBnwPuFkdUgpzc9D0reTss2794WVybctdoM1FqQ6OknVBDcvxm+50xJO/3M+gBdTe
         AKhqvPVqBSPymHPwREeA06OI+BwAYdEN4oTV58qMZ4I34wb2qVcyDfDYZc2qhNMVuEMU
         eFbyvnU8C8hjN5pNdJhb0TmcBIiOfmPFxovecKOWfTMPHY+gizH6gjW7YLKxKVdKHge/
         RAZuxTaeQxRZGW67Nhslq9qRe4MDA4xqs7sch+Vdi2k/OMCwK76No0yuOADYJ8yjkOO7
         RqYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=MtDw4azw;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=MtDw4azw;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELup8kkU9aUt4OPscD+RpdKWpWDCUOjLTOxfkx3MmisjsvzZkbdL04quTI2xuaVd2/Bha03VnU2CQF8+Fln+6Us=
MIME-Version: 1.0
In-Reply-To: <20180319153822.GB23694@kroah.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <20180319091721.18193-5-brgl@bgdev.pl>
 <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se> <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
 <2c828644-8797-2ec7-fbd7-a6ef21fa1356@axentia.se> <CAMRc=Mc3AYVDscyj-RsCDZCD4X7pR5V5QdOJsOde9r2mcz_t4A@mail.gmail.com>
 <20180319153822.GB23694@kroah.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Mar 2018 16:43:16 +0100
Message-ID: <CAMRc=Me7XA89CYn-y-uVHuntyC-Dk65_6kwcPxmwR0V-Ch5ayg@mail.gmail.com>
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL boiler-plate
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357056282465424?=
X-GMAIL-MSGID: =?utf-8?q?1595381327626240070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-19 16:38 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, Mar 19, 2018 at 01:56:28PM +0100, Bartosz Golaszewski wrote:
>> 2018-03-19 13:51 GMT+01:00 Peter Rosin <peda@axentia.se>:
>> > On 2018-03-19 13:12, Bartosz Golaszewski wrote:
>> >> 2018-03-19 12:03 GMT+01:00 Peter Rosin <peda@axentia.se>:
>> >>> Also, use a // style comment for the SPDX line in C files.
>> >>
>> >> I'm seeing both /* */ and // style comments used for SPDX headers - is
>> >> there any reason not to use /* */ here?
>> >
>> > Documentation/process/license-rules.rst states:
>> >
>> > 2. Style:
>> >
>> >    The SPDX license identifier is added in form of a comment.  The comment
>> >    style depends on the file type::
>> >
>> >       C source: // SPDX-License-Identifier: <SPDX License Expression>
>> >       C header: /* SPDX-License-Identifier: <SPDX License Expression> */
>> >       ASM:      /* SPDX-License-Identifier: <SPDX License Expression> */
>> >       scripts:  # SPDX-License-Identifier: <SPDX License Expression>
>> >       .rst:     .. SPDX-License-Identifier: <SPDX License Expression>
>> >       .dts{i}:  // SPDX-License-Identifier: <SPDX License Expression>
>> >
>> > Read more in that file for reasons. If there are none, I personally
>> > think the reason is that "Linus said so". Or something like that?
>> >
>> > Cheers,
>> > Peter
>>
>> Makes sense, thanks.
>>
>> I'm thinking about dropping this file from this series and submitting
>> it separately for Greg to Ack.
>>
>> Unless he sees our exchange and acks it here. :)
>
> I can't ack a patch that is incorrect :(
>
> Please fix it up and resend...
>

Oh yes, sure, I was just waiting for more reviews before resending v2.
It's 4.18 material anyway.

Thanks,
Bartosz
