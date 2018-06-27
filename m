Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99975C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E4326669
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E4326669
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeF0Isc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:48:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60321 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932234AbeF0Isb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:48:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 92E1120876; Wed, 27 Jun 2018 10:48:28 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5C67D2079C;
        Wed, 27 Jun 2018 10:48:18 +0200 (CEST)
Date:   Wed, 27 Jun 2018 10:48:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ben Whitten <Ben.Whitten@lairdtech.com>
Cc:     "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>
Subject: Re: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
Message-ID: <20180627084819.GL4207@piout.net>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
 <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
 <BY1PR02MB1114B9B363091FC26668E454E7480@BY1PR02MB1114.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY1PR02MB1114B9B363091FC26668E454E7480@BY1PR02MB1114.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2018 08:42:17+0000, Ben Whitten wrote:
> Hi Alexandre,
> 
> As you are planning a clock binding rework and this patch in the series
> needs a change to account for that, do you want me to re-submit after
> your series or are we good to go as is?
> 

No change needed from you, I'll take care of the necessary changes.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
