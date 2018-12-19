Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE55C218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbeLSQsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:48:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39747 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbeLSQsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:48:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E831B20A66; Wed, 19 Dec 2018 17:48:40 +0100 (CET)
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        by mail.bootlin.com (Postfix) with ESMTPSA id BB11E207B8;
        Wed, 19 Dec 2018 17:48:30 +0100 (CET)
Date:   Wed, 19 Dec 2018 17:48:31 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     David Miller <davem@davemloft.net>
Cc:     antoine.tenart@bootlin.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net v3 0/2] net: mvpp2: phylink validate fixes
Message-ID: <20181219164831.GB2704@kwain>
References: <20181217145606.13847-1-antoine.tenart@bootlin.com>
 <20181218.164252.1932839718305986043.davem@davemloft.net>
 <20181219082609.GH20364@kwain>
 <20181219.083418.1274588153696095550.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181219.083418.1274588153696095550.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Dec 19, 2018 at 08:34:18AM -0800, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@bootlin.com>
> Date: Wed, 19 Dec 2018 09:26:09 +0100
> > 
> > The patch 2/2 ("net: mvpp2: fix the phylink mode validation") is still
> > relevant, in addition to the patch you applied. It was added in v3, and
> > is an (unrelated) addition to the first patch.
> 
> Sorry about that!
> 
> Please resubmit patch #2 separately and I'll apply it.

No worries! I'll re-send it as a separate patch.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
