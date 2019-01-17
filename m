Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B7AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A7220652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAQNUx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:20:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60211 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbfAQNUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:20:53 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HDGMPL006367;
        Thu, 17 Jan 2019 14:20:46 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pyc01hrhv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 17 Jan 2019 14:20:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FF1831;
        Thu, 17 Jan 2019 13:20:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 14182F52;
        Thu, 17 Jan 2019 13:20:46 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 17 Jan
 2019 14:20:45 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 17 Jan 2019 14:20:45 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [RFC 1/7] devicetree: bindings: Document domains controller
 bindings
Thread-Topic: [RFC 1/7] devicetree: bindings: Document domains controller
 bindings
Thread-Index: AQHUrBdlW99PXR6Tt0G8EIwTIj32VaWyGVkAgAFMmwA=
Date:   Thu, 17 Jan 2019 13:20:45 +0000
Message-ID: <caeb0919-20ab-a27e-f2c1-10f97d868451@st.com>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
 <20190114144202.27315-2-benjamin.gaignard@st.com>
 <20190116173018.GD7186@sirena.org.uk>
In-Reply-To: <20190116173018.GD7186@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0B0FDC6969905F47BA7C043D8AA68423@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/16/19 6:30 PM, Mark Brown wrote:
> On Mon, Jan 14, 2019 at 03:41:56PM +0100, Benjamin Gaignard wrote:
>
>> +Common Domains Controller bindings properties
>> +
>> +Domains Controller framework defines common bindings properties to describe
>> +the configurations to be applied for each device.
> I suspect this is going to need a few more words about what a Domains
> Controller is.

Does the description of the framework in the cover letter looks better 
for you ?

I'm not comfortable to put it in bindings file but maybe I'm wrong.
