Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeDQJ0k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:26:40 -0400
Received: from mail-bl2nam02on0045.outbound.protection.outlook.com ([104.47.38.45]:34956
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752189AbeDQJ0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:26:37 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Wei Xu <wxu@cnexlabs.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: lightnvm: add granby support
Thread-Topic: [PATCH] nvme: lightnvm: add granby support
Thread-Index: AQHT1e8tWHIOfLepCUCLO4CHj/xP6aQEsHIA
Date: Tue, 17 Apr 2018 09:26:29 +0000
Message-ID: <C98EF5A1-0836-40B8-BEDD-8D66C0820257@cnexlabs.com>
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
In-Reply-To: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB540;7:HFiAtG/aASIddM5QaNM/6Bn1SL9CSDLJpJWrl/lvphGootaObInHj3BSxmh/f4YFttE4l9/2VKsUqG3ZgUUn67qn8N8itmCE/q/0ruPaJk0q/XPdCHuLGIWcGshnalowtMkqEUVTKEZzfQ6YvNyWZ67feEf8fyGKdroaiGIftDYDYBXYitXTIbzA2c+SLs6XZBq2yzAMAYo66QdrVmhu7dxj+lCo5yW73errHvWMjaPnTiypCztBrLXk+uXke1GL
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39830400003)(39380400002)(189003)(199004)(81156014)(7736002)(99936001)(3280700002)(33656002)(3660700001)(4326008)(305945005)(478600001)(68736007)(8936002)(3846002)(25786009)(5660300001)(6116002)(6636002)(81166006)(6436002)(6512007)(14454004)(2906002)(66066001)(11346002)(5250100002)(6862004)(476003)(53936002)(486006)(76176011)(2616005)(102836004)(83716003)(446003)(99286004)(59450400001)(6246003)(82746002)(54906003)(316002)(106356001)(6506007)(86362001)(105586002)(26005)(37006003)(229853002)(36756003)(97736004)(6486002)(8676002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB540;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB540;
x-ms-traffictypediagnostic: CO2PR06MB540:
x-microsoft-antispam-prvs: <CO2PR06MB5405E7C266982B8165F6682BAB70@CO2PR06MB540.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CO2PR06MB540;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB540;
x-forefront-prvs: 0645BEB7AA
x-microsoft-antispam-message-info: WRUstdRO0K2qa/IUohuslWGUdPwzsr/pqknK1WG14Tqx3d86ng8uMw1+1qAubQ1YGbfyS/H29X7ZoJWd4g3GjcW1f84fzHXIwuCRqjjZ0sjX1lrB6n0TCHx7K/mIDsgCl5oshV06WAKrWN74zj8fDHmN3CltDwAJIZZNDHFbNB7P3dykRDRDcd44gdsOy53z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9ef1dead-4390-4b09-397e-08d5a4454d7c
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef1dead-4390-4b09-397e-08d5a4454d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 09:26:30.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB540
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Apr 2018, at 03.55, Wei Xu <wxu@cnexlabs.com> wrote:
>=20
> Add a new lightnvm quirk to identify CNEX=E2=80=99s Granby controller.
>=20
> Signed-off-by: Wei Xu <wxu@cnexlabs.com>
> ---
> drivers/nvme/host/pci.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cb73bc8..9419e88 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2529,6 +2529,8 @@ static const struct pci_device_id =
nvme_id_table[] =3D {
> 		.driver_data =3D NVME_QUIRK_LIGHTNVM, },
> 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
> 		.driver_data =3D NVME_QUIRK_LIGHTNVM, },
> +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
> +		.driver_data =3D NVME_QUIRK_LIGHTNVM, },
> 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> --
> 2.7.4


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrVvcMACgkQIX4xUKFR
nnTUexAA3+L+MAjO8TdarE2VZBqkQ3s+yvRuFkVyi0EGGhSvxqrRz+uyXra2ZShG
uCe3rqhy/kc2xvfa7TOzisL1lbyIz/Yl/HQV2aHczSAgH7x4ik8JQcq5GcBjd40X
P5UBjz2XZJKBd18U3XDWwpcQU0y9WlJ7GOYmym7sNy01PeGWUjbYX9cZPcBpmLo2
kxRci2IkbnNJZAW+LN8WJ/FdMeIktXhVXvjXjVp7N6gXZ7KSwffPimIiZLbl4Krd
tcp+BZ3CMTZLA5l+9OryPGx4EQJIbtf8ggBtUrgt93P0Uc0Huf37fsbrEb+q6CiN
2L5OFnsqvK258YZaX5jE1gx3AcZT025MDomv7c5z5TW6OsRN4RMN9+MzAYSybFDg
3P/akt8lebLw+V0Z4JeR757PY+cEzNt85AU6Eyk1jPQTSZmO6PY6D/51JFfaKxlY
bf0hhOK2sDAZMP04FU1fqwrT3tvNBRCiAdACFVLTd3O2rtp/EeJlz/bkrl4leF8g
uTCLOfooeseICHGXHalW9Ky7zaYt3CYcgDWzPFpzvgjCU1qGSr69pp9pn9Xy6csU
4LeGY0YZ0u4Y0Tz9ztTVsoDzOoQ9ScJFE9fi3JaPV5sUZXqs+RE2s2tviZXS8+uW
kJNAjJRro0Kz52UOgIgWcLguB6qBBaMwlNfZywQE874/KVPVreI=
=kyh3
-----END PGP SIGNATURE-----

--Apple-Mail=_6192595E-A48C-4546-8A74-AAB6CB9E9072--
