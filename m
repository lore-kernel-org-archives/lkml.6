Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbeCSWA5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934559AbeCSWAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:00:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC5721736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180316175354.21437-2-icenowy@aosc.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
 <20180316175354.21437-2-icenowy@aosc.io>
Message-ID: <152149685123.242365.3440079243287970205@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/7] dt-bindings: add compatible string for the A64 DE2 CCU
Date: Mon, 19 Mar 2018 15:00:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Icenowy Zheng (2018-03-16 10:53:48)
> The Allwinner A64 SoC has a DE2 CCU like the one in the DE2 of Allwinner
> H5 SoC.
> 
> Add a compatible string for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
