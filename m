Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeEAUvW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:51:22 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36137 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeEAUvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:51:17 -0400
X-Google-Smtp-Source: AB8JxZrIXYHUkREIq3uw5bGKkHgdwDAi03Ga8gDP1WAf7tU6vIXfj0TelSUK/oNsMHdQ74K9zrdWtg==
Subject: Re: [RFC net-next 4/5] net: phy: Add support for IEEE standard test
 modes
To: Woojung.Huh@microchip.com, netdev@vger.kernel.org
Cc: andrew@lunn.ch, rmk@armlinux.org.uk, linux-kernel@vger.kernel.org,
        davem@davemloft.net, cphealy@gmail.com,
        nikita.yoush@cogentembedded.com, vivien.didelot@savoirfairelinux.com,
        Nisar.Sayed@microchip.com, UNGLinuxDriver@microchip.com
References: <20180428003237.1536-1-f.fainelli@gmail.com>
 <20180428003237.1536-5-f.fainelli@gmail.com>
 <9235D6609DB808459E95D78E17F2E43D40D553D5@CHN-SV-EXMX02.mchp-main.com>
 <66f30fca-f485-7f52-7441-3c8cf1718640@gmail.com>
 <9235D6609DB808459E95D78E17F2E43D40D55B0A@CHN-SV-EXMX02.mchp-main.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6053df89-a77d-51bd-a72b-07f3cfa5fdde@gmail.com>
Date: Tue, 1 May 2018 13:51:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9235D6609DB808459E95D78E17F2E43D40D55B0A@CHN-SV-EXMX02.mchp-main.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 01:07 PM, Woojung.Huh@microchip.com wrote:
> Hi Florian,
> 
>> Not sure I completely understand your suggestion, do you mean that I
>> should break down the body of that function above such that there are
>> per-speed lower level functions? Something like the pseudo-code below:
>>
>> genphy_set_test() {
>> 	switch (mode) {
>> 	case PHY_STD_TEST_MODE_100BASET2_1:
>> 	..
>> 	case PHY_STD_TEST_MODE_100BASET2_3:
>> 		return genphy_set_100baset2();
>>
>> 	case PHY_STD_TEST_MODE_1000BASET_1:
>> 	..
>> 	case PHY_STD_TEST_MODE_1000BASET_4:
>> 		return genphy_set_1000baset();
>>
>> 	case PHY_STD_TEST_MODE_8021BWQCQ_1:
>> 		return genphy_set_100baset1();
>>
>> }
> Yes, I should write pseudo code. Sorry about confusion.
> User can override this function or expand to other modes.

Well, the way the code is structure is that if you call that function
with a test mode value that is not part of the standard set, it returns
-EOPNOTSUPP, so if your particular PHY driver wants to "overlay"
standard and non-standard modes, it can by using that hint.

This should work even if we have more standard test modes in the future
because the test modes are dynamically fetched by user-space using the
ETH_GSTRINGS ioctl().

Does that cover what you had in mind?
-- 
Florian
