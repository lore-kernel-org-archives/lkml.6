Return-Path: <diana.craciun@nxp.com>
X-Google-Smtp-Source: AG47ELslZUNRdsv+YJaxp2/LJQcQA0l2BMHIIF0MyaoLeSX95g/8wGFe030vlCkJhEjubxR62U5f
ARC-Seal: i=1; a=rsa-sha256; t=1521820795; cv=none;
        d=google.com; s=arc-20160816;
        b=tZBy9z14c/w0de2nFGEMzd5tRjzpTK3d2YcWv0BWpX5uDnsgQvRE5oc0dEU0TOu6KV
         rCSNL4yeX8mgRIwGOechWKsX3oQf3eIfJ7lL+znp3P8Ac695gjyPKl9UWYy/KtRJVopA
         3fXHwOfN8PPDXL2gcrLNPVFpVzPMPwn/K4jWezjEwTZ/jJxZLa1ef1fyhEEWLWZk/aMx
         NpaKnQQdQ5Zm+ntSQGN8ma0Lao39S+uluoWXPITK26Ig7yqcn9in+to71RS67T2xejhn
         XRCDVce7VK5dvaaC7lBIixh3JtAzPGl+xtsMx0ZVjbroG/RXc/PANknH9jpVVdVf6ZLp
         namw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6xYqw4b0zbDeqeqfNnL7JOKdWTD68BHLHEVBbY+jLQ0=;
        b=WO9pvjBmJk1byg8Rw9vL2hbs1I1cJMyPxHVKo29aGxgrqSEBy1JzCR5gvQ85+UR88I
         P5SWFQXhd0i3oz7cqTDZgC9kE5UT6ZJkv87NjOWUD8u7kT0z4lLKvdy+9tPs7w2jZham
         D6hbaGRJ1bQRPSnp5VpS6/01n7qxbPd5C4W/v88eECEsL+89Trjwo+jfPxKDW6xotKsr
         ZJGzOzVVlam0V9hNTXCxBAP7k4v6Srrr/g1pDF/3W732qN4nlx/yXBlvWL7oF/IzBiew
         f/vvVF+exQc6x4Pgw4/T685cxY+9/Ry3U8fciuMIrkUuzaVNTZSYZXpCKpmP30zI1Q6e
         KIEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=DvEH8A3H;
       spf=pass (google.com: domain of diana.craciun@nxp.com designates 40.107.2.55 as permitted sender) smtp.mailfrom=diana.craciun@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=DvEH8A3H;
       spf=pass (google.com: domain of diana.craciun@nxp.com designates 40.107.2.55 as permitted sender) smtp.mailfrom=diana.craciun@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Diana Madalina Craciun <diana.craciun@nxp.com>
To: Michal Suchanek <msuchanek@suse.de>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
	<maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>, Michael
 Neuling <mikey@neuling.org>, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens
	<dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
	=?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, David Gibson
	<david@gibson.dropbear.id.au>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sergey Senozhatsky
	<sergey.senozhatsky@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne
	<pombredanne@nexb.com>, Joe Perches <joe@perches.com>, Oliver O'Halloran
	<oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Tobin C.
 Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 9/9] powerpc/64: barrier_nospec: Add
 commandline trigger
Thread-Topic: [PATCH RFC rebase 9/9] powerpc/64: barrier_nospec: Add
 commandline trigger
