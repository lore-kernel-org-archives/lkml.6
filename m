Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26A82171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ynZ52DE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfABUWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:22:18 -0500
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:36672
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbfABUWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm1GTEmlNZ1ksnOgauHKTpiGdOit8h8uVP1UGbn4nBQ=;
 b=ynZ52DE2OFBrNMMz4fILlYR1zPBh0Pi+l1LoJxr/dA4of6yGNSkcJzZMKRTer4fJw8TNs01KbBIl8zaSsLuPg8hQtXvGb62nDGgEQu4mp4DTrnhySty1iCxI7illMDt/ThiCr6WZvkqd7h71oxdLMqgcqshZPwMn8jjr6vBWnqk=
Received: from BL0PR12MB2468.namprd12.prod.outlook.com (52.132.11.143) by
 BL0PR12MB2500.namprd12.prod.outlook.com (52.132.11.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 2 Jan 2019 20:22:10 +0000
Received: from BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::a1ce:59b2:803b:9164]) by BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::a1ce:59b2:803b:9164%7]) with mapi id 15.20.1471.019; Wed, 2 Jan 2019
 20:22:10 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/10] selftests/resctrl: Add the test in MAINTAINERS
Thread-Topic: [PATCH v4 10/10] selftests/resctrl: Add the test in MAINTAINERS
Thread-Index: AQHUmYz+cVac1iwhvE+xtgU5I09Pq6Wcfo+A
Date:   Wed, 2 Jan 2019 20:22:10 +0000
Message-ID: <c6a28360-b6fa-9003-8981-a6618ac6a0ff@amd.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
 <1545438038-75107-11-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1545438038-75107-11-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0114.namprd05.prod.outlook.com
 (2603:10b6:803:42::31) To BL0PR12MB2468.namprd12.prod.outlook.com
 (2603:10b6:207:4e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2500;20:BnsE8pa75sPJohPzbMSBt12JXNnBCCax7Uf+Uja/pXVLw7/DYW6EDv4AQY0SWrnlcuX/hJQW0FQF7CaNvA38Q2H5hFdIba+oUbrzgj3fHcz+Zs1U1XhEJ1Dzeb+EO5LTT+oqsVIUxDGV/JugBDrpGBlpL7vyoc99n2ab4m4LM4Gb0npJx2V46aE+Y4wihfgYIH9wLiM1eMmcKzRFgB84ssyQ+0ebHC47fpi5GqfGXJzTIaOsVemAKN2hgUtQ/LFz
x-ms-office365-filtering-correlation-id: 47fb2632-ba4e-42c8-1ddf-08d670eff92a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2500;
x-ms-traffictypediagnostic: BL0PR12MB2500:
x-microsoft-antispam-prvs: <BL0PR12MB2500FA9E70DDD14F3EAC4610958C0@BL0PR12MB2500.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BL0PR12MB2500;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2500;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(13464003)(199004)(189003)(97736004)(4326008)(31696002)(6246003)(6116002)(316002)(31686004)(66066001)(36756003)(86362001)(478600001)(476003)(256004)(76176011)(486006)(72206003)(14444005)(14454004)(71190400001)(26005)(52116002)(25786009)(71200400001)(3846002)(6512007)(53936002)(81166006)(68736007)(305945005)(106356001)(2616005)(8676002)(110136005)(2906002)(7736002)(11346002)(105586002)(446003)(229853002)(102836004)(5660300001)(6436002)(6506007)(53546011)(81156014)(386003)(7416002)(99286004)(186003)(6486002)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2500;H:BL0PR12MB2468.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fpNHC1r2VDRfyUz1pLtzpgOeaITrU7XdSRO622PYECF2hG9IIWrJnsbHTZYfeY57I6K17ovjGcAlsuVAOyWip3Ggp1Ln3ykeKu1T9woF1+iaUuaU2E8t8wwVUhoYjJItfeAnOWp2y5jQhBjHTJKvP63e/1JJQgZ35/x/KTe2UeZ9aIlR/7IFcK8wfgFcszhGZF9OZGfnCfIDKAfbwYkZlXFHfa42jXzxbCP4pI+QQX/a9qHmni6pW9tbdHL13xpVczS5aMKgtiVxjzk1qkC3wyo48DemwkzMROmrRrqgFZClPdhHrTmoCO/sQNLgrmuW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <DA255AFACF5D2343913EDDC2C09ED23F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fb2632-ba4e-42c8-1ddf-08d670eff92a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 20:22:10.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Friday, December 21, 2018 6:21 PM
> To: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; H Peter Anvin <hpa@zytor.com>; Tony Luck
> <tony.luck@intel.com>; Peter Zijlstra <peterz@infradead.org>; Reinette
> Chatre <reinette.chatre@intel.com>; Moger, Babu
> <Babu.Moger@amd.com>; James Morse <james.morse@arm.com>;
> Xiaochen Shen <xiaochen.shen@intel.com>; Ravi V Shankar
> <ravi.v.shankar@intel.com>; Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com>; Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; Fenghua Yu
> <fenghua.yu@intel.com>
> Subject: [PATCH v4 10/10] selftests/resctrl: Add the test in MAINTAINERS
>=20
> The resctrl selftest will be maintained by RDT maintainers.
>=20
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 842b697a1511..edafdecb1e41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12650,6 +12650,7 @@ S:	Supported
>  F:	arch/x86/kernel/cpu/intel_rdt*
>  F:	arch/x86/include/asm/intel_rdt_sched.h
>  F:	Documentation/x86/intel_rdt*

This patch does not apply cleanly.  We have changed the above names from
intel_rdt to resctrl now. You need to re-base again.

> +F:	tools/testing/selftests/resctrl
>=20
>  READ-COPY UPDATE (RCU)
>  M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> --
> 2.19.1

