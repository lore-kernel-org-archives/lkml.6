Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932157AbeAaR2t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:28:49 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35346 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeAaR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:28:45 -0500
X-Google-Smtp-Source: AH8x22546KsuXeyHgjpAPsdbMeRxQx26KDQcwJNqqe70oo3paJmz+GmmCfG+j1DFAk2s3Kd4h/50cj3MGWQJlHIzrh8=
MIME-Version: 1.0
In-Reply-To: <20180131.104328.1248759408605241628.davem@davemloft.net>
References: <20180130190555.6577-2-ulfalizer@gmail.com> <20180131.103221.1934691300422846830.davem@davemloft.net>
 <CAK7LNATA-5mjztcPed43ERLd3AvOh7Lg6yGmH4iqKhKMVP324A@mail.gmail.com> <20180131.104328.1248759408605241628.davem@davemloft.net>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Wed, 31 Jan 2018 18:28:44 +0100
Message-ID: <CAFkk2KSC=ZLU0N3MMG2_EVBqoYxLn2TEeRapBDLHjiX043GPMg@mail.gmail.com>
Subject: Re: [PATCH 01/10] net/sched: kconfig: Remove empty help texts
To: David Miller <davem@davemloft.net>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 4:43 PM, David Miller <davem@davemloft.net> wrote:
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date: Thu, 1 Feb 2018 00:37:27 +0900
>
>> 2018-02-01 0:32 GMT+09:00 David Miller <davem@davemloft.net>:
>>> From: Ulf Magnusson <ulfalizer@gmail.com>
>>> Date: Tue, 30 Jan 2018 20:05:23 +0100
>>>
>>>> In preparation for adding a warning ("kconfig: Warn if help text is
>>>> blank"): https://lkml.org/lkml/2018/1/30/516
>>>>
>>>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>>>
>>> Applied.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> I had applied the whole series into linux-kbuild.
>>
>>
>> Do you want to apply it to your tree?
>
> I already did :-)
>
> It won't cause any problems for it to be in both of our trees so let's
> just leave it this way.

Yeah, sorry about that mess. I had assumed this would require
coordination from more people. :)

Masahiro: Thanks for merging it so quickly!

Cheers,
Ulf
