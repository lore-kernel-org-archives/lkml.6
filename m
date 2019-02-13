Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3106C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827992229F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CJ+iThoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393444AbfBMXqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:46:07 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:3668 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbfBMXqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:46:05 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c64ac3c0000>; Thu, 14 Feb 2019 07:46:04 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Feb 2019 15:46:02 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 13 Feb 2019 15:46:02 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Feb
 2019 23:46:01 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 13 Feb 2019 23:46:01 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3448.namprd12.prod.outlook.com (20.178.196.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 23:45:43 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 23:45:43 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     Peter Rosin <peda@axentia.se>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Topic: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Index: AQHUwwYoBZ5O9YX6BkG2oYjTgne2HaXcpgWAgAAEBICAAL4GAIAATboAgAAcnoCAAJL3EA==
Date:   Wed, 13 Feb 2019 23:45:43 +0000
Message-ID: <BYAPR12MB3398B0893B586A587CBB3F1CC2660@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549998408-9137-1-git-send-email-skomatineni@nvidia.com>
 <de27b8f8-ba8e-fca7-6bdc-cdd580d959e6@axentia.se>
 <cdb66da2-4886-e3ba-e78e-264bd4b5b73c@gmail.com>
 <20190213083519.tynjs3ef6tnvvsms@ninjato>
 <b299217a-454d-6d3a-9c48-3500a95040a7@gmail.com>
 <20190213145557.vdxahpsacgy4oznl@katana>
In-Reply-To: <20190213145557.vdxahpsacgy4oznl@katana>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22755590-6e51-4a49-4562-08d6920d5e62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3448;
x-ms-traffictypediagnostic: BYAPR12MB3448:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;BYAPR12MB3448;23:JpcDZPmfywhbgFhpW5L3xLaO21HsyEu24ix0yaWyM?=
 =?us-ascii?Q?bNpOPYBevgoZsnIjIZD9DW4+SfLY5Al1twT7XH249Y+fuSr8I13eySPpFCNp?=
 =?us-ascii?Q?Nl/AjJzNE7m10P7P07SFqh3ALjwNu+G4uYiIV/OlQc+tiAvDzB380xDz+qEu?=
 =?us-ascii?Q?VK2gTKZ1mT1IuFjRI78Z1SBPtWC/G3xBxQwoYFfn1vmaVsbFjA9t5utIUdki?=
 =?us-ascii?Q?+iupOq/sdYkdErQKLdePgmfyuCNUVM1jzdccibQO7cxSpa5McEfl1IrBprMe?=
 =?us-ascii?Q?1v+VXp2E6P5Q0Aq4D8R8j6ApoFgkDkIk+FlS6JhpvCluAauqKE0mEqB6oFqo?=
 =?us-ascii?Q?eq/TnomthMsuA+dbZSc3ve+3ntvOQkgGKfbSfhpjHfdBbCTDzzMIKEfXHYQF?=
 =?us-ascii?Q?vm06FMTZqfhsqIN8Cqa4DYVa2uxVOzLsKZPuLHwIMTvMqx7R0Fhe+kdtWSAn?=
 =?us-ascii?Q?VugAu3+nWufExH8dolKdKMAtWxuXksiUhOUOuYlqlGMggFgWOdq6N2jKITbV?=
 =?us-ascii?Q?StS4mWgBZAtNe6QM7u9D79NBf3dgO7MkZrXR3ODKU400TajwOg1i/ejMPl1Q?=
 =?us-ascii?Q?lWgZoCGyUAQJiqC3HxDU/mY52in1rztkU3HFMwE9ClTZTJWW76MUz19tqjo4?=
 =?us-ascii?Q?LVMK6RqDhBEemHQa89J15aGZtljia+zCE2CtHJiCpu8ZyZAR/FmkajzCn55K?=
 =?us-ascii?Q?tEnez9tx/b3jaoCKgx8A98er+INftE+wue3JsHWGBTM1nm2wrzu3YD1GUzgx?=
 =?us-ascii?Q?t2BOw4H2NBiyK7wIUuXBXdUMo16Ylq9k4+xMLCmqoCt7EMH5KvzUpHS4ntQV?=
 =?us-ascii?Q?gCdAGiG9RqnJou/VKn3RZVj2I3m8XgLjI5b2OWDg5Wq8nK0bvlVN9lbcBzSM?=
 =?us-ascii?Q?yhCDeSJtLDQpW6rTb6jzKSY8uy1agm5PJuYnIv6Wif4C4LFFPNHJ4JjM8v0Y?=
 =?us-ascii?Q?BVx3CCGJH2tneL+1yvpuV+g4/BFNtJW6HxR0QrPVMhQCNHNmqhrhvraJjcrU?=
 =?us-ascii?Q?CgWkb87pNaXSCRVNkohFq7lmxLamP1XyDjxJMT9V49FJtkw/KkEh8SudN+BR?=
 =?us-ascii?Q?attSHa8JbegoDiWef6mMIRD0d/k2d2UOF8Rgi/rdz5XH72xx4wXNtdetdrhe?=
 =?us-ascii?Q?SvYVoDT31fUNhCwY/5Oh3ONF2f1QgIQClvQ7f3OvXmFV7j81Nj9K1J1Eqoy6?=
 =?us-ascii?Q?XoEo/UdLLV+nSB1EfVpswX249h/JnVSY675+u+O6pMZccLzDJBWMZOW6g=3D?=
 =?us-ascii?Q?=3D?=
x-microsoft-antispam-prvs: <BYAPR12MB344812C29C5E2DCE0AEA55BEC2660@BYAPR12MB3448.namprd12.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(376002)(346002)(43544003)(189003)(199004)(105586002)(106356001)(99286004)(7696005)(68736007)(74316002)(33656002)(7736002)(305945005)(478600001)(71190400001)(71200400001)(76176011)(316002)(8936002)(81166006)(110136005)(8676002)(54906003)(4744005)(86362001)(81156014)(229853002)(9686003)(6436002)(55016002)(14454004)(4326008)(6116002)(2906002)(66066001)(6246003)(476003)(25786009)(6506007)(11346002)(446003)(3846002)(102836004)(486006)(26005)(256004)(97736004)(53936002)(186003)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3448;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /ZyStdUHHU35tR9XpnkIdjRujhGrGLh3qMDonPPKjLI73MmoZLibYkWMB3bpqln/9t4GKA+mUzbCLuCWYue2ysRaDVxNYf+rf3HCanVv0jJ3kAQDbOBZd2iuU8HVMom5DZgBo9b8dkM0BGxBrbGuLkjeCDvCf4+LuslVki1XHpos/+CklfeusB4z1j9AqRkjjzFDQI+285L8fVwnOuCkOb8TiZkUFBQ5d2fP/fTm8DMU9kLpPQCX5mc7lNqgg57u9jLxa9rKj5JhBPNF/IkuKUsZbbb5dc1UB/PqS4YLC8Y7AICGKSqeEmPBmVmueVO8sBZjvx0DTqf5xn1/sLvy5g2sFYB/O6JIsF9LzYn8sOZgdTzfYV9XEVUrl483SHIL0pk2BosKesKrB0atkqcePSrMA07kwGWEKcqqMH0WGYg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22755590-6e51-4a49-4562-08d6920d5e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 23:45:43.3761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3448
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550101564; bh=jHSZCNr6Fhm0wuDJSLO6Nk1ZLCQ7QL+qcD+0d8Kl2VU=;
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
        b=CJ+iThoDoWd6FKFGvFlYTpVwWzHWTMJUekTFSkIfG1hJ/JT83EmkzpClN7ic1asQw
         YaaLF3keSQkfGiGE4J+KNUlj8H8AQapkvKlEBXn+1gTESTzVAm5jRkO6iMQNfyxf+I
         QiWbZ1yLrkb2ZR10Wqi+AUAEoNY7dM43vHrwawVnCm3PJoaXLJFGlUgc3vBJZKaS/f
         wMoqLSsJgxk58Rax70p1emuMw1AcOS1Qo/UWazydg6akDiMsipYyjkaU52Sbm5E8IN
         8OROMSpil8jEL3L/Ifg2EWOvdHxOARlcjokf1D6RhzCOzNC+E5mmEV59zJXsNMePde
         xYeq28pCkP/MA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Fixing up minor itches while applying patches is the right approach,=20
> > thank you!
>
> It often is. But making a dogma out of it goes nowhere for me.

Sorry, somehow I looked at your 2nd reply for this patch-1 of V19 about hav=
ing few comments to take care in this series but missed to view your 1st re=
ply to same patch-1 of V19.
Fixed my mail view so will not miss next time.

Appreciate if you can help fix the comment while applying patches.

Thanks a lot
Sowjanya

