Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38F60C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A3D208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="gKZKHwXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A3D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeFNFdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:33:52 -0400
Received: from mail-bl2nam02on0085.outbound.protection.outlook.com ([104.47.38.85]:21328
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751560AbeFNFdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig9/cpL9ln3pGKwlH61ro7GVP0annOVUAr8TQciaze0=;
 b=gKZKHwXdoCQzbg95jjB3vN9NVQTpELFxQGgKLB7ihRGDePC9pG1K69AFx7DP9fHEG6hadflux1NgMptMOc3GgXqpYhFhjCwOEjePQlaGnCE19y83GNncAqqKa1DVGva3yNUtoyhkXIQmVfi8dmQA9dk07idDtvx+xNzKFVK+rbY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3957.namprd05.prod.outlook.com (52.135.195.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Thu, 14 Jun 2018 05:33:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%3]) with mapi id 15.20.0884.010; Thu, 14 Jun 2018
 05:33:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 6/7] vmw_balloon: update copyright message
Thread-Topic: [PATCH v2 6/7] vmw_balloon: update copyright message
Thread-Index: AQHUA1rMO9cx543LJ0SFW/MABZa0SKRfOSaAgAACqQA=
Date:   Thu, 14 Jun 2018 05:33:46 +0000
Message-ID: <F8F02A0A-133F-458A-9492-30C3ABD8C592@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
 <20180613135412.81660-7-namit@vmware.com> <20180614052413.GB29739@kroah.com>
In-Reply-To: <20180614052413.GB29739@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3957;7:rKyL/r9FY+L//BN5kzdoSyotVtEtzC3L6wP2QR+8mge65xhBZd6idau6CjqYVaCleJjm0yECHK6Jenq87cizzfEn1d+wghFi0zOMAv+KycJG8dTvaR0PpJm9PB8cgXo2+/bnx7JsxBTh2BA4Qimy24JRqyDWD5EGuXEdl+Ljw6wrHAa4LPMw11mU4zL0NxvB7L7B7jqcjHma26szF30+pTzZJmC6QEghHSJfWMqzTnVcCO97Qv1GXJa1CH0bdhOi;20:sqMPw3UeYSBAEWbfut6xFrl4adQQvXEaj/1ZKWh1R1EgOWz/zcBha+kBwkmJxcp7i322iu5GfYOwNTlaCetWPUgGmKauVWkvrxSMHPzcCSPrfUAs/uOwTXsc+cwOABeMggi3DSmxrR0OQpGPQJAP4Qj/Ac/xNt936Q9kYAcltJ8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 28896e32-eb26-4a71-3dbe-08d5d1b86670
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3957;
x-ms-traffictypediagnostic: BYAPR05MB3957:
x-microsoft-antispam-prvs: <BYAPR05MB3957D3857D0E82126FAB13E0D07D0@BYAPR05MB3957.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB3957;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3957;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(39380400002)(199004)(189003)(6246003)(6506007)(99286004)(5660300001)(86362001)(59450400001)(25786009)(83716003)(15650500001)(6486002)(8936002)(6436002)(26005)(3660700001)(14454004)(102836004)(186003)(305945005)(6512007)(8676002)(68736007)(53936002)(81156014)(6116002)(81166006)(3846002)(76176011)(2906002)(5250100002)(3280700002)(7736002)(316002)(2900100001)(4326008)(2616005)(54906003)(11346002)(446003)(66066001)(476003)(82746002)(6916009)(478600001)(36756003)(106356001)(97736004)(33656002)(105586002)(229853002)(486006)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3957;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: whRCupXTTEoKlGpmO1V6sT2hAgH31HFdGpImsVi6LtusSSveVmLXzXamSgmNXBFzpT+inD9emgg8wInENH15wZBJtvt9mi6cp2ZzvI9gzZoAjX3FNQBSIQYxnpbP4p5lb8gVM6huPd3ruyZXz9RpBRHF36pJqRhSvlO3VczTuk/vWhWjpERert2EygSSDIYe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C75357FC3A9DB149BEE2BDA72D37966E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28896e32-eb26-4a71-3dbe-08d5d1b86670
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 05:33:46.3481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 10:24 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Jun 13, 2018 at 06:54:11AM -0700, Nadav Amit wrote:
>> Removing the paragraph about writing to the Free Software Foundation's
>> mailing address from the sample GPL notice according to checkpatch
>> request.
>>=20
>> In addition, updating the year and adding a license tag.
>>=20
>> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
>> Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
>> ---
>> drivers/misc/vmw_balloon.c | 7 ++-----
>> 1 file changed, 2 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index 400a1ccefc8e..b982059ce7b7 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -1,7 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> /*
>>  * VMware Balloon driver.
>>  *
>> - * Copyright (C) 2000-2014, VMware, Inc. All Rights Reserved.
>> + * Copyright (C) 2000-2018, VMware, Inc. All Rights Reserved.
>>  *
>>  * This program is free software; you can redistribute it and/or modify =
it
>>  * under the terms of the GNU General Public License as published by the
>> @@ -13,10 +14,6 @@
>>  * NON INFRINGEMENT.  See the GNU General Public License for more
>>  * details.
>=20
> You still have a lot of boiler-plate text in here that can be removed.
> Please do so.

I will remove the maintainers, since it is really unsuitable.

But what else do you want me to remove? This is a standard GPL license. If =
I
am required to remove the GPL license, I will have to run checks to ensure
it is appropriate.

Thanks,
Nadav
