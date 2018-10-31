Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F1ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5971120657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xl1cXCcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5971120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeKADWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:22:21 -0400
Received: from mail-bl2nam02on0069.outbound.protection.outlook.com ([104.47.38.69]:32160
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730069AbeKADWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nKyhyBiE88cQ89HLFmAJScAT/c0lBxr1JGdkxP5lYA=;
 b=Xl1cXCcA+ggRK+44WMT3iWaqDdIYSPMT3yeE3XNvUhURLcTLj2LkNeQ4WrnPQxV5UTygcNb9ztVpBqTdGOL+r85uiin/j756lqGnnSmJd27fDENrJTD5SX6sSy3ixNiB2DNc7phYhpCbIwUoyh3q2CjpT3bVkYNvj+/KVZcfjj0=
Received: from MWHPR1201MB2526.namprd12.prod.outlook.com (10.172.96.20) by
 MWHPR1201MB0237.namprd12.prod.outlook.com (10.174.99.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Wed, 31 Oct 2018 18:23:07 +0000
Received: from MWHPR1201MB2526.namprd12.prod.outlook.com
 ([fe80::ccde:d5e3:17a2:2c3d]) by MWHPR1201MB2526.namprd12.prod.outlook.com
 ([fe80::ccde:d5e3:17a2:2c3d%12]) with mapi id 15.20.1294.021; Wed, 31 Oct
 2018 18:23:07 +0000
From:   "Hurwitz, Sherry" <sherry.hurwitz@amd.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "longli@microsoft.com" <longli@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>
Subject: Tested-by test
Thread-Topic: Tested-by test
Thread-Index: AQHUcUbEWstqD7zfXE2fqdeospqd3Q==
Date:   Wed, 31 Oct 2018 18:23:06 +0000
Message-ID: <1541010174-28621-1-git-send-email-sherry.hurwitz@amd.com>
References: <20181023014044.15888-1-longli@linuxonhyperv.com>
In-Reply-To: <20181023014044.15888-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.78.1]
x-mailer: git-send-email 2.7.4
x-clientproxiedby: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To MWHPR1201MB2526.namprd12.prod.outlook.com
 (2603:10b6:300:e0::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.hurwitz@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0237;20:hx2lMqAzpHU8fIttr79Y9WT+3zwjwBVGYRt4tQIkSH3HeI8B+7qi1WcdXOc+lvvfVO7OpADwMDOsXrAYLA/GhUOSe83cA2MyuYMn0hrEEg9B00S6RaGB0rfjrGXP8r63W/94j/1H5qj0B3xeYF+0FwdNfKJC02ejMNNns9ei0CAQGtdpu2LjQKye4YRZ4NoEMtmLvg4cwJNPCKpmwsLaKUr5deqqS7iLoOtZHduresWkbcrncuUWJ6c8Ltdy3zhw
x-ms-office365-filtering-correlation-id: cce33ccd-a861-46f3-2435-08d63f5de72e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR1201MB0237;
x-ms-traffictypediagnostic: MWHPR1201MB0237:
x-microsoft-antispam-prvs: <MWHPR1201MB0237895C5A185D17722D2E0B8BCD0@MWHPR1201MB0237.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR1201MB0237;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0237;
x-forefront-prvs: 084285FC5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(86362001)(11346002)(486006)(97736004)(102836004)(6916009)(26005)(2900100001)(316002)(7736002)(2351001)(99286004)(68736007)(186003)(4326008)(36756003)(66066001)(476003)(2616005)(256004)(5250100002)(2501003)(478600001)(446003)(2906002)(6116002)(3846002)(8936002)(5660300001)(53936002)(3480700004)(81166006)(6436002)(81156014)(54906003)(6506007)(106356001)(71200400001)(50226002)(105586002)(6486002)(8676002)(25786009)(76176011)(6512007)(14454004)(305945005)(1730700003)(52116002)(71190400001)(5640700003)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0237;H:MWHPR1201MB2526.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H5JPJG5Yh9iUeuJ9EjU4XwevLDuYHtoF6f4iVZ3P6TYl6heKNLwFfbZ96/GUukJW3fQxd/E3moDpN2AbsYKJtvgzC2+PR9tD7egNaTXsYEm3l3e93x35vj3BHn+Qy8iIhtC019M/1N1zkWYYUE+YMzmSSZ2T54FMiJkIiOxcJMI7toaNaj4wPpb6txrZNW+jBDaKuQQxzAEbdMQBoSB41AaBYZFvAOW/WonNbr6Agw4pKaf17VfzKWZTOw0z7sRGlL9spt6MJnIzBmbrH4TEmjz7zULSGRf9DoG2eGFrR2INw2F0ngggmHUPrDm1Wk/wlpaOcB7CHcbm7KV+WJl1ccOC7+6gwJjqSCUZn9c+gzA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce33ccd-a861-46f3-2435-08d63f5de72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2018 18:23:07.0249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with fio on a 2 socket AMD EPYC based server with 128 cores and 8 nv=
me drives.  Comparing baseline linux-next kernel results with linux-next wi=
th this patch applied IOPS increased by 40%.=20

sudo fio --bs=3D4k --ioengine=3Dlibaio --iodepth=3D16 --filename=3D/dev/nvm=
e1n1:/dev/nvme2n1:/dev/nvme3n1:/dev/nvme4n1:/dev/nvme5n1:/dev/nvme6n1:/dev/=
nvme7n1:/dev/nvme8n1 --direct=3D1 --runtime=3D60 --numjobs=3D160 --rw=3Dran=
dread --name=3Dtest --group_reporting

Tested-by: Sherry Hurwitz <sherry.hurwitz@amd.com>
