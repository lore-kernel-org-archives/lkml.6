Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233DCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE18F217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="shzU6wWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfBFUj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:39:56 -0500
Received: from mail-eopbgr730081.outbound.protection.outlook.com ([40.107.73.81]:26752
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbfBFUj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chejGIxjKvnZtnS759YWqta0PuaQi6Uj7VEM8AL/V0M=;
 b=shzU6wWURvut/NIoh9xRJQwGoDwoWyxsi5vTMbB+baNiTNii204N7gO+nVN1VdsYGbTPQXZRs+V/8N5ELdRUjMroOYAynCKmub67QjmXHj5i131/MPPy/NI9Nvf4ZDUfZITYSawJCB7IvC9ECEs/uU3GT4ETCqzCGB/08fQt8fY=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5665.namprd05.prod.outlook.com (10.167.240.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.9; Wed, 6 Feb 2019 20:39:53 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::52e:b645:417c:a4cf]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::52e:b645:417c:a4cf%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 20:39:53 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH 1/6] vmw_balloon: bump version number
Thread-Topic: [PATCH 1/6] vmw_balloon: bump version number
Thread-Index: AQHUvdqzIjtzT9t97UifPzgt+4rp6aXS+kOAgABCQAA=
Date:   Wed, 6 Feb 2019 20:39:52 +0000
Message-ID: <83759B2D-329A-4CBA-84A4-0511398D1AB2@vmware.com>
References: <20190206051336.2425-1-namit@vmware.com>
 <20190206051336.2425-2-namit@vmware.com> <20190206164245.GA8466@kroah.com>
In-Reply-To: <20190206164245.GA8466@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB5665;20:oj7rSIAXvVa2iJWRBmJRITAo0QHIrFfbSNAOPoqePJj/2zEOGTqIerYW1hq7ljHnZ6ulRYTGZW6uKsM7HMi6/TGqwg173roa8KkyWOZR+vgR8VnRnHh+6bNx2DEde/42aNnxqW3D4JcW/ei6J0fgwyXTYaaBRievfQwweoomO40=
x-ms-office365-filtering-correlation-id: 835c3088-c753-4036-e2e8-08d68c733f4c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB5665;
x-ms-traffictypediagnostic: BL0PR05MB5665:
x-microsoft-antispam-prvs: <BL0PR05MB56658DFFE91FFA0BD2FD2202D06F0@BL0PR05MB5665.namprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(25786009)(86362001)(82746002)(6246003)(4326008)(186003)(229853002)(446003)(476003)(53936002)(6436002)(6512007)(6116002)(26005)(2616005)(11346002)(3846002)(107886003)(486006)(102836004)(478600001)(6916009)(33656002)(14454004)(97736004)(316002)(54906003)(81166006)(81156014)(8936002)(66066001)(6486002)(7736002)(305945005)(71190400001)(71200400001)(8676002)(2906002)(83716004)(256004)(6506007)(106356001)(53546011)(36756003)(68736007)(105586002)(99286004)(76176011)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5665;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iqeoTRaMhsFvhqHof6UUva7WS7PLry97gaXNR03DvT7h5JQ/EK7vrdNaE3bln1EfzBg2e3qKtIYdDeFRps8Eo53xTxKSrikkPXUDfzwe4dfmNVbhAIu6nHTp18veP9z4rGhNlq1LbvQE1Wcrdu1AL29MMFT4L2R6at1ONjGiCGShZQqxkmKoJ+lmFyd6VhWpVC0XT/nOsPn/dhmqUh0iqWYF5IuUL7I+r3KSFCneQKmoCV2rkeQQWu2jWLfng5ALq5P8JW1fnzVOSJ6OCrylp4gZX7IJmkKd7zqNHfeH6kQdYKE5bAhMi5bcipON2L+fwZ7pTdaarpP4DyMdgyhP1lNMFd6/hZY2QRBmFUMZjVhMncsAQPLquKBFhZthk90HRyoLM3R9DszeXasfxiiuB5ADNbXErigeSRmpKxE0BPE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FD52567B443DE47B770F60308387EB3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c3088-c753-4036-e2e8-08d68c733f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 20:39:52.9354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5665
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 6, 2019, at 8:42 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
> On Tue, Feb 05, 2019 at 09:13:31PM -0800, Nadav Amit wrote:
>> Following recent changes.
>>=20
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> drivers/misc/vmw_balloon.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index f8240b87df22..7294f305753f 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -34,7 +34,7 @@
>>=20
>> MODULE_AUTHOR("VMware, Inc.");
>> MODULE_DESCRIPTION("VMware Memory Control (Balloon) Driver");
>> -MODULE_VERSION("1.5.0.0-k");
>> +MODULE_VERSION("1.6.0.0-k");
>=20
> Please just drop this pointless line, it means nothing and is always out
> of date.  It's been removed from many other drivers, and I really don't
> want to see it come back.
>=20
> Your driver "version" is the kernel version, full stop.  That's all you
> need to ever worry about.

I understand, and I will inform those who asked for the version bump.

Having said that, I do not see a reference for this policy. I understand
that you removed the MODULE_VERSION from in-kernel drivers, but I also see
that you accepted several drivers last year that used MODULE_VERSION.

