Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5D2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0A324927
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0A324927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933612AbeFVVs7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:48:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10228 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeFVVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:48:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2d6eb00000>; Fri, 22 Jun 2018 14:48:32 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Jun 2018 14:48:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Jun 2018 14:48:57 -0700
Received: from [10.110.39.62] (10.110.39.62) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 22 Jun
 2018 21:48:56 +0000
Subject: Re: [PATCH] MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
To:     Palmer Dabbelt <palmer@sifive.com>, <stern@rowland.harvard.edu>,
        <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        <paulmck@linux.vnet.ibm.com>, <akiyks@gmail.com>
CC:     <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180622211703.4121-1-palmer@sifive.com>
From:   Daniel Lustig <dlustig@nvidia.com>
Message-ID: <6b17610f-e54b-9c05-2f28-f4873eff3a4c@nvidia.com>
Date:   Fri, 22 Jun 2018 14:48:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622211703.4121-1-palmer@sifive.com>
X-Originating-IP: [10.110.39.62]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL105.nvidia.com (172.20.187.12)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2018 2:17 PM, Palmer Dabbelt wrote:
> Dan runs the RISC-V memory model working group.  I've been forwarding
> him LKMM emails that end up in my inbox, but I'm far from an expert in
> this stuff.  He requested to be added as a reviewer, which seem sane to
> me as it'll take a human out of the loop.
> 
> CC: Daniel Lustig <dlustig@nvidia.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Looks like there's an accidental backquote before my name?

Once that gets fixed:

Acked-by: Daniel Lustig <dlustig@nvidia.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d5eeff51b5f..b980635220e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
>  M:	Luc Maranget <luc.maranget@inria.fr>
>  M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>  R:	Akira Yokosawa <akiyks@gmail.com>
> +R:`	Daniel Lustig <dlustig@nvidia.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 
