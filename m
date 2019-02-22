Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2574C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A97A206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBVLVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:21:53 -0500
Received: from verein.lst.de ([213.95.11.211]:42957 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfBVLVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:21:53 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 12A6E68CEC; Fri, 22 Feb 2019 12:21:51 +0100 (CET)
Date:   Fri, 22 Feb 2019 12:21:51 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Carlo Caione <carlo@caione.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: device tree binding for poly-phased regulators
Message-ID: <20190222112151.GA23266@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Documentation/devicetree/bindings/mfd/axp20x.txt nicely describes the
capabilities of the X-powers PMICs; however, it seems polyphasing is
left to comments only.

May I suggest to add a property "poly-phased", just to get the discussion
started? It could be a simple property in the current case for the axp803
and axp806 ("poly-phased with you-know-which") or a phandle in the future.

BTW the axp803 datasheet is quite terse in that respect: is there one
"master" reulator whose settings are copied or does a driver have to keep
them in sync.

Anyway, comments welcome!

	Torsten

