Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95503C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C760214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547017230;
	bh=OY+Lc5QKsIY+tkQjpaoL2FFgNsV1cnfL3qbgQzTFs98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X/utKLPnyMMII23U8taW4drzDn4zXFW0m7FyqfllwuuEOKxojicNPVRomn4og6Mqq
	 /tH4p7wdmd8BRNmFN2Nkp7ygLT0wRwWMqrUAKopUiBgho6SbSi2YCcX3FSFs0NGzeH
	 4k3xcCvZVRIT4BlhuDqX7HVllK8iDNhCnPCLad/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfAIHA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbfAIHA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:00:29 -0500
Received: from localhost (unknown [106.200.233.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D86620821;
        Wed,  9 Jan 2019 07:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547017228;
        bh=OY+Lc5QKsIY+tkQjpaoL2FFgNsV1cnfL3qbgQzTFs98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwQdesmyd1rch8s1xsIwryWeG7apl3R1EtGmNYV7K7hGvoZNs3KFdjSxpwvxwdjce
         gwbzaOgPA22l0CV8bgKUHvJuFP83xEfPUOJz5MKCwjOPs3i3g/m5tZ6dp+EzKySeI0
         MowzTk7xk9bsEuj1NNzrSJzF/iWSBx4b22faCFgo=
Date:   Wed, 9 Jan 2019 12:28:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Cc:     "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "david.brown@linaro.org" <david.brown@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: About some mail lost and random unsubscribe  issues on this
 dmaengine list
Message-ID: <20190109065851.GW13372@vkoul-mobl.Dlink>
References: <81c9fe2de4b5dac1d5b974f5305e35bf1cf5d127.1544156508.git.shunyong.yang@hxt-semitech.com>
 <ea6c6317dabffdcfa28cdb391b50edce98ce875d.1544156508.git.shunyong.yang@hxt-semitech.com>
 <88ef21bd-4e4f-8cce-39b3-53da45740f0f@kernel.org>
 <79da1c31d3e14e6e91cf6a7cc0fea31a@HXTBJIDCEMVIW01.hxtcorp.net>
 <16bbdd233f1d45249eb2f6592418efd5@HXTBJIDCEMVIW02.hxtcorp.net>
 <b607a505d2974e1d879ba7d7c3488f85@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b607a505d2974e1d879ba7d7c3488f85@HXTBJIDCEMVIW02.hxtcorp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 01:35, Yang, Shunyong wrote:
> Hi, Vinod and All,
>   I found, somtimes, I cannot received some mails from this mailing
> list. For example, I sent my v2 series on 7th, Jan,
> 
> https://patchwork.kernel.org/project/linux-dmaengine/list/?series=62713
> 
> It appeared on patchwork.kernel.org but I haven't received it in this
> mailing list.
> 
> And I found randomly, a month or two months, I am unsubscribed from this
> list automatically. Then I have to re-subscribe the list.

I guess your corporate server is to blame. vger mail list is "know" to 
unsubscribe servers which behave badly, so you need to ask your mail
admins why and try to use other email which is known to be friendly with
vger :)

> Have someone met similar problem as me? Or maybe I missed some necessary
> settings?
> 
> Shunyong.
> Thanks.

-- 
~Vinod
