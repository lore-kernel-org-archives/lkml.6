Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB684C6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6142C20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mLETeln3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6142C20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeJMJK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:10:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40318 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeJMJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PQpCtfUXGYIrSoFJLsFSv1P+l2EGtZAn/oOqAWCmzsE=; b=mLETeln3hm6RTAttlt2Iq5N2cb
        +1aYZoz5IZTBI2CPEBtVA9P4g3q4y9NfdEIPgPl9Ma18A/KeNrFnyg4jfd3iAw3+cvNtB66EpZ6Ei
        i2h3WQFD6dvDjj+O/HxKPm2ZlfL/q+zxjOGYFnKO4rAwNKv4pFqZMB4kWZYclX/QlLGo/B0xmznx+
        eX7XS9uAAheLqxMGdrvVg668HHyfgDwCjp1cnu2hHJGmqcfJJMR7oJtW9LxwItVpxH++3CEXOu02b
        6dFSO5ASvmrtjf5gnXI8TZS7xAQU1VF4xFFI6GctDOixgBijTK55GJd6SHZaEqWfkj2MbxG73hqAR
        KE6TSCVw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gB8pq-00047S-7v; Sat, 13 Oct 2018 01:35:18 +0000
Subject: Re: [PATCH] docs: Fix typos in histogram.rst
To:     Masanari Iida <standby24x7@gmail.com>, corbet@lwn.net,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org
References: <20181013013057.10677-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02e0990f-c42e-dd91-1f83-17b13f628db6@infradead.org>
Date:   Fri, 12 Oct 2018 18:35:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181013013057.10677-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 6:30 PM, Masanari Iida wrote:
> This patch fixes some spelling typos.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  Documentation/trace/histogram.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
