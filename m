Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeBHIgF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:36:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60669 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750806AbeBHIgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:36:03 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Brian Norris" <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, Heiko Stubner <heiko@sntech.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org"
        <linux-rockchip@lists.infradead.org>
CC: Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v2] drm/bridge/synopsys: dsi: Add 1.31 version support
Thread-Topic: [PATCH v2] drm/bridge/synopsys: dsi: Add 1.31 version support
Thread-Index: AQHToK/v/ZsKlvi3rkql7JLuqqjYnaOaHViA
Date: Thu, 8 Feb 2018 08:35:18 +0000
Message-ID: <c43fbcbc-97f3-82de-4594-86211e930db9@st.com>
References: <CGME20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf@epcas1p3.samsung.com>
 <20180206084251.303-1-philippe.cornu@st.com>
 <bbe3ffeb-2e93-f36f-a8be-0319e16572e5@samsung.com>
In-Reply-To: <bbe3ffeb-2e93-f36f-a8be-0319e16572e5@samsung.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <233ACCA84FB7B246A06D39DBD83203D3@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w188aB0h016524

Many thanks
Philippe :-)

On 02/08/2018 08:39 AM, Andrzej Hajda wrote:
> On 06.02.2018 09:42, Philippe Cornu wrote:
>> Add support for the Synopsys DesignWare MIPI DSI version 1.31
>> Two registers need to be updated/added for supporting 1.31:
>> * PHY_TMR_CFG 0x9c (updated)
>>    1.30 [31:24] phy_hs2lp_time
>>         [23:16] phy_lp2hs_time
>>         [14: 0] max_rd_time
>>
>>    1.31 [25:16] phy_hs2lp_time
>>         [ 9: 0] phy_lp2hs_time
>>
>> * PHY_TMR_RD_CFG 0xf4 (new)
>>    1.31 [14: 0] max_rd_time
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> Queued to drm-misc-next.
> --
> Regards
> Andrzej
> 
