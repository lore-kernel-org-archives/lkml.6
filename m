Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeDMRjr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 13:39:47 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:38858 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeDMRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 13:39:40 -0400
X-Google-Smtp-Source: AIpwx48kId1GOJCD5n9oZNwKYVC1nEclW+eS2cQBRQ9aj/yc6B98s6o7MTe23Y97ZVi9zAg4IR7TR3VUozWBA+w0Itg=
MIME-Version: 1.0
In-Reply-To: <20180413165000.2svg2j5ozdd2egbd@ninjato>
References: <CAP9bUy7rONNHYeRkYtaWHcfqoZcGKXJz-JocED26zBj9n+-ZbQ@mail.gmail.com>
 <20180413164405.127522-1-hansens@google.com> <20180413164405.127522-3-hansens@google.com>
 <20180413165000.2svg2j5ozdd2egbd@ninjato>
From: Sam Hansen <hansens@google.com>
Date: Fri, 13 Apr 2018 10:39:19 -0700
Message-ID: <CAP9bUy6_sGreanxger04mtyHAVSb0tyFe8Ji0+ocUUxTh9C+3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Documentation/i2c: adopt kernel commenting style
 in examples
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 9:50 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> -  int adapter_nr = 2; /* probably dynamically determined */
>
> Such comments are actually OK.

Ah, gotcha.  Thanks for the correction.  Standby for revised patch set.

>
>> -    /* ERROR HANDLING; you can check errno to see what went wrong */
>
> Such as well.
>
>> -  /* Using I2C Write, equivalent of
>> -     i2c_smbus_write_word_data(file, reg, 0x6543) */
>> +  /*
>> +   * Using I2C Write, equivalent of
>> +   * i2c_smbus_write_word_data(file, reg, 0x6543).
>> +   */
>
> This is the only broken one AFAICT.
>
