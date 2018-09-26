Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3124C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EFC21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 04:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LkdRWC8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EFC21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeIZKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:32:05 -0400
Received: from mail-bn3nam01on0043.outbound.protection.outlook.com ([104.47.33.43]:4288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbeIZKcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1NJHaHF+OlodI08Xv6JLqPL99ieZBzXbkdoXbiWOiA=;
 b=LkdRWC8S6eunoxJeVgUGz9r7+mwpXMpGCGpaCM+v/CE1e/OaGPyxLvT4z/YIFqeVO+5NpTiqalmFT1PbJWajsdJ0+y48RvIq9/l+imjSX+67PSttlgmC826j6uspaatENCS2wOej3ypLgKIB6UKbSWa0vFPzmObNg73jdUQyi5o=
Received: from SN2PR07MB2717.namprd07.prod.outlook.com (10.167.18.135) by
 SN2PR07MB2510.namprd07.prod.outlook.com (10.167.14.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 04:21:06 +0000
Received: from SN2PR07MB2717.namprd07.prod.outlook.com
 ([fe80::e001:13e7:e03d:48a8]) by SN2PR07MB2717.namprd07.prod.outlook.com
 ([fe80::e001:13e7:e03d:48a8%7]) with mapi id 15.20.1164.024; Wed, 26 Sep 2018
 04:21:06 +0000
From:   "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To:     Masanari Iida <standby24x7@gmail.com>
CC:     Dept-Eng QLA2xxx Upstream <qla2xxx-upstream@cavium.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Malavali, Giridhar" <Giridhar.Malavali@cavium.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] scsi: qla2xxx: Fix comment in MODULE_PARM_DESC in qla2xxx
Thread-Topic: [PATCH] scsi: qla2xxx: Fix comment in MODULE_PARM_DESC in
 qla2xxx
Thread-Index: AQHUSbSU7dHSLQJwY0+UWbdg2i3VdKUCDUQA
Date:   Wed, 26 Sep 2018 04:21:06 +0000
Message-ID: <E999CEA6-97FA-4E89-A6B5-FF976EC0F0F5@cavium.com>
References: <20180911094811.12681-1-standby24x7@gmail.com>
In-Reply-To: <20180911094811.12681-1-standby24x7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Himanshu.Madhani@cavium.com; 
x-originating-ip: [173.186.134.106]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR07MB2510;6:O3v36cUUJD3QAB7ub08qsHQpz3vdIVREsllI4DDYElLW25aJksRwmB6z/tYME43/+bQl+9K6oQheLebx5H7orcnnHb+pTVhupIapTPh8ajFwGZmkAArD3x7z9wDLXLvnV+y/2f6ncBKqi8KhrsPSvQc0Asg4skwKhpaWcQn9X1f19jKUfC2W5hz/9/PiO8THmX1JYlCIqnTuMnmrfI3u/zm8CpLrHGcKmh39LFJf7qRjuie6BBqzvxZsqwHpOtT5R5h9mmcayXl+3pSexpZ1ekd/7XnvlW4PEE6X8jdpigtYoUnj/XnWdOX7X1VXtCx2Vm22NLXZjDJRPJlpoPOlYxRxTyizOncrqxGCYCgsMSmu9Y/AQsS3qDcGaVAOaXAsYHumnbD0vx2QRWdESn11iGVSokZFSknIXmq/h2tw1K1Siyvd6h53CaKW3RcT1uPLwYtqe3uM0xVWS7Q4n7p3zg==;5:GJ171AJ0F8H1VyHZkHElsP35+CvCZsL2R2yR2V1IGjv8abyiFV88YCDcy85VNSVIhzbenPYL43Z0min3ty/nZ6Hr8/oNvXMaec5H3LnNiq7ecMHp66nNNdz23WzkKs9xhWV65YwtPOiZ7t4xV5dpqEqltBmOlDWTUCRIA69s1eo=;7:I9IWyTpGTYk/eComcP+usgYoUr3WSTVYQpvXWv3wuBiwJFlcULzL7YBnY45/w/CsMcFs2IGbMciLE7DY4KiiKak+9q9pQDMhMQG7bk49MoYr0K6H6rN2BnZBar3/PVtV2bzAxV7kBSPnDlHLMa+U6bopFS2kwTECc+s9fTH77Jj7fvykE0BU6BxgXpz5f71qJAIUa/0GROnPFwRp7vOuSanB1fB7yUJLj2vWwJFst6SJwmRjC4qHelC/76cc1FcK
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 7bfeb18b-c36b-49d0-906a-08d623677a83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN2PR07MB2510;
x-ms-traffictypediagnostic: SN2PR07MB2510:
x-microsoft-antispam-prvs: <SN2PR07MB251043A7F7943AB188912246F5150@SN2PR07MB2510.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN2PR07MB2510;BCL:0;PCL:0;RULEID:;SRVR:SN2PR07MB2510;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(51914003)(189003)(199004)(66066001)(6436002)(575784001)(14454004)(4326008)(72206003)(1411001)(476003)(2906002)(39060400002)(305945005)(53936002)(5660300001)(14444005)(105586002)(6486002)(5250100002)(229853002)(8676002)(256004)(54906003)(106356001)(478600001)(6116002)(3846002)(68736007)(2616005)(316002)(486006)(97736004)(2900100001)(76176011)(6916009)(7736002)(81156014)(26005)(83716004)(53546011)(71200400001)(71190400001)(102836004)(6506007)(81166006)(36756003)(99286004)(8936002)(82746002)(25786009)(86362001)(33656002)(6512007)(446003)(186003)(6246003)(11346002)(34290500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR07MB2510;H:SN2PR07MB2717.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Y/G+7CGFD9HYC1TLid+vZBNIOIu0ptezH5fO55KkUDMt+gphdpdIMqzR9r8OmWgknZNmNFd4SrFb/6D7GV7aJ2LAI8PAhDWTon0xlJERBC1clnGz3gsHllSftUrTIz/fH941LBngDyaEmhTSyFVdgxBS4gSWBOwIE0NYBbHEnRQZzSwNGA7apecqNjvIGkpzjFXJsP2GLHy8u1wOnL7PXLz7We66w81jcP4Xj37f77gZy4UTlhbAEyZhxHcSS8YQKJxonKqX8wWL1E02wgJTaHiM6MsP/HRsgY1hiuOQHT0GsvFS13ekq3Bu/lPPgaJjAAg739J0fViZHe78G8SsTlStTJiZMqKpmuABfvZJuL0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D4D58A776993A4FA72CD7DCF699D475@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfeb18b-c36b-49d0-906a-08d623677a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 04:21:06.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 11, 2018, at 2:48 AM, Masanari Iida <standby24x7@gmail.com> wrote:
>=20
> External Email
>=20
> Default value of ql2xasynctmfenable for qla2xxx driver was
> set to 1 in commit 043dc1d7e8501.
> But comment in MODULE_PARAM_DESC was not modified.
>=20
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
> drivers/scsi/qla2xxx/qla_os.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.=
c
> index 42b8f0d3e580..fe5404be73c5 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -204,7 +204,7 @@ int ql2xasynctmfenable =3D 1;
> module_param(ql2xasynctmfenable, int, S_IRUGO);
> MODULE_PARM_DESC(ql2xasynctmfenable,
>                "Enables issue of TM IOCBs asynchronously via IOCB mechani=
sm"
> -               "Default is 0 - Issue TM IOCBs via mailbox mechanism.");
> +               "Default is 1 - Issue TM IOCBs via mailbox mechanism.");
>=20
> int ql2xdontresethba;
> module_param(ql2xdontresethba, int, S_IRUGO|S_IWUSR);
> --
> 2.19.0
>=20

Thanks for the patch.=20

Acked-by: Himanshu Madhani <himanshu.madhani@cavium.com>

-Himanshu

