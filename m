Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E058C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F762086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F762086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeICXjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:39:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40414 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbeICXjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:39:00 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JcnvgARzG_hX; Mon,  3 Sep 2018 21:17:08 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF4100329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:4100:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5FCA01EC00E5;
        Mon,  3 Sep 2018 21:17:08 +0200 (CEST)
Date:   Mon, 3 Sep 2018 21:18:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     wufan <wufan@codeaurora.org>
Cc:     'tanxiaofei' <tanxiaofei@huawei.com>,
        'John Garry' <john.garry@huawei.com>,
        'James Morse' <james.morse@arm.com>,
        'Zhengqiang' <zhengqiang10@huawei.com>, mchehab@kernel.org,
        baicar.tyler@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        'Linuxarm' <linuxarm@huawei.com>,
        'wanghuiqiang' <wanghuiqiang@huawei.com>,
        'Shiju Jose' <shiju.jose@huawei.com>
Subject: Re: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Message-ID: <20180903191814.GG10249@zn.tnic>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com>
 <6cc3c5e2-3827-a89c-e37b-09728a34f21f@huawei.com>
 <5B891308.40407@huawei.com>
 <003201d44397$8eb02c20$ac108460$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <003201d44397$8eb02c20$ac108460$@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 09:05:29AM -0600, wufan wrote:
> Thanks tanxiaofei!
> 
> Boris/James, are you OK to sign off, or you want to see more tests on 
> this patch? 

Please do not top-post.

Now, I don't have any problems with it - I'm still sceptical as the
firmware is a stinking pile but if we cannot find a broken case, I guess
we can take this one for a spin and revert it if there's trouble down
the road.

Unless James has objections.

Then, you sent a v2 here:

https://lkml.kernel.org/r/1535654266-40053-1-git-send-email-wufan@codeaurora.org

and you've received a bunch of Reviewed-by's and Tested-by's and a
couple of new comments.

Incorporate *all* of those and send me a v3.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
