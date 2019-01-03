Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312AB2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 08:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfACI2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 03:28:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfACI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 03:28:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C0A07CFA3;
        Thu,  3 Jan 2019 08:28:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF20B600C4;
        Thu,  3 Jan 2019 08:28:44 +0000 (UTC)
Subject: Re: Shaohua Li
To:     Guoqing Jiang <gqjiang@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-raid@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <398a74fa-6566-8d0d-6434-e68ff3763656@kernel.dk>
 <af940531-2535-2777-8c09-e9d1e6c16e82@suse.com>
From:   Xiao Ni <xni@redhat.com>
Message-ID: <97912c52-ba6c-f532-d55b-9b0ae1316c61@redhat.com>
Date:   Thu, 3 Jan 2019 16:28:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <af940531-2535-2777-8c09-e9d1e6c16e82@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 03 Jan 2019 08:28:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2019 10:38 AM, Guoqing Jiang wrote:
>
>
> On 1/3/19 1:13 AM, Jens Axboe wrote:
>> Hi,
>>
>> I've got some very sad news to share with you - over Christmas, Shaohua
>> Li passed away after battling cancer for most of last year.
>
> It is really a sad news and a big lost for the community consider 
> Shaohua's
> great contribution!

It's very sad to hear about this. I'm still reading his patches and docs.
>
>> As you know, Shaohua acted as the maintainer for md. He remained
>> dedicated to that through the difficult times. With his passing, we
>> obviously have a void that needs to be filled.
>
> It is better if there is a small team to maintain md in future since 
> nobody
> have broad/deep knowledge as Neil or Shaohua, also people in the team
> can cover/backup each other, see [1].
>
>> For now, I'll act as interim maintainer for md until we can find a good
>> permanent solution. I'll queue up reviewed patches in a separate branch,
>> in the block tree, and help review fixes. I'm subscribed to linux-raid,
>> but please do CC me as well.
>
> Thanks, I think there are some patches in shli/md/for-next which supposed
> to be merge to 4.21, could you please help to merge them to your branch?
> And I suppose you will send a patch to CREDITS for Shaohua.

+1

Regards
Xiao
