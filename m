Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ECAC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B08720866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B08720866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIMKKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:10:46 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:54164 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeIMKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:10:46 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g0JmK-00028e-33; Thu, 13 Sep 2018 13:02:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g0JmG-0004hh-W7; Thu, 13 Sep 2018 13:02:53 +0800
Date:   Thu, 13 Sep 2018 13:02:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     linux-crypto@vger.kernel.org, thomas.lendacky@amd.com,
        Gary Hook <Gary.Hook@amd.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH crypto-2.6] crypto: ccp: add timeout support in the SEV
 command
Message-ID: <20180913050252.wvcjy7gxjzokoca4@gondor.apana.org.au>
References: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
 <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
 <20180904051930.5kvyyu75ym5mubuz@gondor.apana.org.au>
 <ec8245a3-1620-4501-0ebd-f04dfe973bc8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec8245a3-1620-4501-0ebd-f04dfe973bc8@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 07:11:05PM -0500, Brijesh Singh wrote:
>
> Can you please include this patch in your next 4.19-rcX pull request?
> Multiple folks are encountering this firmware bug on Ryzen systems. I
> will submit the modified version of this patch for stable release (s) so
> that we fix issues in 4.18,.17 and .16. thank you.

OK, I will add it to the crypto tree.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
