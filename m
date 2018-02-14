Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031013AbeBNOyI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:54:08 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:59637 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030543AbeBNOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:54:04 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180214145402epoutp0281205c698b8f28ffc1fbbfd9ed2ad950~TOOIHrb9R1729517295epoutp02k
X-AuditID: b6c32a45-403ff70000001023-8d-5a844d89b88c
Subject: Re: [PATCH] clk: samsung: Add git tree entry to MAINTAINERS
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <60c7f0d9-ec34-2e76-abfc-a195b0a12d95@samsung.com>
Date: Wed, 14 Feb 2018 15:53:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPe5ndc6CMG+5Sr6JjLJiF2xztH5rzWm1Xnr77sL8osrmQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7bCmqW6nb0uUwZuXLBYbZ6xntbj+5Tmr
        xfnzG9gtPvbcY7W4vGsOm8WM8/uYLNYeuctucfGUq8WPM90sFqt2/WF04PJ4f6OV3eNyXy+T
        x85Zd9k9Nq3qZPPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujPPnN7IX7GOu6H4+ia2B8Q1T
        FyMnh4SAicTRjecZuxi5OIQEdjBKLPu8nxkkISTwnVFi8SUlmKKXLcehinYzSqzfeZ0ZwrnP
        KDH57llGkCphAReJKYf3gNkiApoS1/9+ZwUpYhZ4wCRx9VoHC0iCTcBQovdoH1gRr4CdxPMd
        p8DiLAKqEotb/4DdJCoQIbFw6lOoGkGJH5PvgdVwCgRLHPo4B8xmBlrw4sskKFtc4tj9m4wQ
        trzE5jVvwa6TEHjNJrFr0WR2iB9cJP59fskIYQtLvDq+BSouLfFs1UZGiIZ+RomPx/ezQDir
        GSVef9vFClFlLXH4+EVWiBV8Eh2H/wJ1cwDFeSU62oQgSjwkTmw5xAJhO0qcO3EXGkbXGCVa
        psxlmsAoNwvJR7OQfDELyRezkHyxgJFlFaNYakFxbnpqsVGBoV5xYm5xaV66XnJ+7iZGcALS
        ct3BOOOczyFGAQ5GJR7eG5YtUUKsiWXFlbmHGCU4mJVEeI3PN0cJ8aYkVlalFuXHF5XmpBYf
        YpTmYFES520LcIkSEkhPLEnNTk0tSC2CyTJxcEo1MNpcCxd+vLHhxz7fe7za3J4CnxP2VXjK
        nZocVLZqFd81C7avHqf3TGOyunzfbPOlj1k/vhtPP7tzZoz9zq6s9LL86PkPLK4+N3laM+1C
        6GePpZfuv/N5V+13Umxn5smZQp9Td38WrXC3nNwUIn5opaC0GO/T4EkNbjK3X019fzDjw6Wz
        +7nb3kcosRRnJBpqMRcVJwIAAox6NjwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t9jAd0O35Yog5X9ohYbZ6xntbj+5Tmr
        xfnzG9gtPvbcY7W4vGsOm8WM8/uYLNYeuctucfGUq8WPM90sFqt2/WF04PJ4f6OV3eNyXy+T
        x85Zd9k9Nq3qZPPo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujPPnN7IX7GOu6H4+ia2B8Q1T
        FyMnh4SAicTLluOMXYxcHEICOxkl/q/cwAKSEBJ4yChxpS8HxBYWcJGYcngPI4gtIqApcf3v
        d1aQBmaBe0wSS898h+q+wSixvLkPrJtNwFCi92gfWAevgJ3E8x2nwOIsAqoSi1v/gK0WFYiQ
        6Fw5nwWiRlDix+R7YDanQLDEn5NTgGwOoA3qElOm5IKEmQXEJY7dv8kIYctLbF7zlnkCo8As
        JN2zEDpmIemYhaRjASPLKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwFjZdlirfwfj
        4yXxhxgFOBiVeHgNbFqihFgTy4orcw8xSnAwK4nwGp9vjhLiTUmsrEotyo8vKs1JLT7EKM3B
        oiTOy59/LFJIID2xJDU7NbUgtQgmy8TBKdXAmOmz2OTWiYdyTvV3mRQSDoT5XiiefP5bdbRk
        pd7enRf0zR+nXdZufRm/WXN297HnE5tMuA3/v3sfyxPmJVDjrZoXxu+wW8KCXeTBhCq1W/cP
        XH1e/bd+ovpCwSsL7H4f2db3VvN6yK6Cy516x//MdFgj9HTxnSluxh17JELP7fho1Vh99cTF
        g0osxRmJhlrMRcWJAOWRKzmRAgAA
X-CMS-MailID: 20180214145400epcas2p340b512392d3b20cf9253327f6b967850
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4
X-RootMTR: 20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4
References: <CGME20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4@epcas1p4.samsung.com>
        <20180205144158.10500-1-s.nawrocki@samsung.com>
        <CAJKOXPe5ndc6CMG+5Sr6JjLJiF2xztH5rzWm1Xnr77sL8osrmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2018 04:17 PM, Krzysztof Kozlowski wrote:
> On Mon, Feb 5, 2018 at 3:41 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> Add a missing git tree entry for drivers/clk/samsung.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, I have applied the patch to clk/samsung tree.
