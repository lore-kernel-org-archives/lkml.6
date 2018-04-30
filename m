Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753910AbeD3JLk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:11:40 -0400
Received: from mail-by2nam01on0067.outbound.protection.outlook.com ([104.47.34.67]:6807
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752701AbeD3JLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:11:37 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 0/3] Rework write error handling in pblk
Thread-Topic: [PATCH v2 0/3] Rework write error handling in pblk
Thread-Index: AQHT24+D7OA+myXAk0GlTzhYHhGU0KQWl8oAgAJ3iAA=
Date: Mon, 30 Apr 2018 09:11:30 +0000
Message-ID: <33E16356-2CFE-43D2-9298-98CF9D598A51@cnexlabs.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <7536f5dc-bc11-ae4b-b11e-9c3995142cd0@lightnvm.io>
In-Reply-To: <7536f5dc-bc11-ae4b-b11e-9c3995142cd0@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB522;7:YlExk6voKA8ELiyNP2PXDyQhXXr1RcEjzSnK0Yhc6za9+Lt1fmwUx9Y7/ywtJjPVjbtA930Yy1MPM9Yk8eJL87ksJXQ3sAl5ZNebhy7nl4mqwmFqAh7VEYowIH4FEPP4PAg08Y94uGcHCPc1Ea6lHFTKfYqyrm9MtZ52Xqw4fHPH2oJKTgbTvSm6ObhjDvQtHNKOYBCUdWHihlDfx69bUlOI20jqtMcWQLNjwAdSE0MU8yM6vNE+YTLy4jdeXFtc
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(39830400003)(39380400002)(366004)(376002)(189003)(199004)(2906002)(3280700002)(6436002)(68736007)(76176011)(83716003)(99286004)(476003)(2616005)(102836004)(8936002)(53546011)(11346002)(446003)(486006)(4326008)(81156014)(8676002)(14454004)(5250100002)(6486002)(81166006)(106356001)(6506007)(3660700001)(186003)(5660300001)(478600001)(86362001)(229853002)(82746002)(305945005)(966005)(36756003)(2900100001)(3846002)(6116002)(66066001)(26005)(99936001)(6916009)(97736004)(25786009)(54906003)(6306002)(316002)(33656002)(6512007)(6246003)(107886003)(53936002)(105586002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB522;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB522;
x-ms-traffictypediagnostic: CO2PR06MB522:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-microsoft-antispam-prvs: <CO2PR06MB52235CE17758A963A6D8E56BA820@CO2PR06MB522.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR06MB522;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB522;
x-forefront-prvs: 0658BAF71F
x-microsoft-antispam-message-info: dUh5hhfKEC/SiJ0BdivqOpFrMeL0juX5hOL6rEpVSSYyVRnyHF07KUiJzjtRW6xUm7JdAtCKsFCh+Tur55GTufqj5h8UHHw9KZ6xlIe8GNJwvZzIKDpqdO3oHOKqH3PrHn/hf+eNdPK3LB/5BTcctpJCyZIRHd9sBhTdRG7kt0DjuVQKAPoV/be6hCAjUJgw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fd8b929a-6431-4223-996a-08d5ae7a5ceb
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8b929a-6431-4223-996a-08d5ae7a5ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 09:11:30.9105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB522
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 Apr 2018, at 21.31, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 4/23/18 10:45 PM, Hans Holmberg wrote:
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> This patch series fixes the(currently incomplete) write error =
handling
>> in pblk by:
>>  * queuing and re-submitting failed writes in the write buffer
>>  * evacuating valid data data in lines with write failures, so the
>>    chunk(s) with write failures can be reset to a known state by the =
fw
>> Lines with failures in smeta are put back on the free list.
>> Failed chunks will be reset on the next use.
>> If a write failes in emeta, the lba list is cached so the line can be
>> garbage collected without scanning the out-of-band area.
>> Changes in V2:
>> - Added the recov_writes counter increase to the new path
>> - Moved lba list emeta reading during gc to a separate function
>> - Allocating the saved lba list with pblk_malloc instead of kmalloc
>> - Fixed formatting issues
>> - Removed dead code
>> Hans Holmberg (3):
>>   lightnvm: pblk: rework write error recovery path
>>   lightnvm: pblk: garbage collect lines with failed writes
>>   lightnvm: pblk: fix smeta write error path
>>  drivers/lightnvm/pblk-core.c     |  52 +++++++-
>>  drivers/lightnvm/pblk-gc.c       | 102 +++++++++------
>>  drivers/lightnvm/pblk-init.c     |  47 ++++---
>>  drivers/lightnvm/pblk-rb.c       |  39 ------
>>  drivers/lightnvm/pblk-recovery.c |  91 -------------
>>  drivers/lightnvm/pblk-rl.c       |  29 ++++-
>>  drivers/lightnvm/pblk-sysfs.c    |  15 ++-
>>  drivers/lightnvm/pblk-write.c    | 269 =
++++++++++++++++++++++++++-------------
>>  drivers/lightnvm/pblk.h          |  36 ++++--
>>  9 files changed, 384 insertions(+), 296 deletions(-)
>=20
> Thanks Hans. I've applied 1 & 3. The second did not apply cleanly to =
for-4.18/core. Could you please resend a rebased version?

Hans' patches apply on top of the fixes I sent this week. I have just
sent the V2 and the patches still apply. You can find them at:
  https://github.com/OpenChannelSSD/linux/tree/for-4.18/pblk

Javier

--Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrm3cAACgkQIX4xUKFR
nnQ2FA/9E9J9apS2axTcK9V8tnhqPoUUlEnXrRoBjZaI4W7DTev0zTr03x0Eu6Sr
XM4XEo1VnqQsR6FFb5EFZuXA0UPHMUXJjS9rfn2OzULVuv6lz6Ckb35NnpgUKX+M
Jegmybh/bEaU32d2iUMDZgVnatH208WDVH0KxBPoILYn+WziBj+SANaeEtb9qxXW
5bRtBkLgzUcwn33IS0uFiYboV0pvzmCAW3LO36cFfEOeAHrMqH8Zc1twym7ckSDv
jwJ1yNef9168reLPRY5tAakZ64EhgXeLSDkF3OF7vZNqFWH2ZYsocgLyfMXCvPRu
Tdo08FGesc8ruyGn0+6YAQnU23rNTGmYoQWSMAMTf6hjPjIGiL94exSs8KMcU56S
6dXNSuNspXcKwmC6ruOugKHepNE8Uz8dTuBiV8m+OI7rW5JbcHVoy9lWG++rDgNp
b9mX8bEdiyiEvj/XnAQi9p7URNCmqZwjJ/Tur+HxGrfVQVargNQ6g+iUcl6dEc/l
u891tUIp9aJcoWrjTaAB5F1qEkXIhPrCcIrvXFwcKrDHnTsUIEiDiLDZvjDaISe+
bUt3fzsxBPQz3S3Y43pAP3cD0Jw8b74jvDvAtd69Mll5dmIBbTd8pgrjrhaPcW79
vZmgphbxdUkCunGwqrWVmHNtkHSrPnGfjCFcO1N7bp5jJO6Zm+w=
=6bPW
-----END PGP SIGNATURE-----

--Apple-Mail=_E13FE755-3BFF-4A76-9927-26DB353A0D87--
