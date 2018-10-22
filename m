Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08294C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E67205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E67205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeJVRNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:13:43 -0400
Received: from verein.lst.de ([213.95.11.211]:35057 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeJVRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:13:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C8ABC68BE1; Mon, 22 Oct 2018 10:56:05 +0200 (CEST)
Date:   Mon, 22 Oct 2018 10:56:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: move the remap helpers to a separate file
Message-ID: <20181022085605.GA18755@lst.de>
References: <20181014181651.22971-1-hch@lst.de> <e2a05b3e-7306-4710-1591-0a39278b5002@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a05b3e-7306-4710-1591-0a39278b5002@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 12:41:42AM -0700, Laura Abbott wrote:
>> The dma remap code only really makes sense for not cache coherent
>> architectures, and currently is only used by arm, arm64 and xtensa.
>> Split it out into a separate file with a separate Kconfig symbol.
>>
>> [Laura: you wrote this code back then, do you have a sensible
>>   copyright statement to add, given that the mapping.c statement
>>   obviously does not match your code that was written much later]
>>
>
> Hmmmmm, that was written and committed via my codeaurora.org e-mail
> address. Probably best to use "Copyright (c) 2014, The Linux Foundation"
> since that was the standard. If you want,
>
> Acked-by: Laura Abbott <labbott@redhat.com>

Thanks!
