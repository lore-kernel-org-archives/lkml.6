Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A81C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187062173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWahDRRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfBZQVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54184 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfBZQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LhPJVI7lrqcYy6X6t91//uGA79irx6QGQf/lkEml2eI=; b=jWahDRRiRRXeGkZEeWkFHTvsHm
        Gm3522/IuG3KOcRBx6/JinQn9yRee2R5+4lUtLcWLYN1XxpOOgL1/eslaw9olORZyAHXxalktui/s
        c52MA2v4KxspRvx3IQvaoWV7urQ8nRo4OqFRZ7sELjASmPJ4tMu2V1wDbdcuEfN0nx87wAmBiZDtq
        PIzA2yKUgXxoXeCbuC6PpFpemkTyV8ARCE3I8xzwOi97esLu6CmQXtRmYyls74U2U6tRYFuZkCCFI
        HrlYBSIyvuaDjqw4yMoXD5gBGzxETB7Kuoj+sPUkxnyRAM9rOHL7rpWEVobHoKI9Ege+1erZN2P+G
        ohzX7yBg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyfU6-00077W-7y; Tue, 26 Feb 2019 16:21:34 +0000
Subject: Re: linux-next: Tree for Feb 26 (net/sched/sch_pie.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Vijay Subramanian <vijaynsu@cisco.com>,
        Mythili Prabhu <mysuryan@cisco.com>
References: <20190226190859.624e21f0@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ecd1bde-c15b-0568-2b72-6e0796a87864@infradead.org>
Date:   Tue, 26 Feb 2019 08:21:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190226190859.624e21f0@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 12:08 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190225:
> 

on i386:

ld: net/sched/sch_pie.o: in function `pie_timer':
sch_pie.c:(.text+0x604): undefined reference to `__udivdi3'



-- 
~Randy
