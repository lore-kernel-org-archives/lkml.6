Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F356FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F4320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F4320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeINLQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:16:21 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:56046 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:16:21 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g0hCK-0003pb-FA; Fri, 14 Sep 2018 14:03:20 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g0hCB-0006FS-5y; Fri, 14 Sep 2018 14:03:11 +0800
Date:   Fri, 14 Sep 2018 14:03:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kalyani Akula <kalyani.akula@xilinx.com>
Cc:     davem@davemloft.net, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        pombredanne@nexb.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        saratcha@xilinx.com, kalyani.akula@xilinx.com
Subject: Re: [PATCH] crypto: Adds user space interface for ALG_SET_KEY_TYPE
Message-ID: <20180914060311.hxngp42bogbabpkd@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536302443-18380-1-git-send-email-kalyani.akula@xilinx.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kalyani Akula <kalyani.akula@xilinx.com> wrote:
> ALG_SET_KEY_TYPE requires caller to pass the key_type to be used
> for AES encryption/decryption.
> 
> Sometimes the cipher key will be stored in the device's
> hardware (eFuse, BBRAM etc).So,there is a need to specify the information
> about the key-type to use it for Encrypt or Decrypt operations.
> 
> This patch implements the above requirement.
> 
> 
> Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>

This patch does not make sense by itself.  Please post it together
with the patches that will make use of this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
