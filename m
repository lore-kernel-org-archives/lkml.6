Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2F4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8231920666
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8231920666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbeIXVW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:22:29 -0400
Received: from mleia.com ([178.79.152.223]:33084 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeIXVW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:22:28 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 2E4AA419BF7;
        Mon, 24 Sep 2018 16:19:47 +0100 (BST)
Subject: Re: [PATCH] MAINTAINERS: Set ARM/LPC18XX architecture orphan
To:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        arm-soc <arm@kernel.org>
References: <1537764195-19117-1-git-send-email-daniel.lezcano@linaro.org>
 <CAK8P3a0YjbCHRHaTzev-rwi5qM3aBeFUUObL1dPKww_o_J_2vw@mail.gmail.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <bfffe304-b42c-b2a2-f164-642469aff640@mleia.com>
Date:   Mon, 24 Sep 2018 18:19:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0YjbCHRHaTzev-rwi5qM3aBeFUUObL1dPKww_o_J_2vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20180924_161947_211978_057DAE56 
X-CRM114-Status: GOOD (  16.10  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Joachim,
 
On 09/24/2018 04:19 PM, Arnd Bergmann wrote:
> On Mon, Sep 24, 2018 at 6:43 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> While sending patches around, Joachim Eastwood was Cc'ed but I got an error
>> its mailbox was full and the mail can not be delivered which makes me think
>> there is no body at the other end of the line.
>>
>> After doing some statistics, it appears the latest commit as author/commiter
>> is:
>>
>> commit b16ebc017ebf52a81e5e88743ccd68fc25e99ba9
>> Author: Joachim Eastwood <manabian@gmail.com>
>> Date:   Mon Oct 31 14:45:17 2016 +0000
>>
>> Remove the maintainer entry and set the component as orphan.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I also checked the github account and any other mails I could
> find from Joachim, which stopped around the same time.
> 
> I've added the lpc32xx maintainers to Cc, as the two platforms are
> related. Maybe they are interested in picking up support for this
> as well, and/or merge the two directories into one (there is only
> one trivial file in mach-lpc18xx, the rest are drivers).
> 

I'm interested in maintenance of lpc18xx/lpc43xx, I have one board
powered by LPC4357, so it would make the maintenance easier for me,
also multiple controllers are equal on lpc18xx/lpc43xx and lpc32xx,
and thus familiar to me.

And I greatly appreciate Joachim's contribution, all platform drivers
written by Joachim are of perfect quality.

I'll send a patch to MAINTAINERS later on.

--
Best wishes,
Vladimir
