Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELv/upicTJA4VMFbMLEQ4W9dgkO+TwgZ4wHN0nkj6qlXGgO1ikYsfBDpx8GjihsMJ5USIeKf
ARC-Seal: i=1; a=rsa-sha256; t=1521820587; cv=none;
        d=google.com; s=arc-20160816;
        b=tBT62OR3GDBMSX+o2RUsFuSeWbVluos7HZaNB0eW43SVTvcnd2XvgtaB6OuTT8H/Jn
         wmSN1DHxp6xBRigf7bOvLpz0XnEFSSXKxByFyw4sjZ/P++fyn1vKiCSn+U4b4db8FTlB
         uCPR0XohQdlme6m3w1s1zQCFJj+w1+iZu0nVQVl5Mysw9bTyvBFOM7wv/94BjDBGcTHe
         SNaJjVpWHJSOsGmUc12pscRlfKuuTm9522dzq3bSAm5I7IoadOOiYoR04y+5IefbXfzQ
         rH7+qjIM2MfdJfetNe5Chngz1Ra/WRLRp3CvsuExR3ANblmwBTtFafmPMKmrhUVFSINs
         m74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=b5QJ6mFzYrEQIiVxnGBDV2zrjBOTs9B6Bo9G6VRNyQA=;
        b=X0CVAkUwNIze5k3N6AWq5fmrdumrPRJmI+NJgJ26ZU0YupED3INtRn7qUtC+hBqXyI
         A9DCtGIGKBVQ5r6gn0BcDM2F6GAGYvl3bIQyNyXWnfcOhXR3bnHpjlaNE0xZASaj8+9N
         5jXAl7qcvMYuFrAzl4tM0EwWr+HJ6eCADntSN41yFDz0Bbg9QEgfTXVv8HzGm00Ht+Se
         D0xrJ8LjL874C1l75obkBDPK3b1Rv8yIFhbmx7IJJQcuDy+Qex0xjFhuJp4O4NPfi2mQ
         SwC/BW7UI3voX7uwejIPpdDb5e/99Pic2JaGNNaD+Kg9i07JfXlv9Na6TjzvGTyV2ncB
         EaNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=nGxKbhIm;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.3.73 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=nGxKbhIm;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.3.73 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stuyoder@gmail.com" <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, "arnd@arndb.de"
	<arnd@arndb.de>, Razvan Stefanescu <razvan.stefanescu@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0rRbeSymdCeEiXdPiYqeyzd6Pd9tsAgAABPBA=
Date: Fri, 23 Mar 2018 15:56:24 +0000
Message-ID: <HE1PR04MB32123F0FF506534B11A1CE5BE0A80@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <20180323154654.GA382@kroah.com>
In-Reply-To: <20180323154654.GA382@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1081;7:D1W2l2hJ8ivvIgWMQCZC1K8HOQpdSz0T/943U5xrocLWRCLxxCp8/70zZAth6sAvETOz/eQMQXRDo2hq9MlOkOuV47bIm9wIOz2iMp9PbS5NnEUGa7vhNBcc1gWs8MnK2vcDUGQwLyDMIGainh9TUb9Og3ArUljl4PysCc4AqsGmwkmEd2rRKqDHCHaua/hDob8NW2/g2xlLTl7x3TxSsSlRFpZCLjYb+dbhAha3YvyuuLCYreduCTF2ddUZYLR0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e84a809-c5b3-4aa5-ea1f-08d590d6a14c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1081;
x-ms-traffictypediagnostic: HE1PR04MB1081:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-microsoft-antispam-prvs: <HE1PR04MB108181B1B6673556703C6323E0A80@HE1PR04MB1081.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB1081;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1081;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(39380400002)(376002)(346002)(189003)(199004)(229853002)(478600001)(86362001)(106356001)(99286004)(68736007)(54906003)(105586002)(53936002)(66066001)(186003)(102836004)(14454004)(11346002)(59450400001)(446003)(316002)(6506007)(26005)(6116002)(2906002)(76176011)(5660300001)(39060400002)(25786009)(7696005)(4326008)(7736002)(305945005)(6916009)(74316002)(97736004)(8676002)(5250100002)(33656002)(55016002)(3846002)(6246003)(6436002)(2900100001)(81156014)(3660700001)(81166006)(3280700002)(8936002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1081;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: gzSsOGEVBEavNGYkdm/8LyohprP+6aakRLABLdAfTVSYFqYw+E/6HiC8FYdH72VS7yAvVWVg5Ep4dthBVdnXs+qghisDP8TqMY+IBK4VjTdBhBcS09CQEoXzm1eU2aE5qERg4hUNtDZMnJWG7xdGJjFBzr/npEgVZ3HEGSBbb/mMAMpjMn0bcXwp7+4X9e9VV7I1VwXTy10QPCFv0veH8KjhQyurq5UpcvYRmrZM8bK+LdiiX4hFX6FZsOLK4S3LO3T923fkD6C43fY5F82zCvByMqo/3LxbwTs3iJooF3SEmSBqFTUGq7YCrnwPCw+MSK3y/Pu0CQAglVe3rYVgFw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e84a809-c5b3-4aa5-ea1f-08d590d6a14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 15:56:24.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1081
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1595744544783073163?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


>=20
> On Fri, Mar 23, 2018 at 10:38:56AM -0500, Ioana Ciornei wrote:
> > +#include "fsl-mc-private.h"
> > +
> > +#define FSL_MC_BUS_MAX_MINORS	1
>=20
> As you only need/want one character device here, why not just use the mis=
c
> device api?  It's much simpler, and handles all of the housekeeping for y=
ou
> correctly.  It also means I don't have to audit all of your chardev code =
to verify it
> is correct :)

I have considered the misc device api but the fsl-mc bus, since it is a pla=
tform driver, is probing before the misc char driver.

Ioana


>=20
> And it will save you lines-of-code, always a good thing.
>=20
> thanks,
>=20
> greg k-h
