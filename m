Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELuMyMVRHmTxPSrmI0axT5n+WRjEd9vqoy6qaoraxqwEjs1AcJ6IqkQpD7WIXhX1hTsWaODh
ARC-Seal: i=1; a=rsa-sha256; t=1521817772; cv=none;
        d=google.com; s=arc-20160816;
        b=Bx3wMzDBxo9NJS7vvslC3IfH/vWIWRiPXf9COm3WfiohGy+fIE7h4YIBXVJB13d4nv
         8SAGdpYSMaLMaLvEUz6yaV4Hh/+pSfHZc0Wprr+9YZGLp3H03lqaEoJZMQkTg8jfqNaW
         L8FiDO07IOE91u69RzoEbDptYCpwqNZez1Aszvt3YOPBXOatvZ1SwA/LcwYXouRBokMd
         TsV/rV5bbPgiZwnslZWQVXggfeiPKH31nm0JVeV7zg+Vl+cheyC08nyFmBMHI0hYMBwl
         WT+yb3llRMZzrwAL1IKbLaMsfXAfnW0lk/nkqqItPjTIj+RIIcO+KlyZuNS6bj7CwwKv
         2yZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=7Gyt54EdUpPDHK0b6VNPsWPkJ+O/IvpBqKqE4Eiz2Wc=;
        b=O8//ZEFBUketXjd8JY91Gs8IqvR2zKR6XvVwb22GYZr3wl6FS+WDwfhnMgH8K/BXoW
         A2bdRTdDmSpbCZlxq2Tup7BFREgtWkZcjgzdPFQ/vYiVaokMYZ3l1ZWsd/ps9V9E2pjT
         YPDp7NHZY8tykhMgNEJIDKysCLmRgPY8UPlDkopQu71dt3019fCqM5BrC5422eFM70pY
         lDupAAgJqaIxEzj6mZs0Qkz9bRwUq1LmNga5g5xy1tl262X6/G0aa9wC5h2BDcHRgz/Y
         IdpCNYmf1RmsIUiPKs4cC8uQWolvkOrP64uFlS+jJA0UBvFo+I2vtG5uXNtohv6Uk24G
         Qtnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=ubDK8jmw;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.5.69 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=ubDK8jmw;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.5.69 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Razvan
 Stefanescu <razvan.stefanescu@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v2 0/6] bus: fsl-mc: enhance Management Complex userspace
 support
Thread-Topic: [PATCH v2 0/6] bus: fsl-mc: enhance Management Complex userspace
 support
Thread-Index: AQHTvH8RSTFvtHiQNkCMA8QITBDtcaPd9KUAgAADxgA=
Date: Fri, 23 Mar 2018 15:09:28 +0000
Message-ID: <HE1PR04MB3212EFA492177BBF5BF26A44E0A80@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521132659.git.ioana.ciornei@nxp.com>
 <20180323145418.GA21034@kroah.com>
In-Reply-To: <20180323145418.GA21034@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB3145;7:aFPrRKwx/FXXYXt8xKsQPO31IzeBqtYGkYyl9lXZCZZmxDrvqd68z5iApt02+yAqMnmi24pubSEq1s1wm5YJfZUei6STTy/OypUJDeCdiGEp1zZaqFLCXguEiM3bk4WvG0pQdc4Yb6Iiwb0DALWkmORpdmV+LwfX/LyhPqrEgnp+SoId5qG0luPFctmOPFtTTR+6LsG3PBGosIdlQb232gIlZjQ2/sIrk2SVZjHTLTMngcvnqkcc0Mj8GwDP8OGN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 748b9185-d933-4a77-c3c9-08d590d012b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3145;
x-ms-traffictypediagnostic: HE1PR04MB3145:
x-microsoft-antispam-prvs: <HE1PR04MB3145D2134ABCD8666B30E11AE0A80@HE1PR04MB3145.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB3145;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3145;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(106356001)(2900100001)(33656002)(74316002)(55016002)(316002)(7736002)(305945005)(76176011)(5660300001)(478600001)(68736007)(7696005)(229853002)(54906003)(99286004)(11346002)(3660700001)(446003)(6346003)(26005)(186003)(6916009)(81166006)(81156014)(6506007)(102836004)(6436002)(53936002)(6246003)(9686003)(105586002)(8676002)(4326008)(97736004)(25786009)(39060400002)(3280700002)(2906002)(5250100002)(3846002)(6116002)(8936002)(14454004)(86362001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3145;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-microsoft-antispam-message-info: bvuWArTNJ1yLbbCrMu4CmS8zvbNhXic1gqUVioa1V06MKYwgk/6Ph7LIyLJy2z08LZpQooGK30BgR/eAMgL9+Fw09F2NI7YeYBmpBZkACmSwOF3gR1OTRD2RWd3utP0N1uwPQBvgm3HQd1jkf5FfsjVqbf+x7ANY1rkch6w8eh16OG3SurFWYMW8x/ywb45jOfP7QHids/ZE61vQBFaJbnH4+9f4fFTCHTYcAKuV3a55V2zT6LrY4Qw7wx71qPg8I+4jL0G/rQtl80CRP2UXY0wXvfcVwvNdmssgknYAlBzmXJ/PTMDJR/WtUtuMSvvMeCUq/jHrU+vqzNx+0EipeQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748b9185-d933-4a77-c3c9-08d590d012b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:09:28.2689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3145
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024152098474506?=
X-GMAIL-MSGID: =?utf-8?q?1595741592475812714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > This patch set adds restool support in fsl-mc bus along with a rescan
> > attribute to the root DPRC container.
> >
> > Changes in v2:
> >  - changed mc_command in fsl_mc_command structure
> >  - updated fsl_mc_command to use the proper types and moved it in uapi
> >  - added proper sysfs documentation
>=20
> I've applied patches 1 and 3 here, can you redo patch 2 and resend them b=
ased
> on my tree?

Yes, sure. I will send the updated patch set right away.

>=20
> thanks,
>=20
> greg k-h
