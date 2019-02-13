Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F878C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07C5218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nu39IdlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbfBMDKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:10:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732597AbfBMDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YTJqe0BFIXEHjERP1CPFfEIYWeKwxFAUWIz6qSWu6fc=; b=Nu39IdlOGJtwfQhDDlccbR69K
        IFMK9UFQ1J35KW8AOHqmmvyKLDyJUVqalDHRkDy2jTmfa2aaEPYUWjXqxVFenBke6ZpwzmJQTaUTL
        djnHIXPZZVB96T6dGkXFSDcwe5rp4YuM0mt61Z9bdj9DaN+W/aEQWjROMTQOoynTPTBPlgD/EaNA9
        clXOFswoV29cQ1J6FskskMNsnXBcrSCeBI7q73AXs61RmMeqbHcHdhCVCi3kZbREowlXqETRz/upl
        xFjWw+1mSuKCqOL7ygu8XrTkj3+oVsYfT1fNT7teoyp2LJkgIaT03pPXDsNs3d7Yo3Ef1a2iya0BC
        9Y+pjlY7g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtkvw-0005Vp-CN; Wed, 13 Feb 2019 03:10:00 +0000
Subject: Re: mmotm 2019-02-12-15-37 uploaded (net/ipv4/devinit.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20190212233743.mGzbg%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <011529bd-bae3-f815-0d7e-6da733c1cf55@infradead.org>
Date:   Tue, 12 Feb 2019 19:09:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190212233743.mGzbg%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 3:37 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-02-12-15-37 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

on x86_64:

when CONFIG_SYSCTL is not enabled:

ld: net/ipv4/devinet.o: in function `devinet_init_net':
devinet.c:(.text+0x3ad): undefined reference to `sysctl_devconf_inherit_init_net'



-- 
~Randy
