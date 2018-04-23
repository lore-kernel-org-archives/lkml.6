Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755658AbeDWPFE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:05:04 -0400
Received: from hermes.aosc.io ([199.195.250.187]:53239 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932069AbeDWPFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:05:02 -0400
Date: Mon, 23 Apr 2018 23:04:43 +0800
In-Reply-To: <20180423150309.dksr2rjazlrmlzx2@flea>
References: <20180423144657.63264-1-icenowy@aosc.io> <20180423144657.63264-4-icenowy@aosc.io> <20180423150309.dksr2rjazlrmlzx2@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 3/3] ARM: dts: sun8i: h3: Add SY8106A regulator to Orange Pi PC
To: Maxime Ripard <maxime.ripard@bootlin.com>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <34DAE9CF-AB6D-4FB9-9FA6-FAE4E4D2D4C3@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年4月23日 GMT+08:00 下午11:03:09, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Mon, Apr 23, 2018 at 10:46:57PM +0800, Icenowy Zheng wrote:
>> From: Ondrej Jirman <megous@megous.com>
>> 
>> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
>> Orange Pi PC, then set the power supply of the ARM cores to this
>> regulator, in order to enable DVFS.
>> 
>> Signed-off-by: Ondrej Jirman <megous@megous.com>
>> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>>  message]
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> [wens@csie.org: Rename regulator label]
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
>Why is there Chen-Yu's SoB? It doesn't really make much sense, unless
>Chen-Yu would have applied this patch already, but then you wouldn't
>post it, right?

This is taken from sunxi/h3-h5-for-4.18 branch, which has
label name change from wens, and then added microvolt property.

So his SoB is from when he apply it for the first time.

>
>Maxime 
>
>> ---
