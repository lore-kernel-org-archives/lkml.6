Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5E13CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05838208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="X3U8qY6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05838208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935369AbeFMSYv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:24:51 -0400
Received: from mail-eopbgr710067.outbound.protection.outlook.com ([40.107.71.67]:44320
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935006AbeFMSYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/6XQ1Li2kxwB+MEW1J+4JWvdkoE24jtC+6U/TpgDmA=;
 b=X3U8qY6l9pi+i8U/qwnuHrW6Yk65i2bwLFm9hwqXopmfQz1kk0w8STfYP1B5hiPi5CWHGlj4GBGYDhnoCyhqpea7bZuLAZ5douemLkz7zoKe1KXy/Jsyh0X19T6dDI8FouGkxJZQSUzlqs5lNxg6QUJKM0wNpOHwThCxg3qU4XM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4021.namprd05.prod.outlook.com (52.135.199.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 18:24:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%2]) with mapi id 15.20.0863.016; Wed, 13 Jun 2018
 18:24:46 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] vmw_balloon: update copyright message
Thread-Topic: [PATCH 1/7] vmw_balloon: update copyright message
Thread-Index: AQHUA0L+ZRNuiy6utkCySUB3gWemF6Ref/KAgAABHoA=
Date:   Wed, 13 Jun 2018 18:24:45 +0000
Message-ID: <2800794D-1761-4384-B725-55033C571246@vmware.com>
References: <20180613110359.109033-1-namit@vmware.com>
 <20180613110359.109033-2-namit@vmware.com> <20180613182041.GB29631@kroah.com>
In-Reply-To: <20180613182041.GB29631@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4021;7:hd9rqG0SwzRNVrkSyMqrta8pgSsxQjdjS+k6Eansx56EoXaTg6X5xeVhCAgdZr4aD9grnwdDIi+g65pwjHK0DDW+tGtgs/ATF4fW/DFWX0Y3seEm0LuAmeUeTFV+5BeYmVsjxUbUtBS3oie3itwmRfYyG5VsolGIf7qe0aImmqZRBDAOsD3zcEIf7ohQC1CAK9Uim+pRRA6H6Y0htsXGzgSdtfoekV1y+eRhd8GZKHWP/5nXnVW3IRKV2rQE63ka;20:4ygc5N9kRPxGYwndFaPJ+dRxjDZ9hffU7Z9daEL8OEfmt7lRjnICMxwizhisGdsQX1zfUL7qcrwQSMJQ2HZvCqN5H3u65EYE4/4r7kj/azV1rcn8MtlhU0RwEPdX86yDUUAcUF3z3Nh2lTGBok1wDvPRrzVBDSSFoBqghJ3M0pk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 059e2b33-72b8-4dbd-470a-08d5d15af0ec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4021;
x-ms-traffictypediagnostic: BYAPR05MB4021:
x-microsoft-antispam-prvs: <BYAPR05MB40217C1B1D63937BB8DF42E0D07E0@BYAPR05MB4021.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4021;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4021;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(366004)(396003)(346002)(199004)(189003)(229853002)(6512007)(53936002)(54906003)(3846002)(2900100001)(68736007)(6916009)(76176011)(5250100002)(6486002)(6116002)(25786009)(33656002)(14454004)(5660300001)(186003)(3660700001)(59450400001)(6246003)(316002)(99286004)(4326008)(305945005)(97736004)(3280700002)(15650500001)(82746002)(26005)(476003)(36756003)(81166006)(486006)(8676002)(81156014)(106356001)(102836004)(8936002)(6506007)(478600001)(2906002)(83716003)(11346002)(66066001)(6436002)(2616005)(105586002)(7736002)(86362001)(446003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4021;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eGlguE8itO8n/KJZaE+eFWlSeabooxDlMSyxeghVU1xqlShl+b5sQjU4KfP8bqWpzou0Pv6R/dd/RppY9QAsDfpS+MP+5dsKDYgvtSAj9pIifMyZ75wuidUsFW/ok+GO0M/2k0Qk9g2L0ufP1/8J6xkBRz7+zqMqyo5FpAyWpPBM8ksehQahdFTLmL1wZwfr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <393A976EC22D804BB020D80770D71843@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059e2b33-72b8-4dbd-470a-08d5d15af0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 18:24:45.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 11:20 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Jun 13, 2018 at 04:03:53AM -0700, Nadav Amit wrote:
>> Removing the paragraph about writing to the Free Software Foundation's
>> mailing address from the sample GPL notice according to checkpatch
>> request.
>>=20
>> In addition, updating the year and adding a license tag.
>>=20
>> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
>> Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
>> ---
>> drivers/misc/vmw_balloon.c | 6 ++----
>> 1 file changed, 2 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index efd733472a35..1d50ed630d30 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -1,7 +1,7 @@
>> /*
>>  * VMware Balloon driver.
>>  *
>> - * Copyright (C) 2000-2014, VMware, Inc. All Rights Reserved.
>> + * Copyright (C) 2000-2018, VMware, Inc. All Rights Reserved.
>>  *
>>  * This program is free software; you can redistribute it and/or modify =
it
>>  * under the terms of the GNU General Public License as published by the
>> @@ -13,9 +13,7 @@
>>  * NON INFRINGEMENT.  See the GNU General Public License for more
>>  * details.
>>  *
>> - * You should have received a copy of the GNU General Public License
>> - * along with this program; if not, write to the Free Software
>> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301=
 USA.
>> + * SPDX-License-Identifier: GPL-2.0
>=20
> This goes as the first line of the file, please see the documentation
> files that describes how to do this properly.

Of course. I was sure I fixed it... I will resend.

