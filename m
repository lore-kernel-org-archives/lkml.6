Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA31C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ADE21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeLZJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:48:30 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:44404 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeLZJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:48:30 -0500
Received: from [10.193.189.121] (harsh.asicdesigners.com [10.193.189.121])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id wBQ9mIC1007973;
        Wed, 26 Dec 2018 01:48:19 -0800
Subject: Re: linux-next: Signed-off-by missing for commit in the crypto tree
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atul Gupta <atul.gupta@chelsio.com>
References: <20181223231304.1654cf1d@canb.auug.org.au>
 <20181223123011.qxwfkoib6zadd2rn@gondor.apana.org.au>
From:   Harsh Jain <harsh@chelsio.com>
Message-ID: <3bb5d08e-27c3-a088-6584-6f42e241c1a1@chelsio.com>
Date:   Wed, 26 Dec 2018 15:18:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181223123011.qxwfkoib6zadd2rn@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23-12-2018 18:00, Herbert Xu wrote:
> On Sun, Dec 23, 2018 at 11:13:04PM +1100, Stephen Rothwell wrote:
>> Hi Herbert,
>>
>> Commit
>>
>>   6501ab5ed4d9 ("crypto: chelsio - Reset counters on cxgb4 Detach")
>>
>> is missing a Signed-off-by from its author.
> Hi Stephen:
>
> I believe the issue here is not a missing sign-off from the author,
> but rather that the author was incorrectly set to Harsh who sent
> the email rather than Atul.
>
> Harsh, please add a From header to the patch description in future
> so that the Author field is set correctly.
oops, Will take care next time. Thanks.
>
> Cheers,
