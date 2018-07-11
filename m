Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2F920846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2F920846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbeGKNgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:36:02 -0400
Received: from muru.com ([72.249.23.125]:51100 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732721AbeGKNgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:36:02 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A5E0D809B;
        Wed, 11 Jul 2018 13:34:44 +0000 (UTC)
Date:   Wed, 11 Jul 2018 06:31:37 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Koen Kooi <koen@dominion.thruhere.net>
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Message-ID: <20180711133137.GM99251@atomide.com>
References: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
 <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [180711 07:36]:
> +&cpu0_opp_table {
> +	/*
> +	 * All PG 2.0 silicon may not support 1GHz but some of the early
> +	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
> +	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
> +	 */
> +	oppnitro-1000000000 {
> +		opp-supported-hw = <0x06 0x0100>;
> +	};
> +};

Is the above valid for new boards or should it be just
dropped? Or is the comment just out of date?

Regards,

Tony
