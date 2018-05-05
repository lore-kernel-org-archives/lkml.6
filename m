Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeEEK37 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:29:59 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:39100 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeEEK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:29:56 -0400
X-Google-Smtp-Source: AB8JxZqvHdwGP2xqI+zmDKhX6mlaCjPNFhTA69dDp9YFHMSQLFx0aVNzsH7AYWxAWj+5aZrSXSEGqkQGEQcF7PjxM+4=
MIME-Version: 1.0
In-Reply-To: <14D3FF3C-0F70-4F72-B381-318B61B944CA@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <aaac818909d71523726094b1dfacc03e756874e9.1524933096.git.hns@goldelico.com>
 <CAHp75VfD4gYesEw2n4JMycmr=qcAtqSkAAjwCViJZRYC6kVUVg@mail.gmail.com>
 <4F016FCD-04B0-4EE1-A9F4-5A182DD437EF@goldelico.com> <14D3FF3C-0F70-4F72-B381-318B61B944CA@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 5 May 2018 13:29:55 +0300
Message-ID: <CAHp75Vfqcezf-WKuAamVJLDLdNStJCb0X7hB1+45TctM-iDUUQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] gpio: pca953x: fix address calculation for pcal6524
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexandre Courbot <gnurou@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>, kernel@pyra-handheld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 10:30 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>> Am 02.05.2018 um 14:35 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

>>> Suggested-by ?
>>
>> Detecting that we need to adjust the registers generally was from me,
>> but your suggestion of an improved formula should of course be mentioned
>> and appreciated!
>>
>> I'll think about a good formulation for v6.
>
> Would the following commit message be ok for you?

Yes, it's perfect.

>
> ...
>
> Therefore, we have to add code to the 24 bit accessor functions
> that adjusts the register number for these exended registers.
>
> The formula finally used was developed and proposed by
> Andy Shevchenko <andy.shevchenko@gmail.com>.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>


-- 
With Best Regards,
Andy Shevchenko
