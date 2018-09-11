Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9900EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEAE20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lfm7xvsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEAE20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeIKUZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:25:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cABHQZBPjyJ5fOKgB6SeAQ3oDqiHZcT0bHYIwENDlQo=; b=lfm7xvsEs0VYLHw5q+NUiU6X9
        iuhIxlPSA9fepgV4zTm+CRssaxOjGgc+OYFOsKYf2p/v3JvKDwKHyiPuWMbYfy8GETr+f+/vHY1x5
        9hnVZi/y1w2e/9EBmqJugAxpHd+ou81s3k8lrwEHgrDE4MAK+vckQq44EkpRnDagiB6XEN1FvH75l
        yBigIVLg+7W5q99NJY2BGRhW30znRHfHPIER+9jcnrI45yJzBuH3YRX1Q5X/DxjnkXXSkgxQur5rB
        h7WOOqZ/PgDX1el0uT9fCxkVJxmTGSA1c48xZE5BSBlJ4hCkiXa9kAcujFt0LEqQUdWo/8pw+YfcQ
        nLXVb3VSw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzkXl-0004Nh-HO; Tue, 11 Sep 2018 15:25:33 +0000
Subject: Re: linux-next: Tree for Sep 11 (drivers/md/dm-thin-metadata.o:)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
References: <20180911145852.116222ab@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5fa94e1-76b1-b703-94fe-dd0493f7b9fd@infradead.org>
Date:   Tue, 11 Sep 2018 08:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180911145852.116222ab@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 9:58 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180910:
> 

on i386:

drivers/md/dm-thin-metadata.o: In function `__set_metadata_reserve':
dm-thin-metadata.c:(.text+0x555): undefined reference to `__udivdi3'



Reported-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
