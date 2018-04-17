Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeDQQ2B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:28:01 -0400
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:34626 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752116AbeDQQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:28:00 -0400
X-YMail-OSG: 8l8sOKkVM1niMbJL.HyoSIYKEEUG7QKuLviKVO96MTfD9TnQL6N7i7VEBTf8D2I
 PpJFw9IJmewMscYyrImfLV_GkT_W6U.F4AIgo69920SvyW849Cf2ehX58UfuJjbeXDy6MKNTY07l
 hQAYMCJ5NEPZUAtMXfjVj26dzF0pT.lf7qcH5BkUAuWvgoWXij6ouSmR2bM9Mx2rlEdvyp155NPW
 jDxOhtF32YmLZxQ_i1zpnFz2Obm3vdi91xGQrH7AN2sZus6agpg.8p6dFCipDdXaaKNJ.o43dS6l
 uuuNf0cc6dPr_juJwRslfMnqqJceKYikm3AGbJNNKPFnen5vec.xzUJJ5Mj_M9PP4BcyOYgACOhW
 lGZOqJKjfs1gEu1235739ehevCLlfZ82QQTDqdKUzCaMgWIDJFaQHqdX1tdxRaOhtgGSyonj6A5i
 yt5scXJiJfTvXjbHXr8gscCUSDZUq2.lMNT22iYgcKL_wH0WtCXkj5rMxwKf.oqQG306mCkegGqk
 EOEEBRGHZJcWgeX5WYqow0P6BpqFnLg--
Subject: Re: On the kernel numbering scheme
To: xDynamite <dreamingforward@gmail.com>,
        "Artem S. Tashkinov" <t.artem@lycos.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <e7b554d738de83268f4fc06dd6f12ada@lycos.com>
 <CAMjeLr-A7z=A3E3yqnZ_PZhekZPxhCDP=Cb0aWhemmv3MNAoPA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <954f8e10-ae72-3175-1bac-ffac6cae10f7@schaufler-ca.com>
Date: Tue, 17 Apr 2018 09:27:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMjeLr-A7z=A3E3yqnZ_PZhekZPxhCDP=Cb0aWhemmv3MNAoPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/2018 5:55 PM, \0xDynamite wrote:
>  > The current kernel numbering scheme makes no sense at all because the
>> first two numbers don't represent anything at all. They had some meaning
>> back in the 1.x 2.x 3.x days but then with the introduction of the new
>> rolling development model, they became worthless.
>>
>> I'd love to change the kernel numbering scheme to this:
>>
>> YYYY.RELEASE.PATCH_LEVEL
>>
>> So that the first kernel to be released in 2019 will be numbered
>> 2019.0(.0),
> If you're going to suggest changes, then you should do it like this:
> Change major numbers ONLY when you've introduced a new incompatibility
> with your API and increment minor numbers for everything else.  THEN,
> the first number WILL mean something.  If your software changes
> something outside the way users communicate with the kernel (major
> changes) and just changes something that COULD affect other software,
> then have multiple partitions in your release number, like 3.5.41.

Release numbering schemes are the ultimate opportunity
for bikeshedding. It doesn't frikking matter. Schemes that
are designed to convey anything more important than sequence
break down eventually. Schemes that convey nothing but
sequence can't be used to emphasize a major change. Let this
sleeping dog lie. You have better things to worry about.
 
