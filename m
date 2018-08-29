Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE70C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7802084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7802084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeH2Qpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:45:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44278 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeH2Qpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:45:53 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fuzuA-0001hl-1p; Wed, 29 Aug 2018 14:49:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for rk3399
Date:   Wed, 29 Aug 2018 14:49:01 +0200
Message-ID: <6981249.NsEWD2NKQx@phil>
In-Reply-To: <1535104980-8456-2-git-send-email-tony.xie@rock-chips.com>
References: <1535104980-8456-1-git-send-email-tony.xie@rock-chips.com> <1535104980-8456-2-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Am Freitag, 24. August 2018, 12:03:00 CEST schrieb Tony Xie:
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>

I've added a commit message and applied the patch for 4.20.


Thanks
Heiko



