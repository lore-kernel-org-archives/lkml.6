Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8071C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9581F2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9581F2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeGYP0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:26:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:46294 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbeGYP0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:26:08 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5827830D;
        Wed, 25 Jul 2018 14:14:16 +0000 (UTC)
Date:   Wed, 25 Jul 2018 08:14:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] docs: net: Convert netdev-FAQ to RST
Message-ID: <20180725081415.373bde37@lwn.net>
In-Reply-To: <20180725032810.GA6067@eros>
References: <20180725025005.14332-1-me@tobin.cc>
        <20180725032810.GA6067@eros>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 13:28:10 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Since I've already botched it can I ask for guidance here.  The problem
> is updating the links means making changes that will cause merge
> conflicts if they go through net-dev tree (since most references are in
> Documentation/*.rst).  But we can't go through docs tree either since
> that could lead to merge conflicts later as well.

Merge conflicts are a way of life in Documentation/ - everybody messes
with it.  They are usually pretty easy to resolve.

I only see a handful of references to netdev-FAQ.txt in the tree; I would
suggest just making the change and being done with it.  There shouldn't be
any need to do a more complicated dance than that.

And to answer your other question, yes of course it's fine (and expected)
for this to go through Dave's tree.

Thanks,

jon
