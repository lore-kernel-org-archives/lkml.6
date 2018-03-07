Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeCGOhM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:37:12 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44659 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbeCGOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:37:09 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180307143707euoutp029b1e6f39035cb825dfa0a9e4f7a5df54~ZqiWAJkhk2970829708euoutp02H
X-AuditID: cbfec7f4-713ff700000043e4-30-5a9ff9111f67
Subject: Re: Regulator regression in next-20180305
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>,
        linux-omap@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From: Maciej Purski <m.purski@samsung.com>
Message-id: <339dfd3e-5c5d-1e91-8890-5bfb69049d12@samsung.com>
Date: Wed, 07 Mar 2018 15:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180307141027.GD7290@sirena.org.uk>
Content-type: text/plain; charset="windows-1252"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87qCP+dHGRz/a2axccZ6VoupD5+w
        WTy86m+x6fE1VovLu+awWcxe0s9isfbIXXaL/Ve8HDg8vn2dxOKxc9Zddo9NqzrZPDYvqffo
        27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujF1TPzMXvOSq6Pon1sB4laOLkZNDQsBE4vDi1exd
        jFwcQgIrGCXOfG9jg3A+M0qc+zGRBaaq+cU0FojEMkaJY/PamCCcZ4wSO1p/sYNUCQsYSWzf
        1MoKYosIKEtc/b4XrINZ4AGTxKnL6xm7GDk42AS0JNa0x4PU8ArYSVw984INxGYRUJXoObYU
        bJuoQITEwqlPGSFqBCV+TL4HFucEmn9mcSdYPbOAo8SDRTtZIWxxiebWmywQtrzE5jVvmUH2
        SghcZpO4fnsxI8QLLhJ3V25ig7CFJV4d38IOYctIXJ7cDfVmtcTFr7ugamokGm9vgKqxlvg8
        aQszxAI+iUnbpjOD/CIhwCvR0SYEUeIhsWzJXqgxjhIb1k4Bu01I4AKTxPo/IhMY5WYheWcW
        khdmIXlhFpIXFjCyrGIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMMaf/Hf+yg3HXn6RD
        jAIcjEo8vBv2z4sSYk0sK67MPcQowcGsJMJ77+P8KCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        cRp1UUIC6YklqdmpqQWpRTBZJg5OqQbGHQpL5r2VvDC1qOsi09LKg9xfFQQjXsyXOrfj0/vk
        r/HTgg/4LtGe0Dfr/zfT4MDbLOd2MfB8mO8WsiDW9d+cs+atazNVAss2ixw/LHLQmeuAtFGt
        1vm7bL/ubDr5Xd/u6cndF5N8bQ9V7zrxrCEspPTs3Hij7CbVY/9uqJgqCb268Ofu7QwGEyWW
        4oxEQy3mouJEAK/BxNstAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xq7qCP+dHGWxYIGmxccZ6VoupD5+w
        WTy86m+x6fE1VovLu+awWcxe0s9isfbIXXaL/Ve8HDg8vn2dxOKxc9Zddo9NqzrZPDYvqffo
        27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujF1TPzMXvOSq6Pon1sB4laOLkZNDQsBEovnFNJYu
        Ri4OIYEljBJbWn6wQjjPGCVOvJ7LCFIlLGAksX1TKyuILSKgLHH1+16wDmaBB0wS6369Zofo
        uMAksX/aLaAMBwebgJbEmvZ4kAZeATuJq2desIHYLAKqEj3HlrKA2KICERKdK+ezQNQISvyY
        fA/M5gRadmZxJ1g9s4CtxIL361ggbHGJ5tabULa8xOY1b5knMArMQtI+C0nLLCQts5C0LGBk
        WcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYC9uO/dyyg7HrXfAhRgEORiUe3g3750UJsSaW
        FVfmHmKU4GBWEuG993F+lBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe8waVUUIC6YklqdmpqQWp
        RTBZJg5OqQbGQ58kdkY2ivQ8Etm0XuH+w/yoGvNf3xqWV8nU+ledXP1nhUnby6z5hz7oiksf
        e8v8xaKvji/ggvj1Jf2qN/883P3DSuKFPfvGbJ+nbk5z5Pgf1ySwfPr7M2RywpwML4E5+Sfl
        vpy7z3uXnev4gx+iSw85Nd5aJuJ6Y7HKs7QWjRXtv45dWXlCTomlOCPRUIu5qDgRAIHWej6B
        AgAA
X-CMS-MailID: 20180307143705eucas1p1bbc5ee9462e3e495dba732504c1482f2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef
X-RootMTR: 20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef
References: <20180305231246.GB5799@atomide.com>
        <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
        <CGME20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef@epcas2p1.samsung.com>
        <20180306163035.GE13586@sirena.org.uk>
        <bb1adc11-40ff-d37d-60f1-d6e706b058a6@samsung.com>
        <20180307141027.GD7290@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/07/2018 03:10 PM, Mark Brown wrote:
> On Wed, Mar 07, 2018 at 01:57:12PM +0100, Maciej Purski wrote:
> 
>> I'm trying to figure out what is so special about these boards. The only
>> strange thing, that I haven't noticed at first, is that all regulators share
>> a common supply - dummy regulator. It is defined in anatop_regulator.c.
> 
> No, that's a regulator framework thing - the regulator framework will
> use the dummy regulator as a supply when there's nothing described in
> the DT so long as the client doesn't explicitly tell it that the supply
> might be optional.
> 

Ok, thanks for explanation. I think I have found a possibly dangerous scenario, 
but I can't see this situation possible in Fabio's case.

Assume, that we have a chain of supplies, consisting of at least 3. Say: A->B->C.

When we're setting voltage on A, we lock it, call balance_voltage(), lock 
suppliers and call set_voltage_rdev(). So we have regulators A, B, C locked. 
Then set_voltage_rdev() is trying to set voltage of its supply by calling 
set_voltage_unlocked().

Now we're on the regulator B. Set_voltage_unlocked() calls balance_voltage(), 
which again locks its supplies, if they exist. B's supply is C, so we end up 
with having a deadlock on regulator C.

Tony and Fabio, do you find this scenario possible on your boards?

Best regards
Maciej Purski
