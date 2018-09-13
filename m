Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF8FFA375B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1B4217BE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8yvgE+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1B4217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeIMWj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:39:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8r8qFSXeR1rCSavXLtDozZelbnBskLJQynYcIWsRC4I=; b=E8yvgE+KX9m9EgBMnpQZPHe7i
        qNfd8+0QzsOcwjg4/s4NePlUa8aZBzVwZNK0fSw9vWF+L2PORSIPxVfNWIuGZacykWdELrIxMyNtD
        9ufoQqGvQWiXdPbFpr3OQGUgMbvePwi/j6g6M/CeECxwgmYW7nivmVR7kN4tWcXYn4GcZ0UKrFMkL
        +spqitgzo8v/qMqmei/XpEjlZgkLdir4diR96tZFkBEOakzq4z8sXBfw+sOjpP/tG9+A1wLK56cVy
        ZBGMM4VJK8vDJSKKIx7ldbkKcmo1ll8Rt+AAHAj0362Vh66Xwc7/kjuGVz6vxQib/li+2aZQIdBv5
        BLrYYSvbw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0VQH-0004aD-AP; Thu, 13 Sep 2018 17:28:58 +0000
Subject: Re: linux-next: Tree for Sep 13 (dm-thin-pool)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Thornber <dm-devel@redhat.com>
References: <20180913152753.60866288@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <258e14a1-0dbc-74ff-23a5-cd676fdf4579@infradead.org>
Date:   Thu, 13 Sep 2018 10:28:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180913152753.60866288@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/18 10:27 PM, Stephen Rothwell wrote:
> Hi all,
> 
> News: there will be no linux-next releases on Friday or Monday.
> 
> Changes since 20180912:
> 

on i386:

ERROR: "__udivdi3" [drivers/md/dm-thin-pool.ko] undefined!


-- 
~Randy
