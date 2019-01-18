Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7120AC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435CC20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XfOS8MSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfARS15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:27:57 -0500
Received: from mail-eopbgr790057.outbound.protection.outlook.com ([40.107.79.57]:56814
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729083AbfARS1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERHtLO9KoM7azHHx/q861wlQTxqDvLFDzgBAjhc6X9Q=;
 b=XfOS8MSrGkjFrsT6xNmpvU6X437ILUIBepKUBsTEcVFkoPLuXR0vPKBrKPzpDvS53zmVZDqEK+w5s68GxweRTrs4dL2D76RZFM6p6/xE7XHKeLXGjoi3522LwyW3jZbsWN2HbOFhwfbu3qt7G9LuZYhfFja6pkpZL24/zcTxl4E=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1737.namprd12.prod.outlook.com (10.175.89.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 18:27:14 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 18:27:14 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "sai.praneeth.prakhya@intel.com" <sai.praneeth.prakhya@intel.com>,
        "arshiya.hayatkhan.pathan@intel.com" 
        <arshiya.hayatkhan.pathan@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: [PATCH v5 10/13] selftests/resctrl: Add the test in MAINTAINERS
Thread-Topic: [PATCH v5 10/13] selftests/resctrl: Add the test in MAINTAINERS
Thread-Index: AQHUr1tv9/B41hRmakuDO6KWkA8Wkg==
Date:   Fri, 18 Jan 2019 18:27:14 +0000
Message-ID: <20190118182646.16594-11-babu.moger@amd.com>
References: <20190118182646.16594-1-babu.moger@amd.com>
In-Reply-To: <20190118182646.16594-1-babu.moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1737;20:0xmxO0WA1L6tvhkPZAhGYSy1kVnMs1EgBjhib6p6UPyC5PFIySt+NxT1pJmdWsCl6QiRD+1WG9mgr6CR1NiZ7X9K7VGautqgTG7gVRumuxwTcizW0DyFBzIbcsiprnaclvzv0DssOvgOF+8lLb0iCtTc3UFc1I4Mg62GuQRl4k/woqbfZQMky1Y5/uFq0PUtDEJT/crz3qFxYwF8VGJDzgckoZjHmstJ7Nz6/HEQ6Kd4vcLg36yBU+f/PCANhOVw
x-ms-office365-filtering-correlation-id: 3e769b80-8c8a-45ee-c2d2-08d67d72917d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1737;
x-ms-traffictypediagnostic: DM5PR12MB1737:
x-microsoft-antispam-prvs: <DM5PR12MB17370765169A93E78ED92A72959C0@DM5PR12MB1737.namprd12.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(54906003)(50226002)(6512007)(8676002)(6436002)(99286004)(1076003)(110136005)(53936002)(6486002)(7416002)(25786009)(8936002)(36756003)(26005)(4326008)(186003)(81156014)(316002)(6116002)(81166006)(3846002)(6346003)(476003)(71200400001)(105586002)(2616005)(68736007)(2906002)(71190400001)(14454004)(106356001)(486006)(2201001)(14444005)(6506007)(5660300001)(97736004)(102836004)(72206003)(256004)(11346002)(2501003)(7736002)(4744005)(86362001)(52116002)(66066001)(478600001)(305945005)(76176011)(386003)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1737;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p6U/H5nRn5sVttgFuDXsQWnZT1O4NrEfcqD86T7cgf7mzgqPuZQoImYzSHY4TVRoMrEbL46zEox6ifjtZFYjvYx1fiqquSCioyPsGFNc61zda6BOTecoozqdDY4QU7S2OFOmM02Tlf88lnMk8VJbgVvYEhPjyKDcl9GWudmo5b1HMRtn/0Xq2uowfglisC1GhogVkid/safYH+Jksj8yBkT8K1EgfvKhtWEDUGNXdlQhVcsYfhYomT0hx5a+gtDhIdoE3KLuLMkyQyg0yEwVRKqYaMpVIaXUCI+Gzby66sHOUTB6YnitDE0H6eohK0eAt1bK3+Pkmz011V3iSi7pu5HvJEwjuJUVFj5wnU56iHprbEkbs+wHR0aHEKvHAKJp3/rQTRGMT7KUUF7q+FSnjttqBD8a5Kc4rpM1PaGJBTc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e769b80-8c8a-45ee-c2d2-08d67d72917d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 18:27:13.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

The resctrl selftest will be maintained by RDT maintainers.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d44447..16359bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12815,6 +12815,7 @@ S:	Supported
 F:	arch/x86/kernel/cpu/resctrl/
 F:	arch/x86/include/asm/resctrl_sched.h
 F:	Documentation/x86/resctrl*
+F:	tools/testing/selftests/resctrl/
=20
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@linux.ibm.com>
--=20
1.8.3.1

