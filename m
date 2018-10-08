Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71605C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359AA20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRcQNoRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359AA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJHWzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:55:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHWzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pLyxuLJJ9Vk4U6UE9iqcKchQsbnDHKkOvEdexAG3x6Y=; b=JRcQNoRvSWViPCMoNSoeqqGcO
        0I184CYa+m1hILYG6rQiZms4APh1eRodzB0Ds7nGU9RPq3K/3tVOnTifkbwmbQ3B2j0n/8iOTmxAY
        vpGN57oSD8nFDCiAuN/ZCgivQlCWgdnzntIfz4C3/m94eYlBZk31VN3LYNTclyAZg7v3dqXZ36y00
        F/XfbSTi5Zjv+DohjCRGPID2iZ0XDOwBiZnmf2jPCevRpzvTx/y0lgjB9yG+xEuy+DAXvEdPSkPAi
        6hs00D57HfhFzKwTnctn3rIhDSoodduHl3LtDmlNIvX0rNUlmWytnXyB/SdImDljRP1X1gZrhRm4D
        5R4rK4Cnw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9XgU-0002fr-QT; Mon, 08 Oct 2018 15:43:02 +0000
Subject: Re: [GIT PULL 11/16] stm class: Document the MIPI SyS-T protocol
 usage
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
 <20181005124306.54870-12-alexander.shishkin@linux.intel.com>
 <5e7d8200-d357-4105-b00a-3ca36d375aac@infradead.org>
 <87r2h0651k.fsf@ashishki-desk.ger.corp.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0d04799-f05b-3034-9528-37a12295a376@infradead.org>
Date:   Mon, 8 Oct 2018 08:42:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87r2h0651k.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 4:39 AM, Alexander Shishkin wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Hi,
>> one small typo/spello below...
>>
>>> +If the protocol name is omitted, the STM class will chose whichever
>>
>> s/chose/choose/
> 
> Aw shucks, me can has spelling good. Do you mind if I fix it in later
> rcs?

No problem for me.

tanks.
-- 
~Randy
