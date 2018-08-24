Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA79C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579BE208CC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Lyr7GJa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579BE208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeHXRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:47:05 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:59504 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbeHXRrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1535119934;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=iZTdunWPGTTCiR/FWbsWwhbx+tN42Vn/nO9h9ESs5WI=;
        b=Lyr7GJa3WqG6oLB4/l510/RwwQFHX+kpBYdhJp0XnkxlyFqpTPNPq0DVaM89+Xtu
        2nDCBx36R3rSg8NnhTLVB6DJNRuirfNaW4MGJHPmpxjWzhtBEgStonC22DBXHPd1LtR
        9wgOkWcj5JF1RjH6f0cLSoqcJxUj21GEtBkqZOz0=
Date:   Fri, 24 Aug 2018 14:12:14 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] XArray for 4.19
In-Reply-To: <0c8ffb97-5896-148c-bff8-ffb92a60b307@suse.cz>
Message-ID: <010001656c4742be-cbf4b700-bd19-46e4-ae10-fa24d39d244c-000000@email.amazonses.com>
References: <20180813161357.GB1199@bombadil.infradead.org> <0100016562b90938-02b97bb7-eddd-412d-8162-7519a70d4103-000000@email.amazonses.com> <0c8ffb97-5896-148c-bff8-ffb92a60b307@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.08.24-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Vlastimil Babka wrote:

>
> I think you can just post those for review and say that they apply on
> top of xarray git? Maybe also with your own git URL with those applied
> for easier access? I'm curious but also sceptical that something so
> major would get picked up to mmotm immediately :)
>

I posted it awhile ago and was waiting for something definite to diff
against so that testing is simple.

The last release is at
https://www.spinics.net/lists/linux-mm/msg142496.html

