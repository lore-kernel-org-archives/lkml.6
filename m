Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7FCC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7090721852
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAVW5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:57:03 -0500
Received: from muru.com ([72.249.23.125]:34768 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfAVW5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:57:02 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7C49580F6;
        Tue, 22 Jan 2019 22:57:09 +0000 (UTC)
Date:   Tue, 22 Jan 2019 14:56:54 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "Arthur D." <spinal.by@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>, bcousson@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
Message-ID: <20190122225654.GA5720@atomide.com>
References: <20190121032109.10220-1-spinal.by@gmail.com>
 <CAOMZO5DDM5=ZL8_-JZpX23ChoKhuBY7-bNaTE7JjDW0jwsHb4A@mail.gmail.com>
 <20190121200030.GJ5544@atomide.com>
 <op.zvz5hat5hxa7s4@supervisor.net28>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.zvz5hat5hxa7s4@supervisor.net28>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arthur D. <spinal.by@gmail.com> [190122 04:59]:
> Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>

Thanks applying into omap-for-v5.0/fixes.

Tony
