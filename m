Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932201AbeAaPnc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:43:32 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45218 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeAaPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:43:30 -0500
Date: Wed, 31 Jan 2018 10:43:28 -0500 (EST)
Message-Id: <20180131.104328.1248759408605241628.davem@davemloft.net>
To: yamada.masahiro@socionext.com
Cc: ulfalizer@gmail.com, linux-kbuild@vger.kernel.org, mcgrof@kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] net/sched: kconfig: Remove empty help texts
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAK7LNATA-5mjztcPed43ERLd3AvOh7Lg6yGmH4iqKhKMVP324A@mail.gmail.com>
References: <20180130190555.6577-2-ulfalizer@gmail.com>
        <20180131.103221.1934691300422846830.davem@davemloft.net>
        <CAK7LNATA-5mjztcPed43ERLd3AvOh7Lg6yGmH4iqKhKMVP324A@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Feb 2018 00:37:27 +0900

> 2018-02-01 0:32 GMT+09:00 David Miller <davem@davemloft.net>:
>> From: Ulf Magnusson <ulfalizer@gmail.com>
>> Date: Tue, 30 Jan 2018 20:05:23 +0100
>>
>>> In preparation for adding a warning ("kconfig: Warn if help text is
>>> blank"): https://lkml.org/lkml/2018/1/30/516
>>>
>>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>>
>> Applied.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> I had applied the whole series into linux-kbuild.
> 
> 
> Do you want to apply it to your tree?

I already did :-)

It won't cause any problems for it to be in both of our trees so let's
just leave it this way.
