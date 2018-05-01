Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeEAUHM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:07:12 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:21829 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeEAUHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:07:10 -0400
X-IronPort-AV: E=Sophos;i="5.49,352,1520924400";
   d="scan'208";a="13445289"
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
Thread-Index: AQHT3ohy2ggOrlDWfkGtc62i2Sy80aQbJc3ggACLHwD//4uqMA==
Date: Tue, 1 May 2018 20:07:09 +0000
Message-ID: <9235D6609DB808459E95D78E17F2E43D40D55B0A@CHN-SV-EXMX02.mchp-main.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180428003237.1536-5-f.fainelli@gmail.com>
 <9235D6609DB808459E95D78E17F2E43D40D553D5@CHN-SV-EXMX02.mchp-main.com>
 <66f30fca-f485-7f52-7441-3c8cf1718640@gmail.com>
In-Reply-To: <66f30fca-f485-7f52-7441-3c8cf1718640@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.76.4]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w41K7GAI012160

Hi Florian,

> Not sure I completely understand your suggestion, do you mean that I
> should break down the body of that function above such that there are
> per-speed lower level functions? Something like the pseudo-code below:
> 
> genphy_set_test() {
> 	switch (mode) {
> 	case PHY_STD_TEST_MODE_100BASET2_1:
> 	..
> 	case PHY_STD_TEST_MODE_100BASET2_3:
> 		return genphy_set_100baset2();
> 
> 	case PHY_STD_TEST_MODE_1000BASET_1:
> 	..
> 	case PHY_STD_TEST_MODE_1000BASET_4:
> 		return genphy_set_1000baset();
> 
> 	case PHY_STD_TEST_MODE_8021BWQCQ_1:
> 		return genphy_set_100baset1();
> 
> }
Yes, I should write pseudo code. Sorry about confusion.
User can override this function or expand to other modes.

Thanks.
Woojung
