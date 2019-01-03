Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16000C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD0B20833
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 02:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWvwVtJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfACCIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 21:08:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfACCIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 21:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A9/8Rhrea7VJRZFGFnx7/fJLPb9t8+FU4MRAmGhHQaw=; b=mWvwVtJvtd2V7aq2UQpL1yw0m
        WfsJvpaoiXvVTp01v88qnrhIx++yxutBVB53SvSvUGQTjD9xdTvidrNgxV/CUm4okE5ZVpU/TvYbO
        SwP8yOe1h5/l9C9Nu5/XprbW+5iIEpcUTLQc7X4kxLHeK5YCGL+waoToFz3ZjeRa/11JfyH+s3AXm
        gJ3uU3Ig1yRCaVllndgUGDuXdfIq9spqGw08G6v/6OxLvhJbth6s5sfhz1fj9vSJLwezvWSkP5aag
        q5DQjW6KiYMuC4cCSjhWrC15vy2UT15y6pxXnuX2S/jnPbsLXPqvYIItAkEeFr1S1rhI/hfpNAd0B
        KF4XEyEsA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gesRB-0004YI-2i; Thu, 03 Jan 2019 02:08:45 +0000
Date:   Wed, 2 Jan 2019 18:08:43 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Jan Vlietland <j.vlietland@nisi.nl>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SAMSUNG LAPTOP DRIVER" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: Please help!: Keyboard backlight not working on my NP900X5N
 laptop <previous not accepted due to HTML encoding>
Message-ID: <20190103020843.GB21617@wrath>
References: <c3ea9b3f-5ffe-df8f-726c-0bf6f3a82701@nisi.nl>
 <0e16bba8-046c-c559-9ee1-88c0341a51d5@nisi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e16bba8-046c-c559-9ee1-88c0341a51d5@nisi.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 12:20:15AM +0100, Jan Vlietland wrote:
> Hi guys,
> 
> Sorry but still walking with this bug under my arm.
> 
> I can't find the right group to file the bug on bugzilla and also on
> freenode I cannot find the right group.
> 
> Please help!

Hi Jan,

I responded to your original email from Dec 31. You will need to allow
more time for people to respond as many of us are doing this work on our
own time - and this was New Year's Eve/Day. General rule of thumb is to
give people a week before following up. We make an effort to respond
within 48 business hours, but I find that pretty difficult to keep up
with myself.

Let's continue the discussion in the original thread.

-- 
Darren Hart
VMware Open Source Technology Center
