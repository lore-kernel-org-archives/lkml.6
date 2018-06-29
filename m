Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059082490C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059082490C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbeF2HjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:39:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53233 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeF2HjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:39:03 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fYnzh-0002fK-Di; Fri, 29 Jun 2018 09:39:01 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fYnze-00071s-D2; Fri, 29 Jun 2018 09:38:58 +0200
Date:   Fri, 29 Jun 2018 09:38:58 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Gavin Schenk <g.schenk@eckelmann.de>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] siox: don't create a thread without starting it
Message-ID: <20180629073858.5gwpfwqo2ccb4jaa@pengutronix.de>
References: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
 <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Cc -= Peter Zijlstra
Cc += Stephen Rothwell

On Thu, Jun 28, 2018 at 09:57:42AM +0200, Uwe Kleine-König wrote:
> Greg, you applied the initial patches creating drivers/siox. I assume
> you will continue to apply siox patches and tell if I should search a
> different path for these.

I put the two patches that I'd like to get in during the next merge
window into a branch in my repository:

	https://git.pengutronix.de/git/ukl/linux siox/next

I assume you wouldn't object to add this branch to linux-next?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
