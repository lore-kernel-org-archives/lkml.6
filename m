Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDSKls (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:41:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:63440 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751957AbeDSKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:41:46 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, "Heiko Stubner" <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v2] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
Thread-Topic: [PATCH v2] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
Thread-Index: AQHToPxgKSTOodIeekOGT4vbRiBataQIMlOA
Date: Thu, 19 Apr 2018 10:41:03 +0000
Message-ID: <c55dab05-8003-ea5b-58f9-39aaa861fab6@st.com>
References: <20180208145805.24762-1-philippe.cornu@st.com>
 <101210971.aHjggv2rq0@avalon>
In-Reply-To: <101210971.aHjggv2rq0@avalon>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.120]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFA3071BA7863A43B8F21E8A6CFEBF21@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3JAftrB021104

Applied on drm-misc-next.
Many thanks,
Philippe :-)

On 02/08/2018 05:46 PM, Laurent Pinchart wrote:
> Hi Philippe,
> 
> Thank you for the patch.
> 
> On Thursday, 8 February 2018 16:58:05 EET Philippe Cornu wrote:
>> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
>> host controller driver.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> ---
>> Changes in v2: Update to "GPL-2.0+" following comments from Laurent
>> Pinchart, Benjamin Gaignard & Philippe Ombredanne.
>>
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
>> 7bac101c285c..99f0e4f51716 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -1,12 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>>   /*
>>    * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>>    * Copyright (C) STMicroelectronics SA 2017
>>    *
>> - * This program is free software; you can redistribute it and/or modify
>> - * it under the terms of the GNU General Public License as published by
>> - * the Free Software Foundation; either version 2 of the License, or
>> - * (at your option) any later version.
>> - *
>>    * Modified by Philippe Cornu <philippe.cornu@st.com>
>>    * This generic Synopsys DesignWare MIPI DSI host driver is based on the
>>    * Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.
> 
> 
