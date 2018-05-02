Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeEBN5s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:57:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750936AbeEBN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:57:47 -0400
From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Olivier BIDEAU <olivier.bideau@st.com>,
        "Loic PALLARDY" <loic.pallardy@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
Thread-Topic: [PATCH] clk: stm32mp1: Add CLK_IGNORE_UNUSED to ck_sys_dbg clock
Thread-Index: AQHT26IegJG+GpTXWkeXcO0ng8oO16QbWYOAgAEIroA=
Date: Wed, 2 May 2018 13:57:23 +0000
Message-ID: <fc59c88c-b25a-8e6f-ec14-5e7abba07829@st.com>
References: <1524556723-26926-1-git-send-email-gabriel.fernandez@st.com>
 <152521260300.138124.15551649788620481848@swboyd.mtv.corp.google.com>
In-Reply-To: <152521260300.138124.15551649788620481848@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EB821F0BA818442A264F974E894EEED@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w42DvrNN021489

Hi Stephen,

This patch is not a critical fix for this merge window.

Thanks

Gabriel


On 05/02/2018 12:10 AM, Stephen Boyd wrote:
> Quoting gabriel.fernandez@st.com (2018-04-24 00:58:43)
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> Don't disable the dbg clock if was set by bootloader.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
> Is this a critical fix for this merge window? Please add "Fixes:" tag.
>
