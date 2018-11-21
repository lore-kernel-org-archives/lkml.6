Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56C12147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O+JbfdGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56C12147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeKVAod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:44:33 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:44132 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbeKVAoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=AX9FUwm2jSUt0ZROJPzFR9BLHJJheRQMqoDi1b9PqwQ=;
        b=O+JbfdGSuZL0p2GrNJJujTzh0aMqtGLWhVweOktE1ekzSkPKtGw6dbJDMgMx1jlUadNWQwOis+uBpmrbsRmVey+qtX6w80mVy9m8gnPPJS2NXfodAqugOph1AEo05oZh/jWSbl2oZKsHcELcR7fwzXdZpKowQJ7tCK9fCrV+tR0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gPTCV-00007n-SA; Wed, 21 Nov 2018 15:09:55 +0100
Date:   Wed, 21 Nov 2018 15:09:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH net : Micrel KSZ8061 PHY link failure after cable connect
Message-ID: <20181121140955.GA32314@lunn.ch>
References: <1542805518-10707-1-git-send-email-alexander.onnasch@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542805518-10707-1-git-send-email-alexander.onnasch@landisgyr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 01:05:32PM +0000, Onnasch, Alexander (EXT) wrote:
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> For tree: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git

Hi Alexander

The Reviewed-by: Should go after the Signed-of-by:

And you indicate the tree in the subject line:

[PATCH v2 net] phy: Micrel KSZ8061: link failure after cable connect

       Andrew
