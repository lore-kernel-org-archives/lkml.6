Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeCWDkD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:40:03 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39027 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeCWDkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:40:01 -0400
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Wolfram Sang <wsa@the-dreams.de>, Rich Felker <dalias@libc.org>
CC: "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Thread-Topic: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Thread-Index: AQHS9XdxjhgoGSTbFEG3Cn1zYNucCw==
Date: Fri, 23 Mar 2018 03:39:47 +0000
Message-ID: <8564c3ea3b3c4b08b940b02acf501722@svr-chch-ex1.atlnz.lc>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
 <20171029172918.2xtz2srh2meq45io@ninjato>
 <20171207104205.h5ejivdmtharmdln@ninjato>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N3eAM6018845

On 07/12/17 23:42, Wolfram Sang wrote:
> On Sun, Oct 29, 2017 at 06:29:18PM +0100, Wolfram Sang wrote:
>> On Wed, Jul 05, 2017 at 10:13:54PM +1200, Chris Packham wrote:
>>> This series addresses some of the points identified by Andy. The series is
>>> based on top of i2c/for-next. 2 of the patches from v1 have already been
>>> applied so I've dropped them from this version.
>>>
>>> I have compile tested patch 1/1 but I don't have access to sh hardware
>>> to actually test the changes on.
>>>
>>> Chris Packham (4):
>>>    sh: sh7785lcr: add GPIO lookup table for i2c controller reset
>>>    i2c: pca-platform: unconditionally use devm_gpiod_get_optional
>>>    i2c: pca-platform: use device_property_read_u32
>>>    i2c: pca-platform: drop gpio from platform data
>>>
>>>   arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
>>>   arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-
>>>   drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++----------------------
>>>   include/linux/i2c-pca-platform.h          |  3 ---
>>>   4 files changed, 20 insertions(+), 29 deletions(-)
>>
>> Series looks good to me, too. I'd need ACKs from the SH maintainers,
>> though. Technically, from Blackfin maintainers as well. But I haven't
>> heard from them in months, so I could go without that.
> 
> Adding Rich Felker to CC...
> 

Ping. Was there any movement on this series? I think this may have been 
caught up between the holiday period and various merge windows.

Just wanted to check if there was anything I need to be doing to get 
this through.
