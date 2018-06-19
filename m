Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B629CC5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E3F2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E3F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757227AbeFSUnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:43:39 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:64857 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754833AbeFSUne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:43:34 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w5JKge5p032612;
        Tue, 19 Jun 2018 22:42:40 +0200
Date:   Tue, 19 Jun 2018 22:42:40 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Matti Aarnio <matti.aarnio@zmailer.org>,
        viresh kumar <viresh.kumar@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Query: Patches break with Microsoft exchange server.
Message-ID: <20180619204240.GA32604@1wt.eu>
References: <4C5F9B25.8080401@st.com>
 <20100809064957.GB16661@pengutronix.de>
 <4C5FA698.90904@st.com>
 <20100809090137.GP13165@mea-ext.zmailer.org>
 <1281348164.12908.47.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1281348164.12908.47.camel@localhost>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2010 at 11:02:44AM +0100, David Woodhouse wrote:
> If my corporate overloads told me I had to use my Exchange "messaging"
> account for external email communication, they would get a quite clear
> 'no' in response. My response may also contain suggestions that they use
> certain other objects for purposes for which they were not designed.

I'd say that if, after having been calmly explained the nature of the
trouble caused, they don't care, it's a clear demonstration of total
lack of respect of your work by deliberately breaking the tools you
need to do it. Generally it's the signal that it's time to find a more
respectful employer.

Willy
