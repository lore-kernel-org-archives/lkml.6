Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeBZSVT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:21:19 -0500
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com ([104.47.32.50]:63840
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752081AbeBZSVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:21:16 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] lightnvm: pblk: remove unused variable
Thread-Topic: [PATCH] lightnvm: pblk: remove unused variable
Thread-Index: AQHTrwRpB3DuigwQ0UuGHesUIgUyzaO2/t6AgAAAPoA=
Date: Mon, 26 Feb 2018 18:21:13 +0000
Message-ID: <829B1AB7-A09B-4CA8-BA71-70B354E5E612@cnexlabs.com>
References: <1519651129-17897-1-git-send-email-javier@cnexlabs.com>
 <423c58a6-afde-5ebe-6199-78ff2661d8ac@lightnvm.io>
In-Reply-To: <423c58a6-afde-5ebe-6199-78ff2661d8ac@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3556;7:f89y5xiwPuup+KBUu/tSPGT5cEDepiV5WzKNSvJzINTUPaziJu7+2B0pGj7YfhG+lGiUR/vMAjNNRqrDtIOjtsQ9JAqaNDb26ckveyrIQtnqI7B83pR9FYgD3IURpXPybk0XQM0MVCrfew+CyPemLCPI1fVvSJxGiEMYHSsln6u95WH4A0dIVUOfQuIFAAB4/pWN1Il/Qu1xO5Ao7GOLMAi68fj3R7JlxbR271Z7XurRJzJdk3j2gLuqEJgT6nT+
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: f4a74a33-9ea9-4fd3-0d6b-08d57d45b7eb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3556;
x-ms-traffictypediagnostic: BN6PR06MB3556:
x-microsoft-antispam-prvs: <BN6PR06MB3556CFD26D3C2555C43AB4BFBAC10@BN6PR06MB3556.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR06MB3556;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3556;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39830400003)(39380400002)(346002)(376002)(189003)(199004)(68736007)(97736004)(6512007)(6486002)(6116002)(102836004)(316002)(229853002)(25786009)(53936002)(6246003)(4326008)(105586002)(54906003)(82746002)(36756003)(66066001)(5660300001)(6916009)(305945005)(6436002)(2950100002)(2900100001)(99936001)(2906002)(76176011)(8936002)(14454004)(99286004)(7736002)(186003)(86362001)(26005)(3660700001)(53546011)(478600001)(3846002)(81166006)(3280700002)(106356001)(81156014)(33656002)(8676002)(83716003)(77096007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3556;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: oLOmqDgWc5KM7Tx4d6gMvztjH1wandqKxSqem/ctZtWudRajYg6gW79kOVHBg0WqAMYUgY7R1ydM1rm1kqmWv/aIkLMTSBGd5EO0utK+/Jn0RPi77I710Ajug/pWJk8ranPRxCgAQqtRPJEsYY576y//sEJU+Gppbr56y+6pf0A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a74a33-9ea9-4fd3-0d6b-08d57d45b7eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 18:21:13.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3556
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 26 Feb 2018, at 19.20, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/26/2018 02:18 PM, Javier Gonz=C3=A1lez wrote:
>> Remove unused variable after a previous cleanup (a8112b631adb)
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 3 ---
>>  1 file changed, 3 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index ce6a7cfdba66..e6cb4317bb50 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -1071,7 +1071,6 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
>>  	struct nvm_geo *geo =3D &dev->geo;
>>  	struct pblk_line_meta *lm =3D &pblk->lm;
>>  	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>> -	int nr_bb =3D 0;
>>  	u64 off;
>>  	int bit =3D -1;
>>  	int emeta_secs;
>> @@ -1087,8 +1086,6 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
>>  		bitmap_or(line->map_bitmap, line->map_bitmap, =
l_mg->bb_aux,
>>  							=
lm->sec_per_line);
>>  		line->sec_in_line -=3D geo->c.clba;
>> -		if (bit >=3D lm->emeta_bb)
>> -			nr_bb++;
>>  	}
>>    	/* Mark smeta metadata sectors as bad sectors */
>=20
> Should Fixes be added?

It's not a bug as such, that's why I didn't add it. But be welcome to do
so if you think it's better.

--Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUUBYACgkQIX4xUKFR
nnRV+g/+J8IE+6UZ07+VZzEzAWZhK4NZVuFg2q2+CeDgOyxw8RBkexwsp+oGANdx
+IZQE97sJwJrn08iyqh5jpgAkZ2w00rZw9zGa6TCfs0RZylC94M+cspjLABhPjl7
BxfHQvaN3Ui6akQI29LXb08yeOqreuYjm9Ef950cURrELGY7Dj+wb+sOiPNi9bxR
p5d92rtd2s3B4mChgj7cOYI7BoYox7gDUx04p0r7om2t0fDuEyT+gkXkHQ78LiMZ
9HBeYK9cmEzDNA6JNGowhnEqpctkNpSvjku9lLvI9bkKnyaDtWir3TvQcwg71tFi
+3wZcltm92Q2PefvakCEK0zSNxcbh99qHh9JxdArWD2cytORpPieHOMLAIVaTO8a
dNCkLsYwJluc5GbEZa/vv6IuN+4P0xmyJV9epTRBbaj4+4fwCJDoYrKeUYgI6Pc4
wgenujh7L23QhV0SvCA7sCKoKmPj2GWFAK4qn3oCP+qiE9PasL4j98J5eEgZ+G+L
gnB2n553hETw0FsudvnwVnFUb4+sdzX3FJp+nDzHrO1amAX2ac75kBNDWMB0J7t+
p3vM6zshh+K9wR/skLuKoSl+3JB0zqOcF8QgEQdiNGOUyr6h87bE5vepiqbeZhlr
Mz0cu1pG3sTrGakG/6dKytkKDN0iQXEQWrDrQEzV1KmmQlGUJp4=
=PodC
-----END PGP SIGNATURE-----

--Apple-Mail=_BAFA84F7-84EA-44B1-B015-A0558FB01868--
