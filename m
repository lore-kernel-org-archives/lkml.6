Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9489C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB4020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB4020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbeLNMXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:23:45 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38408 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732119AbeLNMNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:13:30 -0500
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gXmLL-0006WM-2O; Fri, 14 Dec 2018 13:13:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>, maxime.ripard@bootlin.com,
        Zheng Yang <zhengyang@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/8] drm/bridge: dw-hdmi: support dynamically get input/out color info
Date:   Fri, 14 Dec 2018 13:13:22 +0100
Message-ID: <1602894.V8qvSO823h@phil>
In-Reply-To: <20181130134301.17963-6-narmstrong@baylibre.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com> <20181130134301.17963-6-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 30. November 2018, 14:42:58 CET schrieb Neil Armstrong:
> From: Zheng Yang <zhengyang@rock-chips.com>
> 
> To get input/output bus_format/enc_format dynamically, this patch
> introduce following funstion in plat_data:
> 	- get_input_bus_format
> 	- get_output_bus_format
> 	- get_enc_in_encoding
> 	- get_enc_out_encoding
> 
> Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Please see comments in patch1 for details.

on rk3288 and rk3328
Tested-by: Heiko Stuebner <heiko@sntech.de>



