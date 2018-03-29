Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC2KNC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:13:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38999 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeC2KM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:12:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180329101255epoutp02913d30552e69be0d962f05b7b37ec929~gXH9PXflV2191221912epoutp02h
X-AuditID: b6c32a48-8d9ff70000000ff2-68-5abcbc27c224
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on
 HP DL380G3
Date: Thu, 29 Mar 2018 12:12:52 +0200
Message-id: <1597679.yzYZqmDdA5@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <alpine.LRH.2.21.1803291153070.12825@math.ut.ee>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7bCmua76nj1RBmeWyVoc2/GIyeLyrjls
        Fi3vW9kcmD1u7t/P7vF5k1wAUxSXTUpqTmZZapG+XQJXxqqVfAXf2Co2rn7M0sC4j7WLkZND
        QsBE4tyhz4wgtpDADkaJholsXYxcQPZ3Rok59ycBORxgRVMmp0PENzBK9NzrY4VwvjJKHHiy
        FaybTcBKYmL7KjBbREBBomnJYhaQZmaBQIkLS+JBwsICkRLHWrtZQGwWAVWJhrU7mUFsXgFN
        iX8vmsBaRQW8JLbsa2cCaeUUsJXYu1YQokRQ4sfke2CtzALyEvv2T2WFsHUkzh5bxwhyjoRA
        B5vEp53t7BCPuUj8m3AY6klhiVfHt0DFpSWerdoI1dDMKPFtxx5miMQERok964UgbGuJw8cv
        Qm3gk+g4/JcdEhC8Eh1tUCUeEsd2rIZqdZTYsucwCyRMDjFKfPlxn3kCo+wsJIfPQnL4LCSH
        L2BkXsUollpQnJueWmxUYKJXnJhbXJqXrpecn7uJERzZWh47GA+c8znEKMDBqMTDa7Fod5QQ
        a2JZcWUu0CoOZiUR3vcaQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8bQEuUUIC6YklqdmpqQWp
        RTBZJg5OqQbGabvZzW4YHX0etiHzlXbZ5GqDX1sy+xgP/2cRu5I46duhx4L3TnDrBv9pZVyU
        5mnhsDTExOwJ77t4hkcbWWT+a6/fPDe9cMIHqWXrbEx4JS5lRudyP6u8v87XsMzbzqj91tzd
        F9oyeKMnb4nxUE38Y7v/daeSzRdj4ckcxpOPs1YHyu+vOD9diaU4I9FQi7moOBEAx5Yz+OgC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsVy+t9jQV31PXuiDF7PY7Y4tuMRk8XlXXPY
        LFret7I5MHvc3L+f3ePzJrkApigum5TUnMyy1CJ9uwSujFUr+Qq+sVVsXP2YpYFxH2sXIweH
        hICJxJTJ6V2MXBxCAusYJa7+X8UM4XxllFjx9RFjFyMnB5uAlcTE9lVgtoiAgkTTksUsIDaz
        gL/E3MuvmUFsYYFIiQOXLrKC2CwCqhINa3eCxXkFNCX+vWgC6xUV8JLYsq+dCWQxp4CtxN61
        giBhIYE8iZ3n37BAlAtK/Jh8D2q8vMS+/VNZIWwtifU7jzNNYOSfhaRsFpKyWUjKFjAyr2KU
        TC0ozk3PLTYqMMpLLdcrTswtLs1L10vOz93ECAzFbYe1+ncwPl4Sf4hRgINRiYfXYtHuKCHW
        xLLiytxDjBIczEoivO81gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphak
        FsFkmTg4pRoYuT6bMd0snx26l39B2AaV7FO/dp5weScSpumwrzl0foBI08fuzqnrP/68nP2d
        u1HA7u+3S45/+P/pNEw6uk+3u6hLb8UxrtUxa1n2d5t8TBX1zZhX5yKfGC1u2ppk5iIesPti
        luBj/dO8ay94PvtppRl64ffWTXs1rkhKmcruvlv1aBNrpVurEktxRqKhFnNRcSIA0qbgXUEC
        AAA=
X-CMS-MailID: 20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f
X-RootMTR: 20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f
References: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee>
        <alpine.LRH.2.21.1803291153070.12825@math.ut.ee>
        <CGME20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Thursday, March 29, 2018 11:54:09 AM Meelis Roos wrote:
> > 4.16 git bootup on HP Proliant DL380 G3 pauses for a a minute or two and 
> > then continues with "blocked for more than 120 seconds" message with 
> > libata detection functions in ther stack - 
> > async_synchronize_cookie_domain() as the last. It seems to happen during 
> > IDE CD-ROM detection (detected before but registered as sr0 after the 
> > warning). After detection, the eject button on the drive did not work.
> > 
> > 
> > pata_serverworks is the libata driver in use.

There were no changes to pata_serverworks since 2014 and libata changes
in v4.16 look obviously correct..

> This is still the same in 4.16.0-rc7-00062-g0b412605ef5f.

Any chance that you could bisect this issue?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
