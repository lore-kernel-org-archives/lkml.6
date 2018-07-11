Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C18C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5199C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5199C20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbeGKNoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:44:03 -0400
Received: from muru.com ([72.249.23.125]:51122 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbeGKNoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:44:03 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4FB70809B;
        Wed, 11 Jul 2018 13:42:44 +0000 (UTC)
Date:   Wed, 11 Jul 2018 06:39:37 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "Marcel Partap (unterwegs)" <mpartap@gmx.net>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        merlijn@wizzup.org
Subject: Re: v4.18-rc2 on droid4: screen turns red
Message-ID: <20180711133937.GN99251@atomide.com>
References: <20180630131812.GA549@amd>
 <20180711102655.GA6864@amd>
 <8EB5195E-E329-4001-8C1C-185D25FE6AD3@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8EB5195E-E329-4001-8C1C-185D25FE6AD3@gmx.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcel Partap (unterwegs) <mpartap@gmx.net> [180711 11:02]:
> If I get my spare droid4 to boot again I'll send it to Prague so you can compare & see if it is somewhat deterministic ; )

I don't think I'm seeing this, I'm currently on
4.18.0-rc3-next-20180709 plus the LCD and audio
patches and whatever random patches I'm working
on in general.

Maybe it's some xserver related issue if console
works?

Regards,

Tony
