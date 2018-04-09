Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx48vEJo4RXREKF4f9vX4YHhwxpkAO082NzlJnUKib2fshF3kCnseka4mlzbVqLc++in1gfKy
ARC-Seal: i=1; a=rsa-sha256; t=1523234108; cv=none;
        d=google.com; s=arc-20160816;
        b=zHJVFAX3YHeS9QRcfBuXUcRU+LfC+BxZPCRJYtrQEMgdAV3j9u50QGjeZLothpNB9q
         CAV/l/6Ka1dUOYi1cFco8ElfhX/i09jlAf6mryVhn+jQnzMTOuD6mc4wnL74cr298LVU
         LKXdzIHzJDVj1Al6GTCRnrKblowu16IirMlGN3KGiq+qtU37E6q/SDhFUClhGPgJav8H
         mxYXF1JqtaIaM/ibbU8RWnC418QS1Ob8Q1doeBnLjStTCnNXvb6Lr96aOXFNsP1vozYi
         m4lfDNny6IFfwxc7D35Dc95SmeftvU93OVQAzmfmEHf2rnbx444IXYw47hIIsH7akWAK
         1G6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=i3Uct/sO1dm0VUJIpY76zyNh1CMAt7uU2Iw/G7AwWuA=;
        b=gQ3cPauniKAQee0P9bhtlA/foMmWobcVUZhwRvdHKQG/Ka6u1zVwGYl+XZKjHROQMZ
         p4Ql2tvmoDCCYHPA+tV65FZ94ZsnYKYg5DtDi2ld0V12EoBiFaQGmPq57eaPTPxwmpC3
         l2FpNzlZIix7e+AhkaOHZw8uVzPtan2IF7/YvM379alvAMmZn1kA0LbCr41uCe9+Ki7/
         wtcLzR3+6xpUkBAzNooE9Y2nfyD8QEGOUfy+ke90gqZ1mOiBhKRsjcZZrQJgn3LsovHL
         oBgvmlh9SW4roi/j8Nuh68rx6oqIODBQri1h2VCca9hYLWG86CoqlZMyYOyjlx/u9HQE
         oCLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=TpjyQrX4;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=TpjyQrX4;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 026/162] usb: usbip tool: Check the return of
 get_nports()
Thread-Topic: [PATCH AUTOSEL for 4.4 026/162] usb: usbip tool: Check the
 return of get_nports()
Thread-Index: AQHTz5me/XCAF1g3t0ad6lKo8JCsHA==
Date: Mon, 9 Apr 2018 00:28:01 +0000
Message-ID: <20180409002738.163941-26-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:gFMOB0gdy3lzUxybVj95lhTxGdf3g6ky6aQCOSJL1486YR4Tt/X5/KgQGixZc3YPrO8n9Kp2BW1x5Xja6NYifWrznwDvrMjvhvXBVdv0ROBxZoKbktNmctUIBOkvu6I2Y1xoyljzcKKVMPQLy8S1C288eF29VhdKY+u4jTgY3QYPn8vTmgh7HwwVoAfzCXqfpCCFgQ75P0zDp+kIcsk86TGMB2P4DjcR/NGArQZNWTiNaqKntbWmHXZfiZSdBOVx;20:PLRt01E0b63IFfZSnNfYPPdhoVN9cNjN3yWXRCcPOipHoaXNBxAo7tmgqUZ4ddJ/2NloNUdAyEnQRv0CLebjJK+y9xkFi35Qsw+aG1nxpuQEldR9F0Xes13VIR8IA3lmtalWIP1fJBSUGt1CDmYVOdY6/exweJq8mPNcIFhgpYU=
X-MS-Office365-Filtering-Correlation-Id: 4243b9dd-234e-44e4-0a11-08d59db1be3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101320FFC4FF765D454A2AC3FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4eIKMHui/qK6rUt3hgtnzPqtSlkm5B7OpOTGVbqlvtOi/j/aMFDMQyqZVuPp+4ZzynZJhLmNkacvpn+nzvJLmBPBUDZzXE/66S8To51vWXNvws/OalpXXM5raOUcpJ+ejfYyU8ly539rcU4NZuNl/iBk6oF0uqbQHzJAeSd5EBQilHahNkxzqDLrDxZauHtIh4tLkMk6TsQZGL29CbgUX9HZXLMC2B9A8iwY4qN4VOpo2+rkvjuY1M9PgA+5X5b+UaVuhnFaKqEw82YbX3UNKcVplkWuHMo2iHgiDU0AAqIE69ZDdAHFPuh8y8cmGSwgd98pZt+FRNzVmUWm3znJ5kY8igqlNOkZ4YgzyPZC0Aob7oJ1D5UYB21U8uQ+1wCi/5ormciyf7SaWXPYyCvvuWCOij9KBIPl8w9yft8mQoE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4243b9dd-234e-44e4-0a11-08d59db1be3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:01.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226252461156417?=
X-GMAIL-MSGID: =?utf-8?q?1597226728836997766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yuyang Du <yuyang.du@intel.com>

[ Upstream commit c3509715fc9484a48b69a9f0196b728c960840c9 ]

If we get nonpositive number of ports, there is no sense to
continue, then fail gracefully.

In addition, the commit 0775a9cbc694e8c72 ("usbip: vhci extension:
modifications to vhci driver") introduced configurable numbers of
controllers and ports, but we have a static port number maximum,
MAXNPORT. If exceeded, the idev array will be overflown. We fix
it by validating the nports to make sure the port number max is
not exceeded.

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>
Signed-off-by: Yuyang Du <yuyang.du@intel.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/usb/usbip/libsrc/vhci_driver.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/=
vhci_driver.c
index 1274f326242c..c589cfbd1cfe 100644
--- a/tools/usb/usbip/libsrc/vhci_driver.c
+++ b/tools/usb/usbip/libsrc/vhci_driver.c
@@ -238,9 +238,16 @@ int usbip_vhci_driver_open(void)
 	}
=20
 	vhci_driver->nports =3D get_nports();
-
 	dbg("available ports: %d", vhci_driver->nports);
=20
+	if (vhci_driver->nports <=3D 0) {
+		err("no available ports");
+		goto err;
+	} else if (vhci_driver->nports > MAXNPORT) {
+		err("port number exceeds %d", MAXNPORT);
+		goto err;
+	}
+
 	if (refresh_imported_device_list())
 		goto err;
=20
--=20
2.15.1