Thread-Index: AQHTvJSv3hggio9YDU6ISyDW5QYSAw==
Date: Fri, 23 Mar 2018 15:59:50 +0000
Message-ID: <HE1PR0401MB2634FE1189DA2E7B8C405FECFFA80@HE1PR0401MB2634.eurprd04.prod.outlook.com>
References: <cover.1521141122.git.msuchanek@suse.de>
 <1dcf7403042daddcdb8109f6b852b9bb9d768f89.1521141122.git.msuchanek@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=diana.craciun@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB1804;7:DCLFSuULG85RZ+uIWOHOPMkDwINBACKwTZe5VaeN+F3TRn2Mxk1GL3e2/M13T976MBXjQ+/f66ub7TypEfKAWOKy7npgz7Zsm1qadv4mb8n756k5qKmLKZZuah2IbUtSCaAEgH3EYnWUXLBaU0PmqiVIoPAaFYNY6zXBbHSwSDNAPsXsADWJGAPzn0/Vk8yJnEw9vGRbMzP6CQRkMU4XUz9AWGrOQPsxPUYZPsRA8iIhDzqnDS3c1T1jSl/aiMJY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 174cb0f9-0746-4f6e-c988-08d590d71c41
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB1804;
x-ms-traffictypediagnostic: HE1PR0401MB1804:
x-microsoft-antispam-prvs: <HE1PR0401MB18046C52872113927FA4B97BFFA80@HE1PR0401MB1804.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0401MB1804;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB1804;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(66066001)(2900100001)(3280700002)(97736004)(305945005)(33656002)(68736007)(74316002)(6436002)(55016002)(9686003)(4326008)(446003)(26005)(53546011)(102836004)(6506007)(25786009)(39060400002)(7736002)(186003)(229853002)(14454004)(110136005)(81166006)(8676002)(3660700001)(8936002)(478600001)(76176011)(5250100002)(2906002)(86362001)(81156014)(54906003)(53936002)(7696005)(6246003)(316002)(5660300001)(7416002)(106356001)(99286004)(2501003)(6116002)(105586002)(3846002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB1804;H:HE1PR0401MB2634.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: O8+OllKFiiDbIhZT+GTJMaJBozzvJZgNUsM1s2w8R4eeV97LfErUWVj/QJoAbwidWxcupoqjfhamyhSv54sPFi7mzvUFSUQ4p2eKlYwTT2H6+PnIuiESY+ZmMtJ0M4ebQiQ+ZN3Xu48YFZuypEr65+p58UNBbuhC3r2mBtcoqYtFaOWYO3vt/yn4fkE9QqlBrOzwp16xG3evhC4ujcjngPDIQVwrVOHDRpxqhgqeXnvHIPHlk2NHeFKxZBOhqtCxnDykpIKojJV/8sWlCBBR+ezgFXYoRy54wwqKdBFKV5A3uLMi23bWVzAVW6eOo5taLqWe3SrVVH24tP/PU5qJzw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 174cb0f9-0746-4f6e-c988-08d590d71c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:59:50.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB1804
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032351746751096?=
X-GMAIL-MSGID: =?utf-8?q?1595744762751513450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/15/2018 9:34 PM, Michal Suchanek wrote:=0A=
> Add commandline options spectre_v2 and nospectre_v2=0A=
>=0A=
> These are named same as similar x86 options regardless of actual effect=
=0A=
> to not require platform-specific configuration.=0A=
>=0A=
> Supported options:=0A=
> nospectre_v2 or spectre_v2=3Doff - speculation barrier not used=0A=
> spectre_v2=3Don or spectre_v2=3Dauto - speculation barrier used=0A=
=0A=
Why the barrier is enabled only for spectre variant 2 mitigations? It=0A=
can be used as well for variant 1 mitigations. In fact I am not sure=0A=
that the places where it is used fall under spectre 2 at all.=0A=
=0A=
>=0A=
> Changing the settings after boot is not supported and VM migration may=0A=
> change requirements so auto is same as on.=0A=
>=0A=
> Based on s390 implementation=0A=
>=0A=
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>=0A=
> ---=0A=
>  arch/powerpc/kernel/setup_64.c | 22 ++++++++++++++++++++++=0A=
>  1 file changed, 22 insertions(+)=0A=
>=0A=
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c=0A=
> index f6678a7b6114..c74e656265df 100644=0A=
> --- a/arch/powerpc/kernel/setup_64.c=0A=
> +++ b/arch/powerpc/kernel/setup_64.c=0A=
> @@ -840,6 +840,28 @@ static int __init handle_no_pti(char *p)=0A=
>  }=0A=
>  early_param("nopti", handle_no_pti);=0A=
>  =0A=
> +static int __init nospectre_v2_setup_early(char *str)=0A=
> +{=0A=
> +	no_nospec =3D true;=0A=
> +	return 0;=0A=
> +}=0A=
> +early_param("nospectre_v2", nospectre_v2_setup_early);=0A=
> +=0A=
> +static int __init spectre_v2_setup_early(char *str)=0A=
> +{=0A=
> +	if (str && !strncmp(str, "on", 2))=0A=
> +		no_nospec =3D false;=0A=
> +=0A=
> +	if (str && !strncmp(str, "off", 3))=0A=
> +		no_nospec =3D true;=0A=
> +=0A=
> +	if (str && !strncmp(str, "auto", 4))=0A=
> +		no_nospec =3D false;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +early_param("spectre_v2", spectre_v2_setup_early);=0A=
> +=0A=
>  static void do_nothing(void *unused)=0A=
>  {=0A=
>  	/*=0A=
=0A=
Thanks,=0A=
=0A=
Diana=0A=
=0A=
