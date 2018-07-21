Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC115ECDFBD
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C0D20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 05:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C0D20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeGUG0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 02:26:24 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:39662 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727247AbeGUG0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 02:26:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 894B5182CED28;
        Sat, 21 Jul 2018 05:34:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: horn78_2b444367c432c
X-Filterd-Recvd-Size: 1570
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Jul 2018 05:34:57 +0000 (UTC)
Message-ID: <085e361269db5f5f923a65a52e1000d5cd79eee4.camel@perches.com>
Subject: Re: make sure swap arguments are the same type? (was: Re: [PATCH]
 crypto: rmd320 - use swap macro in rmd320_transform)
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Fri, 20 Jul 2018 22:34:56 -0700
In-Reply-To: <ac6bf6b3-b739-a6b8-c9b0-8d496fb7a470@embeddedor.com>
References: <20180718171908.GA22962@embeddedor.com>
         <4dbef38e6020d6cb78e860a9f01fcd1de9f0fb52.camel@perches.com>
         <ac6bf6b3-b739-a6b8-c9b0-8d496fb7a470@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 10:43 -0500, Gustavo A. R. Silva wrote:
> Hi Joe,
> 
> I like the idea. I'll take a look at the cases you mention and see
> if I can make them work with your version of swap.
> 
> BTW, I wonder if it would be more convenient to trigger a build warning
> instead of an error.
> 
> What do you think?

I can't think of a way to have a #pragma (or _Pragma equivalent)
emit a warning on a condition.


