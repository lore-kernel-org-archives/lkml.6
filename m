Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7228CC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7BB20868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547756813;
	bh=JdvdAGzx5pNUYFjJjXdouqCCX55bICLVqQ4ixl5Me04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HalvMjYVSI27Z4D3262Q+OstKy/HiJnknni9llQ+Yu9tDnctOWpCU/+cTRxJclqWj
	 bvPfAO+Dcehh92AhK+O+i3FWgQ+b+HQTKEnnPNx1KmVYfPCUrPsOZ+DH5IvWlmwLN9
	 HrkKz+8ez/CtcWJg16hrJ/SeVde9gegUp6565vPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfAQU0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbfAQU0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:26:50 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4DFD20855;
        Thu, 17 Jan 2019 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547756810;
        bh=JdvdAGzx5pNUYFjJjXdouqCCX55bICLVqQ4ixl5Me04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0LpKW5+bxSZMhUF2gV3AZhJIEgi/ORZZPhxE4KEdjeYVLD7F2YAQfGWmKaSrIZBTk
         mIxKC03IELwRYt4b7XpQLOuqTUZu/BOu/UGURit+rh1oDOwobdPZifh6c8pX234o+e
         NL1obv67KwPUz6koNWeuNp6Jt0DjClBzolzpX5+k=
Date:   Thu, 17 Jan 2019 15:26:48 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Dexuan-Linux Cui <dexuan.linux@gmail.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Adrian Vladu <avladu@cloudbasesolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        apilotti <apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH] hv_netvsc: fix typos in code comments
Message-ID: <20190117202648.GD202535@sasha-vm>
References: <20190103194308.4217-1-avladu@cloudbasesolutions.com>
 <BN6PR21MB011407C0A4C2EC0BE7A3DB41CA8D0@BN6PR21MB0114.namprd21.prod.outlook.com>
 <CAA42JLa3QEYg4-LbHem9=7ahSbte3czWAJzxRXiWvt2phxeW_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAA42JLa3QEYg4-LbHem9=7ahSbte3czWAJzxRXiWvt2phxeW_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:18:18PM -0800, Dexuan-Linux Cui wrote:
>On Thu, Jan 3, 2019 at 4:13 PM Haiyang Zhang <haiyangz@microsoft.com> wrote:
>> > From: Adrian Vladu <avladu@cloudbasesolutions.com>
>> > Sent: Thursday, January 3, 2019 2:43 PM
>> > To: linux-kernel@vger.kernel.org
>> > Cc: Adrian Vladu <avladu@cloudbasesolutions.com>; KY Srinivasan
>> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
>> > Hemminger <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>;
>> > David S. Miller <davem@davemloft.net>; apilotti
>> > <apilotti@cloudbasesolutions.com>
>> > Subject: [PATCH] hv_netvsc: fix typos in code comments
>> >
>> > Fix all typos from hyperv netvsc code comments.
>> >
>> > Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
>> >
>> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> > Cc: Sasha Levin <sashal@kernel.org>
>> > Cc: "David S. Miller" <davem@davemloft.net>
>> > Cc: "Alessandro Pilotti" <apilotti@cloudbasesolutions.com>
>> > ---
>>
>> Thanks.
>>
>> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
>
>Looks good to me.

Queued for hyperv-fixes, thank you.

--
Thanks,
Sasha
