Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922D2222BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KoCxArB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbfBLSco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:32:44 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19522 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbfBLScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:32:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6311270000>; Tue, 12 Feb 2019 10:32:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2019 10:32:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Feb 2019 10:32:41 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 18:32:41 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 12 Feb 2019 18:32:41 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3511.namprd12.prod.outlook.com (20.179.94.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Tue, 12 Feb 2019 18:32:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1622.016; Tue, 12 Feb 2019
 18:32:39 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "peda@axentia.se" <peda@axentia.se>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Topic: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Index: AQHUwwC2JXxCj8zR6065fKM7Y4JWNKXce7pg
Date:   Tue, 12 Feb 2019 18:32:38 +0000
Message-ID: <BYAPR12MB3398679040C6ED2E129CEBFBC2650@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549996081-6858-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1549996081-6858-1-git-send-email-skomatineni@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0a8acf8-4179-4f9a-7e29-08d691187797
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3511;
x-ms-traffictypediagnostic: BYAPR12MB3511:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR12MB3511;23:SgOQcJaofcQX73S6nSjk1/6grt8ABRvNf2nh45qkL?=
 =?us-ascii?Q?VRYVDjhdHblHOwOzoIj/i5wgtGCYo9q6fqLoErk/MoxUdXPvwmIvcZxGmITt?=
 =?us-ascii?Q?opuh37hzE1GgZaurUDsz2y4sWMO7W1HOP0zxC2fWkQILsF9PYChZh8hNnvvl?=
 =?us-ascii?Q?QgCxyEorkn7B2FLfeCaxeQaalfUdq4R3Tyw6GkC4eA9rtoqIuMd4dYWugtfH?=
 =?us-ascii?Q?9cSWR9jEhVryqhEKuKFRorKzDUserqNGg+hqvwFK9CdGHPhqNCXF+ZWSJmpu?=
 =?us-ascii?Q?3PFO1N5KnBPOUVgpkh+QuqibN+HltJ7k707soDXeHzasIm/WCJ2Roh5pwMiB?=
 =?us-ascii?Q?zzg7wvU2SP/15VWHu81TysRVNZ96EPBF91UPHFXmHBhXZuhRs7OxQP7Fndyc?=
 =?us-ascii?Q?zcQxO6ZrjNyKOAxXx6qeXaRLzCinlh2YlZuVCcq3ahNGP8DDkjiV9SB28cq2?=
 =?us-ascii?Q?CDzwHDg3EGd3aoWA/I6leUOPimskmDlMzqFaSp1qu5RWlku58GjhmmkVyePT?=
 =?us-ascii?Q?JOOmW5331d+4ZEKwsjKvjdE1B/0YSaCzfIrReoyyGg2+NQ8dZQwMQfYJwqUk?=
 =?us-ascii?Q?QC7vURgIJmH17MzAc1sFjTQD/Q960S8j+LtvSDAAngmNmo+31hqcaVhL1xLo?=
 =?us-ascii?Q?AMKwupD+tXC7FfWrdeZ0+Awom7FIm7A2rEX+pAS7V5cjdnqwIzB9lVQORsMN?=
 =?us-ascii?Q?LjiGPuXXcGUNUXzz166T2MRxv/uqst5F1Lsu9HkrhmrVRH4XZVeVSVu3bn+C?=
 =?us-ascii?Q?mmMFc4Xu1CxrULEXFVoMEN7CZM7djQRSctCXhpWT1Mu9pdSPQcaAYk6gCFGH?=
 =?us-ascii?Q?50qK3Bj/FW3TiUdZ4/Z/7ueUuaEiLRb9PvZ/i7/Ux3xTktjDIOxLnFAbThbV?=
 =?us-ascii?Q?ts1F6NOFZelsBkzhciNyICYplSZLUbE5Z9vCKkRE3Qi3Zbl8YlaiZmtSnCRX?=
 =?us-ascii?Q?G1R83sWdI1tRQPZ+e46fJhq4GNwDTc8Lj9Sn5W2VK5vWcLR8Ouzako71vJGp?=
 =?us-ascii?Q?KDuE5hXp0F9BqJ12Uj+Lrx9PVEBjw2/zLzgQERum+n2VBd4LVG/U0Ndn2EvN?=
 =?us-ascii?Q?CwhTwtk5XpMDMij/gnjZFuSFsO239lftp+875buUX1dk51bvqFjjwRH9d54g?=
 =?us-ascii?Q?irw//1Uaf8Cu4BG7M3fi5H4TLQD+osG9yZcvzN9un+GuqpnFfD5Nq77TzvNX?=
 =?us-ascii?Q?SuV2EwbQKD8s77VAZ0U7j+GAGThM6anXhK3hd2ld6WMfNaunIcNR8xJCQ=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR12MB3511D54842276E8B699CA0A1C2650@BYAPR12MB3511.namprd12.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(346002)(376002)(199004)(189003)(9686003)(6636002)(14454004)(6116002)(3846002)(6436002)(55016002)(2906002)(71190400001)(256004)(71200400001)(25786009)(53936002)(8936002)(6246003)(7736002)(81156014)(478600001)(81166006)(8676002)(97736004)(4326008)(86362001)(2501003)(229853002)(110136005)(54906003)(316002)(74316002)(486006)(11346002)(446003)(68736007)(305945005)(26005)(7696005)(99286004)(33656002)(186003)(102836004)(6506007)(105586002)(76176011)(106356001)(4744005)(66066001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3511;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: td1K/oSxbVNRNxN77xTILTSebfO0h4ZscLS13IK0lMihAsvgZG4Z3+owlQCBxvYVL7kVg7K6oOrmWsdLhOy3GeqPL7YSE9QNXqG/4dAE8uysG11uHVDdZwdI15qivuoYHm7Bfy+YiMiqN+YO0rR6aTDPoeh1vaFmb/PK6XdJPlsU1s/NfvnP4JA4z3+SqscrDRfJYNdmV4WAIzPEgFctzF+g1Whegw0Re/+rD3mlO8jtn45tXj+k0JhBQ8mJ1E6EGeDyJQNIwz7Mok63AJPUEws3X/5BijN6nRtEiF9EnWHMMNeLpAfvirNV0DOTo4fwUeHP4K6x3wZ0Y0AwzX9QZNL3gK95DuhdorSGaINgFYVWKTrhiOdL8cKZmeWQp8JtmxXhnnD+2kC9U3jKsStmx5vg+tL6fj8G7yyxbynCw/c=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a8acf8-4179-4f9a-7e29-08d691187797
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 18:32:38.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549996327; bh=fyxpmgHRH2KPRXhyDH8YT56bRPHLJY3+ejau0jFNyEk=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-exchange-diagnostics:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=KoCxArB45gkz0a1iJZlahYG3oKXjUZR3r8PivCuFniR1ynVF5sBA8NDUUaiQWtTgW
         EDisqlr+UTO1wAG65PS07Kq7oGEPvXrxxqzuru3IbA7m7IsRQmJaaDg4k0PPMo16re
         2qvRdz+Hm3cgE7YUqdUnXencCX2z/D3w4ubEqmgl7Ybg0h1+QbBEzX1zgHX87QBR8t
         wO+WFKcEksuhaANovhcLomIQhFGIbFr98RJxVQxheFp1u4+GwkWUKVKfrwMU+S/U6y
         KRMPVPGGSTZHizICFo1wvoqC9pz7LvINwwCY+lpBnB0YK/lQPhhmrkUwt/2aJHNFgs
         b3DOy9sdZwcDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore all Patch V19 series. Will resend.

Dmitry/Thierry
I am using below stable tags in commit message based on V18 feedback to get=
 patch applied to old kernels
Git send email considers whole text after Cc as email address and reports b=
adly formatted address.

Is there any format that I should follow to specify kernel versions along w=
ith stable tag?

Cc: stable@vger.kernel.org # 4.4+
Cc: stable@vger.kernel.org # 4.20+

Thanks
Sowjanya
