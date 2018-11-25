Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_TVD_FUZZY_SECTOR autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069C5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45042084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dW637T/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45042084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeKZG2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:28:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKZG2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jwkDvZdwNZBnoNuczWs+jFtqrnN0S3OlVLzQ0QkL4DU=; b=dW637T/DadGc6o8ocGX6fYQy8
        C+jNv1pN5wkKoYqnyNcGHfjc9SvKRHlTR6bpppusi1ecMaP5zgJM8UCX3SLYoY7+Kyf2Lk/YWMoTz
        5dBLX2V/qs8f8E8L2ekk3PX61HkkQe5aw8UMvYPojijphphKySsxazmSytYM7vE07c5BATMF3mtCe
        a80nnOdaY6RDhhYuUMDN2bGeBnegmtHsGqNShXDKqE5ysHHe5KsHZhPkcPl3Y5XgitQOLI4qikVSy
        6NX+Gagw/r5lIb/19JqRoVKEiMQU3j5Ur27gNfFOQ1PE5na63uXvNrz3aNMHJqnVzioyBU3zDwr2M
        lkBnfXmeg==;
Received: from [66.118.103.209] (helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gR0D7-0000QL-PB; Sun, 25 Nov 2018 19:36:54 +0000
Subject: Re: [PATCH] Documentation: dev-tools: Fix typos in index.rst
To:     Jonathan Corbet <corbet@lwn.net>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181122153456.24413-1-0xinfosect0r@gmail.com>
 <20181125122850.442e1688@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9624d217-b61c-81b1-4da9-fe84d14260da@infradead.org>
Date:   Sun, 25 Nov 2018 11:36:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181125122850.442e1688@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/18 11:28 AM, Jonathan Corbet wrote:
> On Thu, 22 Nov 2018 10:34:56 -0500
> Shreyans Devendra Doshi <0xinfosect0r@gmail.com> wrote:
> 
>> Fixes a spelling error and removes an extra whitespace character.
>>
>> Signed-off-by: Shreyans Devendra Doshi <0xinfosect0r@gmail.com>
> 
> I've applied this for the typo fix, but let me echo Willy's comments about
> the whitespace change.  There is no official policy on spaces after
> periods in kernel documentation, and I have no interest in adding one;
> I'll not be accepting patches making such changes in the future.

Ack that.

thanks,
-- 
~Randy
