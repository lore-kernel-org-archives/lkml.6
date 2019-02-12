Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F392C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042292190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OEI3qvs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfBLSpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:45:30 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:30468 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfBLSpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:45:30 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6314450001>; Wed, 13 Feb 2019 02:45:25 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Feb 2019 10:45:25 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 12 Feb 2019 10:45:25 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 18:45:23 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.58) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 12 Feb 2019 18:45:23 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3528.namprd12.prod.outlook.com (20.179.94.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Tue, 12 Feb 2019 18:45:20 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1622.016; Tue, 12 Feb 2019
 18:45:20 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "peda@axentia.se" <peda@axentia.se>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Topic: [PATCH V19 1/7] i2c: tegra: sort all the include headers
 alphabetically
Thread-Index: AQHUwwC2JXxCj8zR6065fKM7Y4JWNKXce7pggAADooCAAACe8A==
Date:   Tue, 12 Feb 2019 18:45:19 +0000
Message-ID: <BYAPR12MB339831225CE6B8196B5F4B52C2650@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549996081-6858-1-git-send-email-skomatineni@nvidia.com>
 <BYAPR12MB3398679040C6ED2E129CEBFBC2650@BYAPR12MB3398.namprd12.prod.outlook.com>
 <7143cefd-8c8f-e010-90db-5ac46aa96105@gmail.com>
In-Reply-To: <7143cefd-8c8f-e010-90db-5ac46aa96105@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 302c0615-fe4e-42d4-ca99-08d6911a3d29
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3528;
x-ms-traffictypediagnostic: BYAPR12MB3528:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIzNTI4OzIzOll0dGQrcGJoaU42MjBLakhLVXJDbDV6VTBz?=
 =?utf-8?B?cFRDaVZYNFVpWGxzVFovVkF3UzlqNE01eTA5eFBkbW5RdEpzT1NCWmJqQ1F1?=
 =?utf-8?B?WTBMOE5SSFlXektGdzVqeG1JSXJ2VXlsNy9OUk5BZFlreHRZejY5Qk44T043?=
 =?utf-8?B?WVhwcVpZTlN6TlBZVmlPQ1VtbmhuWUtvN0VoMzR3NVFFMFNhYVZxQU82bnBZ?=
 =?utf-8?B?RTRrSkVPZXBpUVBsUk5FejdGeVhrZWJ3S09GL0h2c3c3c21MbWFldEdJdkFQ?=
 =?utf-8?B?ZzlvWTlMeFRSUGQzWEpuNnRVR1dCL0pSbWU2RjEra1dSOXZ2M0tYZzREaFdv?=
 =?utf-8?B?UEsxSjFXUTlwZHBKR0JUUzZ2NXlXRDFWQXNZRWlGaFRuV1JhNU1PMFZBdkhv?=
 =?utf-8?B?MU1Memd2WFgvUk9nc29MUnJ5Ym90MFYvZ2NHTzR6OVBhNHFMMWplSjA1UUJG?=
 =?utf-8?B?VkFBL0VKSTY1QnFWV0dWZXVwMkJlTmdKcGltMmlKUEFNazU1QjB4TjlYYXRL?=
 =?utf-8?B?SU5MVHZpT25ETGt5SHlUUHdiTWdaOVh0eGptMzZXSkVEeHViOGtkRjlBc2VM?=
 =?utf-8?B?a3lXeGlrRVNqQjZiaFpLYWpRL2d4Q3k5WVBjcmp1eklQSlBqY3NidW05OTVr?=
 =?utf-8?B?Z29oa0N1emFhV0xnanl5aUUwZnhCSm9IQlhiUDR1bGQyTVNxSDVETjdDQytN?=
 =?utf-8?B?bFl4WEpyMXpqQ3VFQWNNdmMyYXE0a3BFNXVLWlV6UmJRNi9WcUpqVUpxaXdk?=
 =?utf-8?B?dGZxcmtFbkxpZFFUYUowbjJNN3UwRkZtY2JhZU5wZkhJbmtkUnJkRjMwL0Jv?=
 =?utf-8?B?bys5SlNkU3hTOThMWEFkMVQ2MWhWRzg0UWRaaU9kejJtVFdGZ3NYdnRZWEhi?=
 =?utf-8?B?akhybXpMelpXV3B3anJ1WjdDTEhIazhyK29Xd1FNVklrM05Sd3kva1lHVjY5?=
 =?utf-8?B?NDhJbnZhSHk3ZkJmVlp4TTFPenZtYzk0NFFRbXlSUUtEbWNkVFhFQ09ybTFM?=
 =?utf-8?B?WS9NdXZCVnA5WmlodnhlU2w5ZXVZR1NYMlZESU8zMHNOQThBL2NyZ29UeGpn?=
 =?utf-8?B?RjVocE94S0RITVpmd3FZYnVzNWYvWG4xUWxieEFMZHhNK0lnekVJbEpoMGRl?=
 =?utf-8?B?ZWRkcHhyOFFhZzhRODJodVV6TmZSU0hDY0Z1ZVIzemJEaEJBcDdVeGJsSHdj?=
 =?utf-8?B?Mm8zQ2d0MHo2TmZEQlVoenJIeWh2SUhtbzZDRWx3bW4wbjNmeU5CTUNBY0lZ?=
 =?utf-8?B?TXpIb3gxcWRQTEQveWZJa00xSVNhZVZ3ZkF6UUo3UGp1Qk5wSGdWeXpsTDl2?=
 =?utf-8?B?bHJ4WXVoanA0YjhoaENmbmdoUnNaS0NsOEFFVkNSaVliaWJ0Tm8rQmo4d3k0?=
 =?utf-8?B?SndNVTNIK1ppT3o1VnRTdml2RGVOVjd0M3A1WVFpQ0MvKzR1djZ0WTZPNnJy?=
 =?utf-8?B?MWhvcm8vUVlheWcrRGlhKzBaQjNFU2xWZU1lb3BNQ2VJb2pMQVVHRDkrb3Ay?=
 =?utf-8?B?QWNkNU1CUVZnVHRoSGxQYVJNR3I5UlgxdTNYVG9VMDRhWkxYVkFuRXBMN3Za?=
 =?utf-8?B?ZG5LMnZZdXV6aW5sYytJZzdWb1JFQ0t4N25rSFp4OTF6aG0rWDJCTDVIeTRk?=
 =?utf-8?B?MFBzUXpLMXJraElBU204UWI4S2M4RHJRVG1udWJCamdxbk5DZm0wMm5tN0VF?=
 =?utf-8?Q?lgEl5lbmGpm+s88YrAwHEmqpDZqOpf+IUK76GT0?=
x-microsoft-antispam-prvs: <BYAPR12MB3528F0FF06B8C8C454F380E4C2650@BYAPR12MB3528.namprd12.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(14454004)(478600001)(86362001)(256004)(11346002)(55016002)(6306002)(6116002)(966005)(8936002)(3846002)(68736007)(2501003)(446003)(316002)(6636002)(305945005)(71190400001)(7736002)(71200400001)(110136005)(26005)(25786009)(66066001)(6436002)(54906003)(476003)(9686003)(99286004)(4326008)(6246003)(4744005)(53936002)(186003)(33656002)(105586002)(229853002)(6346003)(2906002)(6506007)(486006)(7696005)(8676002)(81156014)(81166006)(74316002)(106356001)(76176011)(97736004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3528;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: toe8IpkYhGaAGfWdKFOLnd6OAbdl40I5Z9w8Rg5Vv7U9AaoXzxF78fiOMngUWo1IbIA1YSuajSldswo4/nWMHX0TILCelXDv344S2HF9gD1m7rARuJQ2Q1h66pa5Y40u/b1wDdXJ+ccp7yMW4jXmf/IYyL8NcUf3zH5IraunYeTSMg37RKkoVIoEEi4BqdwOtArXEvkEJnCmPsacQyEfewvzOuR2Ik/IJELMTfBXP/uoKOUxgIx4u5+g3BYM3rokjcB9r+eYsFaHGEB29KscA+GGfGahF471ve1LZg2As1Hke+eT1Ca/fOESZXZtuOu1DbEiVdTnnkQ9gTZRKK2IYVSFv/GLsWjWMyaxXlhv8mIzHW0XC/uJSC6PEAegaB3miuEO6KzAIlDHlSpJNAxWhwpey9x3/hx6WPeSJMh7llg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 302c0615-fe4e-42d4-ca99-08d6911a3d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 18:45:19.8788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3528
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549997125; bh=NoI1FVo1cjnDCsyUKLnIl+hBZqYy9OqV7s6ymoakN0E=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-purlcount:
         x-microsoft-exchange-diagnostics:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         authentication-results:x-ms-exchange-senderadcheck:
         x-microsoft-antispam-message-info:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=OEI3qvs9S1z66ZSL8RYc12z+V0NZtEPepYUay08Z/G0e79oIhXwhIel19aBl5klr2
         Dxye8UC2Fdn5u9knWZsIAQ8+2sYGDYfJHBI8O+AZqJQqrSw+4vrCoddEho4Q3Ovj8a
         msGP2sBS3scB98dSNDZrKYTv8SwcfM7kjYrUuO7CMPf5TJYh9PHsPYWb7w68u0MG1M
         nAUQsB2Ezwzfnnwy+KFvs4Px4qZwZgQXXcwkUqNEZdXnghRGvDzhJ9++4up6v8oogk
         mPXyH7luMlZMCCC2d2r2/PbbcpZ2pFfhJ6AIrpDSDO8bLwmROs1FrmVzQ2CyvbK/Tj
         QzZEac1c7OSWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAxMi4wMi4yMDE5IDIxOjMyLCBTb3dqYW55YSBLb21hdGluZW5pINC/0LjRiNC10YI6DQo+ID4g
UGxlYXNlIGlnbm9yZSBhbGwgUGF0Y2ggVjE5IHNlcmllcy4gV2lsbCByZXNlbmQuDQo+ID4gDQo+
ID4gRG1pdHJ5L1RoaWVycnkNCj4gPiBJIGFtIHVzaW5nIGJlbG93IHN0YWJsZSB0YWdzIGluIGNv
bW1pdCBtZXNzYWdlIGJhc2VkIG9uIFYxOCBmZWVkYmFjayANCj4gPiB0byBnZXQgcGF0Y2ggYXBw
bGllZCB0byBvbGQga2VybmVscyBHaXQgc2VuZCBlbWFpbCBjb25zaWRlcnMgd2hvbGUgdGV4dCBh
ZnRlciBDYyBhcyBlbWFpbCBhZGRyZXNzIGFuZCByZXBvcnRzIGJhZGx5IGZvcm1hdHRlZCBhZGRy
ZXNzLg0KPiA+IA0KPiA+IElzIHRoZXJlIGFueSBmb3JtYXQgdGhhdCBJIHNob3VsZCBmb2xsb3cg
dG8gc3BlY2lmeSBrZXJuZWwgdmVyc2lvbnMgYWxvbmcgd2l0aCBzdGFibGUgdGFnPw0KPiA+IA0K
PiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNC40Kw0KPiA+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnICMgNC4yMCsNCj4NCj4gWW91IGNvdWxkIGFzayBzZW5kLWVtYWlsIHRvIG5v
dCBhdXRvLWluY2x1ZGUgQ0MncyBmcm9tIHRoZSBjb21taXQgbWVzc2FnZTogDQo+DQo+IGdpdCBz
ZW5kLWVtYWlsIC0tc3VwcHJlc3MtY2M9YWxsDQo+DQo+IEFsc28gc2VlIGh0dHBzOi8vZ2l0LXNj
bS5jb20vZG9jcy9naXQtc2VuZC1lbWFpbCNnaXQtc2VuZC1lbWFpbC0tLXN1cHByZXNzLWNjbHRj
YXRlZ29yeWd0IGZvciBtb3JlIG9wdGlvbnMuDQoNClRoYW5rcyBEbWl0cnkuIFdpbGwgZ28gdGhy
dS4uLg0K
