Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeBZSVf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:21:35 -0500
Received: from mail-by2nam03on0055.outbound.protection.outlook.com ([104.47.42.55]:6821
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751061AbeBZSVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:21:33 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
Thread-Topic: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
Thread-Index: AQHTrwQnyzTAP60IHUq+h1EagnZ9EKO2/qiAgAAAiwA=
Date: Mon, 26 Feb 2018 18:21:30 +0000
Message-ID: <87859168-A64E-4FF6-9F7E-174A903704D0@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
 <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
In-Reply-To: <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3556;7:ZXVVGjzg9/HdgIL4+OlwghmN581XtLPmKtEEHgVftptTHBC7NfYZ/zE9WzVkQ67gpGX2yr+1yyUaT5YU6XO/A0uWDoMFLZ3EWy5Vxm8Qe7GItXAHVMeu2HwcWhL/4QOuMvco7fjYFb+FqdQpQ7OVvWIL+OGQLBywoNReINUfJdNT6dz+xoLddPQPMvbfgjdJQbYwPDvyuURkXpEqSI/TxtSrtubpNZGZJ7TKSYC7mnu6XPVS5Mk96sVTpUwf5l48
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 089c0dfe-6fdd-4a0c-38de-08d57d45c252
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3556;
x-ms-traffictypediagnostic: BN6PR06MB3556:
x-microsoft-antispam-prvs: <BN6PR06MB3556C40F2C3C8B107A5FDFBABAC10@BN6PR06MB3556.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR06MB3556;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3556;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39830400003)(39380400002)(346002)(376002)(189003)(199004)(68736007)(97736004)(6512007)(6486002)(6116002)(102836004)(316002)(229853002)(25786009)(53936002)(6246003)(4326008)(105586002)(54906003)(82746002)(36756003)(66066001)(5660300001)(6916009)(305945005)(6436002)(2950100002)(2900100001)(99936001)(2906002)(76176011)(8936002)(14454004)(99286004)(7736002)(186003)(86362001)(26005)(3660700001)(53546011)(478600001)(3846002)(81166006)(3280700002)(106356001)(81156014)(33656002)(8676002)(83716003)(77096007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3556;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: yoZ+N8d/SKj337NXiV7qKZAgvEAKtWSMOk+l6KgIK3ivcB0PvAf5vQKPgc0ylGNzkQsEoP75tf3x5Q4RaRUzY/YxmqZnKUbCOU2xIgdfa3d+cjsbMNzQpjqPhLD4+4ibmye/50zD0nc7ongxfremBWh+6soi3CJxWVg18Qels+M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089c0dfe-6fdd-4a0c-38de-08d57d45c252
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 18:21:30.7614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3556
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Feb 2018, at 19.19, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/26/2018 02:16 PM, Javier Gonz=C3=A1lez wrote:
>> # Changes since V2:
>> Apply Matias' feedback:
>>  - Remove generic nvm_id identify structure.
>>  - Do not remap capabilities (cap) to media and controlled =
capabilities
>>    (mccap). Instead, add a comment to prevent confusion when
>>    crosschecking with 2.0 spec.
>>  - Change maxoc and maxocpu defaults from 1 block to the max number =
of
>>    blocks.
>>  - Re-implement the generic geometry to use nvm_geo on both device =
and
>>    targets. Maintain nvm_common_geo to make it easier to copy the =
common
>>    part of the geometry (without having to overwrite target-specific
>>    fields, which is ugly and error prone). Matias, if you still want =
to
>>    get rid of this, we can do it.
>=20
> I do, the variables should go directly in nvm_geo. Thanks.

Ok. Is the rest ok with you?

Javier

--Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUUCgACgkQIX4xUKFR
nnQkRRAAuLSn0BX0JlOuYOwal+a6Yjd5abQx/xU8J/U+Eo0noEMWfuJbFjX/JE7u
qFMklCX4fbmCc5hHWEfN/oUysebOLEEetVJnErfuWgrcumbYC7SvhYKIsjk+4Cwr
c9j7dpeY4HM8rQGHO3K9gMtUBzA3ocjIuQ0j5LNTlGVLpz3sjCdf4ZBrcIxjVCQT
HtUQiCcXsbQshTSMd5TlblP4M8Cu1bHhstYn36QaNCNFokUjUsvL8ioFxyVq5E8u
ncmL2fHJqQVM2VjDWSYsbLjtHjc6TVVlt2n9u/uTxdAnKburxOu+SlKXiCx1bbqc
8HiqPBO+TFMeM0OKNNYIRXyyPmwJzu6j4ol7Rf2tYrAlcHEGm2zFnQJJKge9Gz2+
Yn5sT7a7Mq3MAgXUjGJ1FzkKK3Cxwxj5KNXt9ro5XbuCDi0VMpz4HxQJ8OvXC9hi
nR7sAhwe+bdAqeGXyi3AdnwWIuxmHj9QCpQdDklz4mhOWnAF3vIrAu70+N7jMyUG
sqWIgIX8yd+BWWHHZ12EA90JqMCjGmioFj4jT4awE6Cs829U/4uU/C4PL/Py+ykG
4hBy6jxC0CZoO0Jess67nGkTCa8lwQ1DbpwScs4QkKSj/XAH2X05Zewi3l1PqsLV
93hWskR619u3YMh27tUavh0FM4BkF5yPz05DmMYYpbXcGZuxpuc=
=Nsjq
-----END PGP SIGNATURE-----

--Apple-Mail=_18179592-2D2E-4B0F-9049-D187C12F9DBB--
