Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62AC46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802BD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802BD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeIKGKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:10:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbeIKGKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:10:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 646C035D51841;
        Tue, 11 Sep 2018 09:14:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Tue, 11 Sep 2018
 09:14:00 +0800
Message-ID: <5B9716D6.8020307@huawei.com>
Date:   Tue, 11 Sep 2018 09:13:58 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     <tiwai@suse.com>, <perex@perex.cz>, <lgirdwood@gmail.com>,
        <bgoswami@codeaurora.org>, <plai@codeaurora.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sound: q6core: Use kmemdup to replace kzalloc + memcpy
References: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com> <1536395780-18725-2-git-send-email-zhongjiang@huawei.com> <20180910141928.GI5856@sirena.org.uk>
In-Reply-To: <20180910141928.GI5856@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/10 22:19, Mark Brown wrote:
> On Sat, Sep 08, 2018 at 04:36:19PM +0800, zhong jiang wrote:
>> kmemdup has implemented the function that kzalloc() + memcpy() will
>> do. and we prefer to use the kmemdup rather than the open coded implementation.
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant
> patches.  Look at what existing commits in the area you're changing are
> doing and make sure your subject lines visually resemble what they're
> doing.
I will notice this next time.  Thanks

Sincerely,
zhong jiang

