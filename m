Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA46C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71194218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfBFDts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:49:48 -0500
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:49230 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbfBFDts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:49:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7E63F180268C3;
        Wed,  6 Feb 2019 03:49:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tax28_8f8a93bc9c910
X-Filterd-Recvd-Size: 1239
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed,  6 Feb 2019 03:49:46 +0000 (UTC)
Message-ID: <f16eb98a11a5959de8af16db2aa1f90eebb0a7a0.camel@perches.com>
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
From:   Joe Perches <joe@perches.com>
To:     Paul Zimmerman <pauldzim@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org
Date:   Tue, 05 Feb 2019 19:49:45 -0800
In-Reply-To: <20190205202522.2ab2ea40430e817d4f01cc4e@gmail.com>
References: <20190205192733.b4bd98988d1e4695f740d445@gmail.com>
         <9e4332bf41d5d58a4fa6cf138fc9ea3b2f9a488f.camel@perches.com>
         <20190205202522.2ab2ea40430e817d4f01cc4e@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05 at 20:25 -0700, Paul Zimmerman wrote:
> GCC does not lay out stack variables in the same order that they are
> declared.

True. Most stack variables could be assigned to a register.

cheers, Joe


