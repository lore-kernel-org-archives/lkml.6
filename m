Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B941C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D40218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M4++wIso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfA3Pwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:52:31 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:60940 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfA3Pwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aWHq6t0m0kVjw1eL0/I/a69qtHvKLb7OFVkH95zAux8=; b=M4++wIso5RHeCcbQERqo0HOSlB
        Ddi1a16ct3fu+8n/IB6dmu15U3sFyfUfj+c2VjleXd8pfbrm0Xdn28OQBlYPKp9CXwdtBhKu1QXC1
        9s99NZcgDvlgEuh9jdXeR4aYoWA9O7tB6RrVBtTMx7CDx7pqEhiOXWU2fa6hJ/HOAg2I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gosA7-0004BP-1E; Wed, 30 Jan 2019 16:52:27 +0100
Date:   Wed, 30 Jan 2019 16:52:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v3] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190130155227.GC15050@lunn.ch>
References: <1547250965-17668-1-git-send-email-andrew@lunn.ch>
 <20190129113532.GB24070@dell>
 <20190129205652.GF13334@lunn.ch>
 <20190130125007.GA4701@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130125007.GA4701@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Lee
> > 
> > I posted a new version.
> > 
> > Your email indicates you are using Mutt:
> > 
> > >User-Agent: Mutt/1.9.4 (2018-02-28)
> > 
> > Which is also what i use. I've never had issues with signatures like
> > this. I also cannot find any documentation as to how you configure
> > mutt remove signatures. How are you doing it?
> 
> I think it's automatic.  I certainly didn't set that up.

Interesting. My mutt installation does not do this. I trim emails
manually to be netiquette compliant.

> Try replying to your own mail.  I should automatically cut.

Replying to my patch works fine. It does not cut the patch.

This is a bug somewhere, since the marker i used is not a signature
marker. It did not have the space on the end.

Anyway, getting the patch reviewed is more important to me than
tracing down the bug...

	 Andrew
