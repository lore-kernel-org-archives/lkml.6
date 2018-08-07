Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A460C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22660215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 22:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22660215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeHHBFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:05:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52430 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHBFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:05:38 -0400
Received: from localhost (c-73-240-71-155.hsd1.or.comcast.net [73.240.71.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EEC7C13F1B8CF;
        Tue,  7 Aug 2018 15:49:01 -0700 (PDT)
Date:   Tue, 07 Aug 2018 15:49:01 -0700 (PDT)
Message-Id: <20180807.154901.1465546829516526941.davem@davemloft.net>
To:     andrew@lunn.ch
Cc:     arun.parameswaran@broadcom.com, f.fainelli@gmail.com,
        vivien.didelot@savoirfairelinux.com, robh+dt@kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 0/3] Add Broadcom Omega SoC internal switch and phy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180807180827.GH18350@lunn.ch>
References: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
        <20180807180827.GH18350@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Aug 2018 15:49:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 7 Aug 2018 20:08:27 +0200

> On Tue, Aug 07, 2018 at 10:02:41AM -0700, Arun Parameswaran wrote:
>> Hi,
>> 
>> The patchset is based on David Miller's "net-next" repo.
>> 
>> The patches add support for the Broadcom Omega SoC's internal ethernet
>> switch and the internal gphy.
>> 
>> The internal ethernet switch in the Omega is a b53 srab based switch.
>> The support for the switch is added to the b53 driver in the dsa
>> framework.
>> 
>> The gphy support is added to the bcm7xxx driver.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Series applied.
