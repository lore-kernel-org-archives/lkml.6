Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0D9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2F12086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2F12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJKOXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:23:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43339 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbeJKOXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:23:51 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D736F20712; Thu, 11 Oct 2018 08:57:55 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7899720703;
        Thu, 11 Oct 2018 08:57:55 +0200 (CEST)
Date:   Thu, 11 Oct 2018 08:57:56 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     f.fainelli@gmail.com, antoine.tenart@bootlin.com, andrew@lunn.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next] net: mscc: allow extracting the FCS into the skb
Message-ID: <20181011065756.GA11888@kwain>
References: <20181002124323.GC9155@lunn.ch>
 <20181010144631.GE3368@kwain>
 <28179B83-2C71-47FA-9D9C-49237E4A07AE@gmail.com>
 <20181010.102605.1416485422281413445.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181010.102605.1416485422281413445.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian, Dave,

On Wed, Oct 10, 2018 at 10:26:05AM -0700, David Miller wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> Date: Wed, 10 Oct 2018 09:25:01 -0700
> > 
> > On October 10, 2018 7:46:31 AM PDT, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
> >>
> >>@Dave, Florian: it seems to me no modification was requested after
> >>discussing those changes. Where do we stand regarding the patch?
> > 
> > Silence means agreement, thanks for your explanation, no more
> > questions or concerns on my side.
> 
> You'll probably need to resubmit the patch anew though.

I'll rebase the patch on top of net-next and send it again.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
