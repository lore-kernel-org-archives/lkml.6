Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C8EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB9E2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeLSI00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:26:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52863 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbeLSI0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:26:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 97040207D9; Wed, 19 Dec 2018 09:26:23 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr [90.88.157.38])
        by mail.bootlin.com (Postfix) with ESMTPSA id 69867207B2;
        Wed, 19 Dec 2018 09:26:13 +0100 (CET)
Date:   Wed, 19 Dec 2018 09:26:09 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     antoine.tenart@bootlin.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net v3 0/2] net: mvpp2: phylink validate fixes
Message-ID: <20181219082609.GH20364@kwain>
References: <20181217145606.13847-1-antoine.tenart@bootlin.com>
 <20181218.164252.1932839718305986043.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218.164252.1932839718305986043.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Dec 18, 2018 at 04:42:52PM -0800, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Mon, 17 Dec 2018 15:56:04 +0100
> 
> > This small series introduces 2 fixes for the phylink validate function
> > of the Marvell PPv2 Ethernet driver.
> > 
> > Since v2:
> >   - Added an additional patch (2/2) as suggested by Russell.
> >   - Rebased on top of net/master.
> > 
> > Since v1:
> >   - Rebased on top of net/master.
> 
> Because, in the end, I applied:
> 
> 006791772084 ("net: mvpp2: 10G modes aren't supported on all ports")
>
> I am assuming this series is not relevant.

The patch 2/2 ("net: mvpp2: fix the phylink mode validation") is still
relevant, in addition to the patch you applied. It was added in v3, and
is an (unrelated) addition to the first patch.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
