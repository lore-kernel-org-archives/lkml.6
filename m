Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MIME_CHARSET_FARAWAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8F91AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F341208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F341208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754805AbeFNIPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:15:15 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:48496 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754602AbeFNIPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:15:11 -0400
Received: from david.wu?rock-chips.com (unknown [192.168.165.103])
        by regular1.263xmail.com (Postfix) with ESMTP id C29651DEFB;
        Thu, 14 Jun 2018 16:15:00 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [10.10.5.129] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 7DCA242B;
        Thu, 14 Jun 2018 16:14:38 +0800 (CST)
X-RL-SENDER: david.wu@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 77.243.177.107
X-LOGIN-NAME: david.wu@rock-chips.com
X-UNIQUE-TAG: <2b3af7e90090ba24fa1dac33ed417b8a>
X-ATTACHMENT-NUM: 0
X-SENDER: wdc@rock-chips.com
X-DNS-TYPE: 1
Received: from [10.10.5.129] (de12.perfectdeals.xyz [77.243.177.107])
        by smtp.263.net (Postfix) whith ESMTP id 25971W73AXC;
        Thu, 14 Jun 2018 16:14:56 +0800 (CST)
Subject: Re: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for
 PX30
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
 <1961033.25ax7s0Z5i@diego>
From:   David Wu <david.wu@rock-chips.com>
Message-ID: <3aa2445f-ab2a-93b6-3a49-36be6c98d327@rock-chips.com>
Date:   Thu, 14 Jun 2018 16:14:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1961033.25ax7s0Z5i@diego>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

在 2018年06月14日 15:54, Heiko Stübner 写道:
> I don't see that new clock documented in the dt-binding.
> Also, which clock from the clock-controller does this connect to?

The clock is the "SCLK_GMAC_RMII" at the clock-controller, which could 
be set rate by the link speed.

