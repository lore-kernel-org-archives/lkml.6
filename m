Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0219C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7690F2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7690F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbeGXQCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:02:22 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:39512 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbeGXQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:02:21 -0400
Received: from ravnborg.org (unknown [158.248.196.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 7EBED20023;
        Tue, 24 Jul 2018 16:55:27 +0200 (CEST)
Date:   Tue, 24 Jul 2018 16:55:25 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>
Subject: Re: [PATCH 1/2] sparc: move MSI related definitions to where they
 are used
Message-ID: <20180724145525.GA14300@ravnborg.org>
References: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
 <20180724143736.GA22088@ravnborg.org>
 <20180724164407.4fa57d1f@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724164407.4fa57d1f@windsurf>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=KWHQTMtYkH6ttdi61AoA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas.

> > 
> > The SPARC way to format comments follows netdev style.
> > So put it all in one line and everyone are happy:
> 
> Well, the code is being moved from arch/sparc to arch/sparc, so
> apparently, it was already non-compliant to this specific coding style
> rule. Should the comments be made compliant as part of the same commit,
> or a separate one ?
Same commit, no reason to slit this in two.
So post a v2, then everyone should be happy.

I also looked at the second patch which looked obviously correct.
Feel free to add my Ack on both.

	Sam
