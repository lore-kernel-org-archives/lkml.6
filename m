Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71205C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447C214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3447C214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeIZRsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:48:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38152 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbeIZRsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:48:11 -0400
Received: from wd0156.dip.tu-dresden.de ([141.76.108.156] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g5868-0002zs-CT; Wed, 26 Sep 2018 13:35:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     Deepak_das@mentor.com, Pragnesh_patel@mentor.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Levin Du <djw@t-chip.com.cn>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: add initial dts support for Rockpro64
Date:   Wed, 26 Sep 2018 13:35:15 +0200
Message-ID: <6748636.LqZcXZ9sFQ@phil>
In-Reply-To: <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com> <1537943105-21247-1-git-send-email-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. September 2018, 08:24:57 CEST schrieb Akash Gajjar:
> Rockpro64 is a rockchip RK3399 based board from pine64.org.
> This patch adds basic device node support for Rockpro64 board and make it able
> to bring up.
> 
> Peripheral Works
> - Sdcard
> - USB 2.0, 3.0
> - Leds
> - Ethernet
> - Debug console
> 
> Not working:
> - USB Type-C
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

applied for 4.20.

For future patches, please keep in mind to transfer received tags from
one version to the next. v2 received a "Reviewed-by" from Rob, so ideally
it should have been included below your Signed-off in v3.

I've picked that tag myself from v2, so no need to do anything now,
just for the next time ;-)

Thanks
Heiko


