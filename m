Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966979AbeBPPOH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:14:07 -0500
Received: from smtp-out4.electric.net ([192.162.216.195]:55819 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754656AbeBPPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:14:06 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Andy Shevchenko'" <andy.shevchenko@gmail.com>,
        Colin King <colin.king@canonical.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtc: tx4939: avoid unintended sign extension on a 24 bit
 shift
Thread-Topic: [PATCH] rtc: tx4939: avoid unintended sign extension on a 24 bit
 shift
Thread-Index: AQHTpzHGbbIPWmdklUiP8WQgOs1f7qOnItaA
Date: Fri, 16 Feb 2018 15:14:51 +0000
Message-ID: <d943a549d051472c98e3c163dc4245ac@AcuMS.aculab.com>
References: <20180215185941.27547-1-colin.king@canonical.com>
 <CAHp75Vf+ky3Ma1b20x57i9z+ykS1j8k1LTuOT3f=Jbu5kCeeAQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf+ky3Ma1b20x57i9z+ykS1j8k1LTuOT3f=Jbu5kCeeAQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1GFEB3C001653

From: Andy Shevchenko
> Sent: 16 February 2018 14:23
...
> Wouldn't be better to use le32_to_cpu() or get_unaligned()?

Or shoot the members of the ANSI C committee who insisted on
promotion of unsigned char/short to int and sign preserving
promotion of int to unsigned long :-)

	David
