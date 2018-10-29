Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E868AC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831DF20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831DF20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=laptop.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeJ2OaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:30:16 -0400
Received: from swan.laptop.org ([18.85.44.157]:41471 "EHLO swan.laptop.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbeJ2OaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:30:16 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 10:30:15 EDT
Received: from esk.lan (pa49-195-38-225.pa.nsw.optusnet.com.au [49.195.38.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by swan.laptop.org (Postfix) with ESMTPSA id 9504F4C0279;
        Mon, 29 Oct 2018 01:35:33 -0400 (EDT)
Received: from james by esk.lan with local (Exim 4.86_2)
        (envelope-from <quozl@laptop.org>)
        id 1gH0D3-0005GI-3E; Mon, 29 Oct 2018 16:35:29 +1100
Date:   Mon, 29 Oct 2018 16:35:29 +1100
From:   James Cameron <quozl@laptop.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] DT: marvell,mmp2: Add SSP1 and SSP3
Message-ID: <20181029053529.GG29685@us.netrek.org>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-6-lkundrak@v3.sk>
Organization: Netrek Vanilla Server Dictator
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 07:09:30PM +0200, Lubomir Rintel wrote:
> There seem to be SSP2, SSP4 and perhaps SSP5 too, but Marvel keeps their
> base addresses secret.
> 
> The SSP1 and SSP3 addresses were taken from OLPC 1.75, OpenFirmware and
> kernel respectively.

Sorry for the delay.  Love your work!  From my notes, SSP2 is
0xd4036000, and SSP4 is 0xd4039000.  Can be probed by hand in
OpenFirmware or CForth once clocks are on.

-- 
James Cameron
http://quozl.netrek.org/
