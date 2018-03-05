Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeCEScQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:32:16 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:58827 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752814AbeCEScO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:32:14 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: joonas.kylmala@iki.fi
Cc: linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com,
        wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v3 15/16] ARM: dts: sun8i: h3: Enable HDMI output on H3 boards
Date: Mon, 05 Mar 2018 19:24:44 +0100
Message-ID: <24923386.1anQU1Bm90@jernej-laptop>
In-Reply-To: <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
References: <20180301213442.16677-1-jernej.skrabec@siol.net> <20180301213442.16677-16-jernej.skrabec@siol.net> <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 05. marec 2018 ob 16:27:00 CET je Joonas Kylmälä napisal(a):
> Jernej Skrabec:
> > +&hdmi_out {
> > +	hdmi_out_con: endpoint {
> > +		remote-endpoint = <&hdmi_con_in>;
> > +	};
> > +};
> 
> This node is added to all the DTS files you enabled HDMI on. Is it
> something that could be instead put to the DTSI file?

I guess that would mean also including connector node (hdmi_con_in) in DTSI, 
since it is referenced inside. However, not all boards have HDMI connector, so 
I didn't include it in DTSI.

Best regards,
Jernej
