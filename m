Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeCEPc6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:32:58 -0500
Received: from mx1.riseup.net ([198.252.153.129]:39888 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeCEPcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:32:54 -0500
X-Riseup-User-ID: 0DAB4671C6ECB6750BD5FF63AF678A382BF205BB49DEDA51D45558D903BFFD0D
Subject: Re: [linux-sunxi] [PATCH v3 15/16] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
To: jernej.skrabec@siol.net
Cc: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-16-jernej.skrabec@siol.net>
From: =?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?= <joonas.kylmala@iki.fi>
Message-ID: <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
Date: Mon, 05 Mar 2018 15:27:00 +0000
MIME-Version: 1.0
In-Reply-To: <20180301213442.16677-16-jernej.skrabec@siol.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jernej Skrabec:
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};

This node is added to all the DTS files you enabled HDMI on. Is it
something that could be instead put to the DTSI file?

Joonas
