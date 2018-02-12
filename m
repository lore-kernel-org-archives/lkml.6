Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeBLUVz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:21:55 -0500
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:58687
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751021AbeBLUVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:21:53 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 4/4] nvme: lightnvm: add late setup of block size and
 metadata
Thread-Topic: [PATCH V2 4/4] nvme: lightnvm: add late setup of block size and
 metadata
Thread-Index: AQHToYhGel+Ul19qFEGj6ERuTHrKtaOhOyIA
Date: Mon, 12 Feb 2018 20:21:49 +0000
Message-ID: <098A1343-A9FB-47BD-A4B5-6E77A1861A4B@cnexlabs.com>
References: <20180209092719.10679-1-mb@lightnvm.io>
 <20180209092719.10679-5-mb@lightnvm.io>
In-Reply-To: <20180209092719.10679-5-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [50.207.153.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB2532;7:nfk1DjwtoR8GXNq4hJCIgFLedmP5IlxMQoLbae4AwTLxeeFkuWcwjh5sc2BHDN+fOyt+Mdbg3USpouc2ZLVqOMjg3oiB8GAccKLCBkY1XmIlK0HnrrXjtG07HDnqe8h6ncrdzadIAulPodzITFq32TWYWOmUTAI1tHFOuWm/ulKFpyE37DG4MYnrGxGrcGk9VaUT4j4gN775iuanUDziu3GdX54SlvgbGEQgZ0dKciTItsxnTbHuHxg1++kieHZW
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: b2433a0c-5058-4894-6fea-08d572563f42
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB2532;
x-ms-traffictypediagnostic: BN6PR06MB2532:
x-microsoft-antispam-prvs: <BN6PR06MB2532BF1C1072217B01E47457BAF70@BN6PR06MB2532.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR06MB2532;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB2532;
x-forefront-prvs: 0581B5AB35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(346002)(39840400004)(396003)(376002)(199004)(189003)(6486002)(8676002)(8936002)(6436002)(106356001)(316002)(25786009)(26005)(305945005)(77096007)(6512007)(6916009)(2950100002)(83716003)(7736002)(186003)(54906003)(229853002)(102836004)(68736007)(5660300001)(81156014)(81166006)(6116002)(3846002)(478600001)(53936002)(99286004)(2906002)(3280700002)(99936001)(3660700001)(97736004)(82746002)(36756003)(6506007)(4326008)(105586002)(33656002)(59450400001)(14454004)(76176011)(6246003)(66066001)(86362001)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB2532;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: g/XAcwL26DaZSl/KelgTyYBh9daHcUYcQDnWnhK44z8hzy3YOlL7KemVKJJYB6tL/xavzbKskB9yWmOMM0KEew==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2433a0c-5058-4894-6fea-08d572563f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 20:21:49.6084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2532
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 9 Feb 2018, at 01.27, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The nvme driver sets up the size of the nvme namespace in two steps.
> First it initializes the device with standard logical block and
> metadata sizes, and then sets the correct logical block and metadata
> size. Due to the OCSSD 2.0 specification relies on the namespace to
> expose these sizes for correct initialization, let it be updated
> appropriately on the LightNVM side as well.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
>=20

This late initialization breaks ligthnvm's core init since the sector
size (csecs) is used on the first init part to set the logical block =
size.

nvm_core_init -> blk_queue_logical_block_size(dev->q, dev_geo->c.csecs);

We can do do a nvme_nvm_revalidate and set this on the revalidation path
instead of simply updating the info as in nvme_nvm_update_nvm_info().

Javier

--Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqB91gACgkQIX4xUKFR
nnQxbxAAydq8diQ9d+x+W8742it3pffX7sqxY967LC2tcFvrmj8El2smPAD1P5wk
g2QWRAZ7gTkWX/dfVO9HxSCyV2+IAl1/TJVOK1PvL8IELGnuwgrhBFDyu3ox/83A
yzNEAFSklDVlboEcm6vpCmNkniJCbABXHfrZX6gHMgQNmGnL3fIgL3Os1IcABBHd
J0Hk9YRjuSnipuONTeZhLh/OLe1oxdXDuVvHMuW0HQXneLGjjfmylKXgzdHXQc08
ZVRRgrZSEYWWeIzb+dGZkEng7BaRm7W2/v8e+85G26TPZQcNz2Jbtys3iWAhAE6/
8nsub/hDr6KZWrhvpwz0aO7mhnDKXHYrlGhgiW9bGa/8lyJO+cXgp+k9Kpe+Xvv6
rUZinkiS8EEfSAPuGQHYMUOkc0yQdW3gUM8yDFOA+j/WpE+bIEH8LHdJQSptUwja
YF3bNv900ifSsXuUrHqS3cMlWUSdhaytAo5VS6kR2Xt1ULjCT6ftoK/0U39MCqP2
fBPI+gR0oaP6dG4pdR+AuEH3zfz4Bin6eMEIu82boPYbPlWgeVEO6vaTiZaLgMea
ln6Cthk/D8vu2vMVgVnRHYrk9GRc6Om2vomAY1i67RXZqx6gy8dvUWqPm/V9zttj
NS5rAOmcaWp7a3g2WIVZ0NoYaSdZ05k4j0D1uhBOd0XJRDz13iQ=
=0okX
-----END PGP SIGNATURE-----

--Apple-Mail=_E4450FA5-2150-4D0B-87C9-AC311466B328--
