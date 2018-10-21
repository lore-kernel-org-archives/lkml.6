Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C41ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFE520836
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 22:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cgZA44ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFE520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJVGx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 02:53:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJVGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 02:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UxTtDweeEmbz0aNhAVxMT15+955XBRQ8J7mhXpqZKSs=; b=cgZA44roaHEC0vHX15WaEPZoo
        F5eK623XYAU7hE23J4hqbrWQK3v6hB23uNotHqqQkhqneH6aVpdUAiPMiZYx68Ph6ma50uoKDYd0g
        6Idn3QIX/kbCFyy2hzmcWyNod+Kgak47Zr2BU5212GGwzZOIxFKIxnOTjiobmuB33PDp4xZt8hC6Q
        OPIOPwm3DIqzjIj0xHZatBjbFJ6etCuYLegsIfbXo7vK1wxN0O+LZLScZ7w72QuiyRH1V+3BkHLes
        FxeABdchtyOSBu5IdSDXFPM66EveBqAZbHp5Ioljd/xCgrJACVZIxRRFiUfr8pUf5FYICyoKF2BBX
        OtzlNB9+Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEMME-0007lT-Bb; Sun, 21 Oct 2018 22:38:02 +0000
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of Conduct:
 Fix some wording, and add an interpretation document
To:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <d4e4a2d9d63112a854fd30df19fd16f20face810.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <62b70ccb-9484-7842-e57a-9697946636c3@infradead.org>
Date:   Sun, 21 Oct 2018 15:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d4e4a2d9d63112a854fd30df19fd16f20face810.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/18 3:33 PM, Joe Perches wrote:
> On Mon, 2018-10-22 at 08:20 +1100, NeilBrown wrote:
>> On Sat, Oct 20 2018, Greg Kroah-Hartman wrote:
>>> As everyone knows by now, we added a new Code of Conduct to the kernel
>>> tree a few weeks ago.
>>
>> I wanted to stay detached from all this, but as remaining (publicly)
>> silent might be seen (publicly) as acquiescing, I hereby declare that:
>>    I reject, as illegitimate, this Code and the process by
>>    which it is being "developed".
> []
>> I call on any other community members who reject this process to say so,
>> not to remain silent.
> 
> The concept of describing a desire for pleasant interactions
> while
> developing the linux kernel is legitimate and useful.

Agree.

> I do reject this process as well and I think the attempt to
> reform it via a private, non-public method is, at best,
> poor form.

and Agree.

> Joe Perches

Thanks.

-- 
~Randy
