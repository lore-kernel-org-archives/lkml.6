Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeEGAC3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 20:02:29 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61564 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEGAC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 20:02:27 -0400
X-IronPort-AV: E=Sophos;i="5.49,371,1520924400";
   d="scan'208";a="11773686"
From: <Woojung.Huh@microchip.com>
To: <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <rmk@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
        <cphealy@gmail.com>, <nikita.yoush@cogentembedded.com>,
        <vivien.didelot@savoirfairelinux.com>, <Nisar.Sayed@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [RFC net-next 4/5] net: phy: Add support for IEEE standard test
 modes
Thread-Topic: [RFC net-next 4/5] net: phy: Add support for IEEE standard
 test modes
Thread-Index: AQHT3ohy2ggOrlDWfkGtc62i2Sy80aQbJc3ggACLHwD//4uqMIAAl/MAgAea0HA=
Date: Mon, 7 May 2018 00:02:25 +0000
Message-ID: <9235D6609DB808459E95D78E17F2E43D40D62045@CHN-SV-EXMX02.mchp-main.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180428003237.1536-5-f.fainelli@gmail.com>
 <9235D6609DB808459E95D78E17F2E43D40D553D5@CHN-SV-EXMX02.mchp-main.com>
 <66f30fca-f485-7f52-7441-3c8cf1718640@gmail.com>
 <9235D6609DB808459E95D78E17F2E43D40D55B0A@CHN-SV-EXMX02.mchp-main.com>
 <6053df89-a77d-51bd-a72b-07f3cfa5fdde@gmail.com>
In-Reply-To: <6053df89-a77d-51bd-a72b-07f3cfa5fdde@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.215.7]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4702ZVO004400

Hi Florian,

> Well, the way the code is structure is that if you call that function
> with a test mode value that is not part of the standard set, it returns
> -EOPNOTSUPP, so if your particular PHY driver wants to "overlay"
> standard and non-standard modes, it can by using that hint.
> 
> This should work even if we have more standard test modes in the future
> because the test modes are dynamically fetched by user-space using the
> ETH_GSTRINGS ioctl().
> 
> Does that cover what you had in mind?
Basically, agree on your explanation.

My idea was making genphy_set_test() more expandable for other test modes
because it would be a good place to add more standard test modes later.

No problem to keep current codes.

Thanks.
Woojung
