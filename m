Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx49BC04Iq5HaOqFXw8jEyJP1tqgeXvepkdeLrUOXpO3r6/WaaFqYOhH6+wVipeM/LzbczCG1
ARC-Seal: i=1; a=rsa-sha256; t=1523234380; cv=none;
        d=google.com; s=arc-20160816;
        b=nZc/uQ+OwByFzDdpDkP9FSiiOypL1KorJZvH2fIJq0K7WBBRZ19o7mp30jnQ/deycT
         habplWEXHDxX89Du55yDVFI9Lw29DPk5U3C9/1MuIj/B2cnyx/j5byM2sHSLt8AW2v85
         cOpzWnoMB93yaJJ4rz7+rk7ux+Er/x5xxSqNtrL2aimPdNAbPNgadtjh4v2JN1YP0Qd+
         wqDkcm+BNFPJ2EHutDSGcYE1LYoDZO63R4tw7nElHzdFnyGUMBkatMYPyZs2dTAKMq/k
         hA1omC3q0EEdm/o+L+tCHY0EI+6S2kbE4Q+Hp7f31hLHdsm3JlI0psi9zJvr+mux+xU1
         M85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=i3Uct/sO1dm0VUJIpY76zyNh1CMAt7uU2Iw/G7AwWuA=;
        b=eIM2KArvRiAatf5/tLno9M0QyaAsi+988ShCzSJ723klxyW9bUPjq4Tjz5k7847AJP
         6XuC7IqwYkpMF8wQ4Gc8IAgzcgAthnt4oNe4SpMG5XCyKV7MnMSmOTq/xkV13oM3wFn6
         LtURUGoxFEYQa565Df/D8RjpFFNGwJYxwndzHAdy/hHUsxbioPLX3oy/5ZS24N9ZMOy3
         /1TGui9HDKqE68zgSP/6nBgSsM1VM/Gw65W4AwdgWkCQY+XkIUX1pjVKsXRKXdA8IbfV
         WzBegdjUdXefyAIFoRauGQiqy3xQ14vYKJBOEDmfQONxXUMrtPQ/Cz0ju537lKYODltv
         ugPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=RBCajr7w;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.138 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=RBCajr7w;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.138 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Yuyang Du <yuyang.du@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 022/101] usb: usbip tool: Check the return of
 get_nports()
Thread-Topic: [PATCH AUTOSEL for 3.18 022/101] usb: usbip tool: Check the
 return of get_nports()
Thread-Index: AQHTz5qovhPc9+nsUkmv+/bzeWD+eA==
Date: Mon, 9 Apr 2018 00:35:27 +0000
Message-ID: <20180409003505.164715-22-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:RwJPrbuiAjbS4vKfJxv5MwZLRjYd6vQwUNFf6czfyvB4VnUhNHIf+qGY8awdKbZtpEK8yTGryEEdtzd6eLmEGzG4c3HTgkrKYgNmmdCJ7QGxPoT/L5NK/8KkFF6pokZYiMtXx9oxYFVUoe/cYg4J4QL09LN4vU+lP99qCefk9nnkkF3p1bAxe4cufdgjuNFAuzckXVFHexF/7oGqL3d1tNR9zuYLMFofv088TNIAYYYsD19dEadixxc0vS+IM07S;20:vM/KqBbClVVuF+7FCrLJxfaCOlC1BEqAPQy00IPaRd17EeFJBSQEcU5LfpjPkR2Y+ZFpKU6TO9ogxYz8ePx+cFSaa9UN3bZJ8DRYupHnXWH/hfJcN2nyMdjDXOBAgNkgA0aBqWM7Usc3ckOoraG/o/ctVqnkvVzdVqvLgEm6dgU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f20e39c4-3657-4216-1b25-08d59db26083
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966843387FCA2763321905CFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: y3C/xWm8GeR6XR9PHjSTpYZ4ROIvyW6Ar8+M1/X++gPvMM35sQuviqX7WTKESMfGecgqa/zKT7+xnkxJAGKxAauKAEq1FMvmJ8pTtk1SUXfL21233wXNfrWi7kpbALUaIc9x7+vzYM3vUJr5vE7YuyJK0FDS9ugLqi0mD1XHNCm0EmEW2zdw6nHPpGoV0oaxMkGfwWDnnZSQFu+sxKBK4W1EncFyKHLPIHOXurOaUJLhC1slQaFo8uX8Vk9z7fk/VXoy+0WKw6/TJRs0C7KciBjR8SORPdeVVM8o/0QJ9EbjtT0IWfLewdKnTiYCdbJur063I1uEVOOFU9JjzHt356snpxJaKdLMVUhAA6F0S17t8/iVUEteG2LgZd+suCDc8e+VZXgu6OkIrDr8rrxyY9o/1dZP2KP4RNGj+TYMky8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20e39c4-3657-4216-1b25-08d59db26083
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:27.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226252461156417?=
X-GMAIL-MSGID: =?utf-8?q?1597227013862502328?=
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
