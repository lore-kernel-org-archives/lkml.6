Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D751CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70342073F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfACCiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:38:25 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:38346 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfACCiZ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 2 Jan 2019 21:38:25 -0500
Received: from linux-fcij.suse (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 02 Jan 2019 19:38:20 -0700
Subject: Re: Shaohua Li
To:     Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <398a74fa-6566-8d0d-6434-e68ff3763656@kernel.dk>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <af940531-2535-2777-8c09-e9d1e6c16e82@suse.com>
Date:   Thu, 3 Jan 2019 10:38:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <398a74fa-6566-8d0d-6434-e68ff3763656@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/19 1:13 AM, Jens Axboe wrote:
> Hi,
>
> I've got some very sad news to share with you - over Christmas, Shaohua
> Li passed away after battling cancer for most of last year.

It is really a sad news and a big lost for the community consider Shaohua's
great contribution!

> As you know, Shaohua acted as the maintainer for md. He remained
> dedicated to that through the difficult times. With his passing, we
> obviously have a void that needs to be filled.

It is better if there is a small team to maintain md in future since nobody
have broad/deep knowledge as Neil or Shaohua, also people in the team
can cover/backup each other, see [1].

> For now, I'll act as interim maintainer for md until we can find a good
> permanent solution. I'll queue up reviewed patches in a separate branch,
> in the block tree, and help review fixes. I'm subscribed to linux-raid,
> but please do CC me as well.

Thanks, I think there are some patches in shli/md/for-next which supposed
to be merge to 4.21, could you please help to merge them to your branch?
And I suppose you will send a patch to CREDITS for Shaohua.

[1]. https://lkml.org/lkml/2015/12/21/9

Regards,
Guoqing
