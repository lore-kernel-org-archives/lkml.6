Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333FAC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA52F20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HrZFyFH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA52F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbeGXWLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:11:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388765AbeGXWLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=564sf8dJM7q6oLia5o1lXvXCGX460MgoMxzBV52TK0Q=; b=HrZFyFH9jJ27JphCrMkNaay2Dl
        hCRG1JOH1scJYL1xTw9+XzMkCkVcENcsVKZwpfqBngaSVJk3IdNAi9M+6ICq4C4z6n859BKGWug8k
        in5hTunYNxIN0WZLqPU10X3U8BhmFuDoRnTFGa6JiMpvkEzUWZgnl9bhkiPmcedDIdAP0GvWY1voV
        UHxRAdhJFy5x/FhgLE45B804eS9ZNCuaO4/gCk3qfKgLro+8GnW+j/hudAGgD+HQvmFhe2W2WJavk
        VJtjpXvbjQSicEt20oVA4nQMsi97UAgzsVynFzimHJrtUZdgSSu/bfWj929gfbAFLd08CT/OiTFSC
        462vwJpA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi4S1-0004JP-Md; Tue, 24 Jul 2018 21:02:33 +0000
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Joe Perches <joe@perches.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20180724111600.4158975-1-arnd@arndb.de>
 <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5cf9579-5d61-dafc-5109-b86bfca07dce@infradead.org>
Date:   Tue, 24 Jul 2018 14:02:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 02:00 PM, Andrew Morton wrote:
> On Tue, 24 Jul 2018 13:13:25 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> Almost all files in the kernel are either plain text or UTF-8
>> encoded. A couple however are ISO_8859-1, usually just a few
>> characters in a C comments, for historic reasons.
>>
>> This converts them all to UTF-8 for consistency.
> 
> Was "consistency" the only rationale?  The discussion is now outside my
> memory horizon but I thought there were other reasons.

kconfig tools prefer ASCII or utf-8.

email tools probably likewise.

user sanity?

> Will we be getting a checkpatch rule to keep things this way?



-- 
~Randy
