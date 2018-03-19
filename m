Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521464189; cv=none;
        d=google.com; s=arc-20160816;
        b=xymiea6f0bENbOxWwU9/iXIFrCAC2rvFgL71grDoh/G6dFvkRP7+YPWiuVRtJgSRqO
         rUoeKS2cZlaepf67MNkNcKhpKIeIbm917CTTcKLlquEV74gqjvSJVu5OpHrYjg9ildFl
         k9IeKHeNZJOp29T8a+NYng8rbMIbiWifs5sT1GTCnKEKsQU++bGx10Fg6ul+gwXqhJlJ
         LoHs85JRj4ppCzJRghWeJAGF1atU6csxxplc0QXIyppB6EoULE3x02I3pzDxLB++pJUd
         u3hZE+DvGMP7+riKpD+qtsZ9FRvsX7a8Eibeqx7fGCUxE9mX3ain/TprKURWFX3GP7x9
         SZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7/I47SIXfD7bVoDpB8//MPJnkPSpE1X1Y9VoURDz+lQ=;
        b=OUMVXqOo+/fQW3CMLJtzXIWx9sg/NSWFd5ej2f+2Q9PXn8OlCNYlh/bEDo6deV/Ljp
         ee+pHTYwOHZnj5DARiePVoOa9ShHt/qlhu+Iy84+MmXJHrptg5fyOSdWazFBprKh67K4
         v3P6uH/NMSZL4x/nuh8/1yU9NYcaQv4uUVmeWAQC6Tb75EYg3+emiiOGAxyeRnrUB0eS
         jQY/uyrqSAD/ngkqRJqUQva1JpsXwNGFOIj32JoGfXWXfrxkStoij9iYT1e3+oao0usJ
         wFmiULX1RDRbfdPSeKE6+sN5dRHLcsxAZsa4ot2qShdzcl6rREABSijcjGiooXH+yq9Z
         ZyAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fsI2pYy4;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fsI2pYy4;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELt04KjcTZ3NB/g4VvR5vkC9RXlHYeyxocN9lqFVNyVw5YQCcPKsSNCSs1hh7goFE2ugVajMvA2B/VV9gCdnTU4=
MIME-Version: 1.0
In-Reply-To: <2c828644-8797-2ec7-fbd7-a6ef21fa1356@axentia.se>
References: <20180319091721.18193-1-brgl@bgdev.pl> <20180319091721.18193-5-brgl@bgdev.pl>
 <b1602ac6-04cd-a415-ee66-79533a5af4a3@axentia.se> <CAMRc=MdwmCr+OW-_DgKretCmTHc9oukODwN+Mw6FcaUuSD9nCg@mail.gmail.com>
 <2c828644-8797-2ec7-fbd7-a6ef21fa1356@axentia.se>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Mar 2018 13:56:28 +0100
Message-ID: <CAMRc=Mc3AYVDscyj-RsCDZCD4X7pR5V5QdOJsOde9r2mcz_t4A@mail.gmail.com>
Subject: Re: [PATCH 04/21] eeprom: at24: use SPDX identifier instead of GPL boiler-plate
To: Peter Rosin <peda@axentia.se>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357056282465424?=
X-GMAIL-MSGID: =?utf-8?q?1595370833704603754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-19 13:51 GMT+01:00 Peter Rosin <peda@axentia.se>:
> On 2018-03-19 13:12, Bartosz Golaszewski wrote:
>> 2018-03-19 12:03 GMT+01:00 Peter Rosin <peda@axentia.se>:
>>> Also, use a // style comment for the SPDX line in C files.
>>
>> I'm seeing both /* */ and // style comments used for SPDX headers - is
>> there any reason not to use /* */ here?
>
> Documentation/process/license-rules.rst states:
>
> 2. Style:
>
>    The SPDX license identifier is added in form of a comment.  The comment
>    style depends on the file type::
>
>       C source: // SPDX-License-Identifier: <SPDX License Expression>
>       C header: /* SPDX-License-Identifier: <SPDX License Expression> */
>       ASM:      /* SPDX-License-Identifier: <SPDX License Expression> */
>       scripts:  # SPDX-License-Identifier: <SPDX License Expression>
>       .rst:     .. SPDX-License-Identifier: <SPDX License Expression>
>       .dts{i}:  // SPDX-License-Identifier: <SPDX License Expression>
>
> Read more in that file for reasons. If there are none, I personally
> think the reason is that "Linus said so". Or something like that?
>
> Cheers,
> Peter

Makes sense, thanks.

I'm thinking about dropping this file from this series and submitting
it separately for Greg to Ack.

Unless he sees our exchange and acks it here. :)

Thanks,
Bart
