Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA4AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C306C206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C306C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeI1X7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:59:02 -0400
Received: from muru.com ([72.249.23.125]:57662 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeI1X7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:59:02 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7EF6380C0;
        Fri, 28 Sep 2018 17:38:36 +0000 (UTC)
Date:   Fri, 28 Sep 2018 10:34:10 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pyra-handheld.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] ARM: DTS: OMAP5: enable OTG role for DWC3 controller
Message-ID: <20180928173410.GK5662@atomide.com>
References: <0c739437f2331913e6593d651fd782fde3181e0a.1538150039.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c739437f2331913e6593d651fd782fde3181e0a.1538150039.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [180928 08:58]:
> Since SMPS10 and OTG cable detection extcon are described here, and
> work to enable OTG power when an OTG cable is plugged in, we can
> define OTG mode in the controller (which is disabled by default in
> omap5.dtsi).
> 
> Tested on OMAP5EVM and Pyra.
> 
> Suggested-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks applying into omap-for-v4.20/dt.

Regards,

Tony
