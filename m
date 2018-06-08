Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id T7/FIFEQG1tAdwAAmS7hNA
	; Fri, 08 Jun 2018 23:25:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 64B58605A2; Fri,  8 Jun 2018 23:25:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6EBA601C3;
	Fri,  8 Jun 2018 23:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6EBA601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeFHXZC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:25:02 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.163]:31879 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752945AbeFHXZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:25:01 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id F1029400C7FB2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 18:25:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RQkef8mEyBcCXRQkefyx0w; Fri, 08 Jun 2018 18:25:00 -0500
X-Authority-Reason: nr=8
Received: from [187.192.46.223] (port=45484 helo=[192.168.1.70])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89_1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fRQke-002rtF-Ic; Fri, 08 Jun 2018 18:25:00 -0500
Subject: Re: [PATCH] IB/mlx5: Fix memory leak in mlx5_ib_create_flow
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Raed Salem <raeds@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180607191915.GA9092@embeddedor.com>
 <20180608230835.GA24392@ziepe.ca>
 <809fbf8a-e37d-2e92-cecb-37653e38290c@embeddedor.com>
 <20180608232117.GF12577@ziepe.ca>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <45a16ae4-780d-e77b-bed1-e6b76aa21b99@embeddedor.com>
Date: Fri, 8 Jun 2018 18:24:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180608232117.GF12577@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fRQke-002rtF-Ic
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:45484
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Sure thing. I'll send v2 shortly.
> 
> I made the adjustment for you, if it is wrong let me know..
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc&id=2cc82dd58712888758c2d2b405d012f2cd580dd7
> 
> Jason
> 

Seems correct. That's exactly what I was about to send.

Thanks, Jason!
--
Gustavo
