Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9C4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ACD20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ACD20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeIDJcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:32:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51290 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDJcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:32:36 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0917312139FE8;
        Mon,  3 Sep 2018 22:09:10 -0700 (PDT)
Date:   Mon, 03 Sep 2018 22:09:10 -0700 (PDT)
Message-Id: <20180903.220910.899357653888940454.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     andrew@lunn.ch, quentin.schulz@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180903134522.GC13888@piout.net>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
        <20180903133415.GF4445@lunn.ch>
        <20180903134522.GC13888@piout.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Sep 2018 22:09:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 3 Sep 2018 15:45:22 +0200

> On 03/09/2018 15:34:15+0200, Andrew Lunn wrote:
>> > I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go through
>> > net while the others (6, 7, 9 and 10) go through the generic PHY subsystem.
>> 
>> Hi Quentin
>> 
>> Are you expecting merge conflicts? If not, it might be simpler to gets
>> ACKs from each maintainer, and then merge it though one tree.
>> 
> 
> There are some other DT changes for this cycle so those should probably
> go through MIPS.

No objection for this going through the MIPS tree, and from me:

Acked-by: David S. Miller <davem@davemloft.net>
