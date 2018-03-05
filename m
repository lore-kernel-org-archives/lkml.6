Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeCEUnv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:43:51 -0500
Received: from mx1.riseup.net ([198.252.153.129]:32851 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752919AbeCEUnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:43:49 -0500
X-Riseup-User-ID: 8036BE19020E170BE2A955C7B7D4EDA40C2C3E756F39423AAF5A2F0936B7F3F0
Subject: Re: [linux-sunxi] [PATCH v3 15/16] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
To: =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>
Cc: linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com,
        wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-16-jernej.skrabec@siol.net>
 <57afe052-9a8c-f63b-ee43-5bad8cd1d193@iki.fi>
 <24923386.1anQU1Bm90@jernej-laptop>
From: =?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?= <joonas.kylmala@iki.fi>
Message-ID: <7f34f281-fa61-44b4-60a0-fa4843bc27c1@iki.fi>
Date: Mon, 05 Mar 2018 20:43:00 +0000
MIME-Version: 1.0
In-Reply-To: <24923386.1anQU1Bm90@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jernej Škrabec:
> I guess that would mean also including connector node (hdmi_con_in) in DTSI, 
> since it is referenced inside. However, not all boards have HDMI connector, so 
> I didn't include it in DTSI.

You're absolutely right on this. I wish there was someway to get rid of
this duplication but that's a whole different problem to discuss.

Great work by the way!

Joonas
