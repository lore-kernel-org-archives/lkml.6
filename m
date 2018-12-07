Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F334520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F334520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeLGQyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:54:33 -0500
Received: from muru.com ([72.249.23.125]:56742 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeLGQyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:54:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2652480C0;
        Fri,  7 Dec 2018 16:54:35 +0000 (UTC)
Date:   Fri, 7 Dec 2018 08:54:29 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Felix Brack <fb@ltec.ch>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am335x-pdu001: Fix polarity of card detection
 input
Message-ID: <20181207165429.GQ6707@atomide.com>
References: <20181130145446.3819-1-fb@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130145446.3819-1-fb@ltec.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Felix Brack <fb@ltec.ch> [181130 07:30]:
> When a micro SD card is inserted in the PDU001 card cage, the card
> detection switch is opened and the corresponding GPIO input is driven
> by a pull-up. Hence change the active level of the card detection
> input from low to high.

Applying into omap-for-v4.20/fixes thanks,

Tony
