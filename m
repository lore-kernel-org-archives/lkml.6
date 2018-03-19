Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvO9p/4VhVCX0+MqoSt/um5SmwnOitquFOlCFYPFDE69xHgU6wLEAYn7CIq72u7s7V5SOEp
ARC-Seal: i=1; a=rsa-sha256; t=1521475199; cv=none;
        d=google.com; s=arc-20160816;
        b=PJIQ9pHeCDqOQooYwqHANuNNuNaFeEcJj42yK+xpGLpUSGPvtb1HdEtRdFUjXbiMhR
         cPlrbrVwOPEf+MfUbBe+c6AMqXvCW7UUpaccGj4IdUiJz9mKwbcbq22VRmCshAXup5k1
         3WxBNk8+t9oFE3eQoznXq7xOc7Y1oLla2Xfl/3ET4lwFFHFTzXIzTjWFffXqm4Zcnnxt
         U3qVfdBP79uQtLCVcSadhCGXb4jcvWUviwgO729yvcko56LfO3iSZT61Y34O0erFF0Ma
         0YwH/IFJEVi9yHx97wQcCY9P2f3CN+awSiyQGyyTWQ1TtyJA+4cmSLQmpPOp++XqGois
         nABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=z1vtahP51MQsxqTYUjxMNW5RoNsr4YQZJb4D0vtQBpA=;
        b=jdrsdXk+eOpYC5dVle0TgAdR0r2ZNObH0wX2SQL+LmRFrceHgVnhx4743U1XKlf1n8
         GDg6kzqSvsowsV3wsyUmdohleQK0ruj+/GkpepkEm7raJOPYBV7uHle0D9+/1HJi4It/
         K/+QgbQ+AGKJhD3j1rO18d/1XVp++LOhh6Fo2zzK8oDiMVNnA7tumvw6+FmSx+B3ekym
         EEewWfyDEtANs1K3L2cblgQ7Zu51sG6RrEA84GaKtXJAN7P+ytithcEglthHjydqztJ1
         0SMCt3pCNxXHiqIRSMLE61ZxuoUSiuIAPOuZIYBnMispe+k5bP8GjL7Z/lzkLzz5zs6I
         Y6nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=VW+Aa/aD;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.98 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=VW+Aa/aD;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.98 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 068/281] USB: ene_usb6250: fix first command
 execution
Thread-Topic: [PATCH AUTOSEL for 4.9 068/281] USB: ene_usb6250: fix first
 command execution
Thread-Index: AQHTv5s3tgWUwv9ZfUmdBgBXNsK7ag==
Date: Mon, 19 Mar 2018 15:59:09 +0000
Message-ID: <20180319155742.13731-68-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:v+iReoWmyvyoSJP7yyTz8ErceLrhf+4K75fJ3S0CdZEqh5LNUfooZtVsaEQzc2NmdCHwQnWRXx/AwtRYSldDa4eNBqmStfUZB3GVX2G5qNbF0+UQHwIj1IH90GwmMRQvPDyNSk8iBTZWl397oxHbr+O8JPbzZ0nRl53+/9egRnxrIw64zaVVveDOAlH1s3212ITJRSn1qHafSZM3dOT7oPUQ3QSfy4HHtnaV9TzhSXbj0Be8HhSCO4Nl2XMBb7F4;20:agghqKlxYWsTRuiZpuCzDYUc98k8+4zILvbRO4anNI5EHNIe2KCWGPBRPHi2L3vlj8BdPLwM09PpkEPl0gf9J93utZIKFP1vcBZ1MFvLLZ/NfCW3DcDKZFhFyKtDH6MulRaWyeofJw/CxfZgiKcXSULAfRc8O0EEFZV1f+p6Or8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cc751c2-c498-4be9-5928-08d58db276e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984835B09F1FBB490304AEEFBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(35762410373642);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(6116002)(25786009)(6486002)(97736004)(1076002)(4326008)(2950100002)(6666003)(66066001)(3846002)(36756003)(81166006)(8676002)(6436002)(106356001)(8936002)(81156014)(2900100001)(105586002)(5250100002)(2501003)(305945005)(7736002)(10090500001)(5660300001)(14454004)(54906003)(68736007)(99286004)(26005)(186003)(6506007)(3280700002)(478600001)(3660700001)(86362001)(107886003)(10290500003)(6512007)(86612001)(72206003)(53936002)(76176011)(316002)(22452003)(102836004)(110136005)(2906002)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: gqN6nE5OW9Kz+cJwJzp+WZOnxPR/rp91mXzMbiQc1niyTFPAMB1pbJmTBU6BtI06+3DL5lMKoc3ZN/aoqb6CkrV2ltNXIdCKGYj5sUE0kcaXLgc587On14CsKBcGDqYWz6UYCdFT68/fL6sIeIJaGCuwleVJHyzeKdw0MV8nGgkIMCUE1yQ57K/Uy6a9Qm/h2koV7a+N0pN3aO+y/q9/TGXXO+aJCcRmlJWSFlI/AleW5JFnBz8F13BLXw/f/TBVeyHdH2xDLR+IIpniapU5Ac/RCwxoqW579G1FlE5TtnWC4GmuEMS5eq80j/gpZ7mlqGVp4s5FFw4MJgM6oVYeFw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc751c2-c498-4be9-5928-08d58db276e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:09.3539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382379241586262?=
X-GMAIL-MSGID: =?utf-8?q?1595382379241586262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit 4b309f1c4972c8f09e03ac64fc63510dbf5591a4 ]

In the ene_usb6250 sub-driver for usb-storage, the ene_transport()
routine is supposed to initialize the driver before executing the
current command, if the initialization has not already been performed.
However, a bug in the routine causes it to skip the command after
doing the initialization.  Also, the routine does not return an
appropriate error code if either the initialization or the command
fails.

As a result of the first bug, the first command (a SCSI INQUIRY) is
not carried out.  The results can be seen in the system log, in the
form of a warning message and empty or garbage INQUIRY data:

Apr 18 22:40:08 notebook2 kernel: scsi host6: scsi scan: INQUIRY result too=
 short (5), using 36
Apr 18 22:40:08 notebook2 kernel: scsi 6:0:0:0: Direct-Access              =
                      PQ: 0 ANSI: 0

This patch fixes both errors.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/storage/ene_ub6250.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6=
250.c
index 4340b4925daa..4199fe563c71 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2295,21 +2295,22 @@ static int ms_scsi_irp(struct us_data *us, struct s=
csi_cmnd *srb)
=20
 static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
-	int result =3D 0;
+	int result =3D USB_STOR_XFER_GOOD;
 	struct ene_ub6250_info *info =3D (struct ene_ub6250_info *)(us->extra);
=20
 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready))) {
+	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready)))
 		result =3D ene_init(us);
-	} else {
+	if (result =3D=3D USB_STOR_XFER_GOOD) {
+		result =3D USB_STOR_TRANSPORT_ERROR;
 		if (info->SD_Status.Ready)
 			result =3D sd_scsi_irp(us, srb);
=20
 		if (info->MS_Status.Ready)
 			result =3D ms_scsi_irp(us, srb);
 	}
-	return 0;
+	return result;
 }
=20
 static struct scsi_host_template ene_ub6250_host_template;
--=20
2.14.1
