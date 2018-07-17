Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80EEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CE720877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CE720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeGQId5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:33:57 -0400
Received: from muru.com ([72.249.23.125]:51782 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbeGQId5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:33:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A11D680C5;
        Tue, 17 Jul 2018 08:05:46 +0000 (UTC)
Date:   Tue, 17 Jul 2018 01:02:33 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Koen Kooi <koen@dominion.thruhere.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>, SZ Lin <sz.lin@moxa.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: Add vendor prefix for Sancloud
Message-ID: <20180717080233.GC99251@atomide.com>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
 <20180717072028.GA3100@piout.net>
 <D3049450-5391-40CB-ADD1-E1330BFE0525@dominion.thruhere.net>
 <20180717073659.GB3100@piout.net>
 <8EB8A3A1-EF76-42F8-A7C2-5A4A595C92B8@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8EB8A3A1-EF76-42F8-A7C2-5A4A595C92B8@dominion.thruhere.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [180717 07:46]:
> 
> Thanks for the explanation! I resent 0001 with linux-omap and Tony explicitly adding using -cc in git-send-email.

Yeah thanks I'll pick up both patches.

Tony
