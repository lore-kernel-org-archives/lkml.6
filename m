Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9DC2152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9DC2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeIZXTm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:19:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56763 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeIZXTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:19:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C49552073D; Wed, 26 Sep 2018 19:05:45 +0200 (CEST)
Received: from localhost (unknown [91.116.141.28])
        by mail.bootlin.com (Postfix) with ESMTPSA id 84B51204AE;
        Wed, 26 Sep 2018 19:05:45 +0200 (CEST)
Date:   Wed, 26 Sep 2018 19:05:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rodrigo =?utf-8?B?RXh0ZXJja8O2dHRlciBUasOkZGVy?= 
        <rodrigo@tjader.xyz>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: Olimex A64-OLinuXino: fix
 ethernet
Message-ID: <20180926170545.ogcmt36ff7jmqxkl@flea>
References: <20180919141938.18791-1-rodrigo@tjader.xyz>
 <20180921142941.5ymp7ksphgboxrwz@flea>
 <CAG7TQgFOuHHmkm-6CDDYJ6KuDqfjNvFjnt8_9BPYfdP=oV57VQ@mail.gmail.com>
 <20180926094525.e4fepvonmy7ykdbb@flea>
 <CAG7TQgFEqH6k0GAPA3yqKDQbtA=n9Qiw0-rq-aNNVZ5L6+Unhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAG7TQgFEqH6k0GAPA3yqKDQbtA=n9Qiw0-rq-aNNVZ5L6+Unhw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:14:15PM -0300, Rodrigo Exterckötter Tjäder wrote:
> On Wed, Sep 26, 2018 at 6:46 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > There's no need to be so specific though :)
> >
> > Something like that would work:
> >
> > arm64: dts: allwinner: a64-olinuxino: set the PHY TX delay
> >
> > The PHY found on the A64-Olinuxino requires a TX delay in order to
> > operate properly. Olimex uses a 600ps second delay in their BSP, and
> > that has been found to work, so let's use that value in the current
> > DT.
> 
> Should I go ahead and send a v2 with that commit message then?

Yep, thanks!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
