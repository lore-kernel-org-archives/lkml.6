Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235114-2-7890350778079908451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235114; b=uHKra2v/2/NnyGNBorZX+Ur6+/JcP/5WAG1AFoSGNPq4dylzIh
    qDXaynFR9TVDD0hjGaNWjQt48IvnYyacHknyClEiLmQsmqHJp31EOuoT7HYTs8Oh
    O6O9DCX0rRL6Lno05cnsYAELvpLORg8j3gktwpgg/MmrF3X7PEqDZ64L5ttRvwNP
    EHwD4jwQScK6Kps3eqW/uY+9j/+jHxl9I+bh99E5fB/lDAzB0tktrp4DQ0a4R9d4
    ibFEnRejzv6o6u2ZivFD8KBm6Tk/2R/vF0zlh+6t7m5S87ZT38n5PtpRRR5b2NQV
    Hninnw+3bQwldo5JZ9+Yrf6UozDCVJvcTykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235114; bh=X2OrlsXDi1
    ktWdHZG615MA/4yZoJCMNhGeMrUYLVKUs=; b=SqJvybzP2L3NljIe5WuFoJtre+
    gaSX1VkIc9J5eziK6VlcGblxxvSGnTlQ37H930N3exBgzO3ivpR6Tgvx5rmxJ8m1
    g1pg6BkWJvsRIv8R3A7NH7S+bmCir144wGn3ljjbDd3dBmyFaJ5/dLznA1U9mVYf
    4+auAwZMTtKjtWz7LZTeyErA2sG9dLV5s28aAbABQLyh4KywYAP8VFP4zEtFcZeU
    T8qdrLYHX6gmjBqmouj/1jQOwboT5A/j4gm3E9GRIybqTcn8Cq9hPr+avsz4UY7H
    reV+9njBl7ysUxzhqsRLMsJd595NGcNvWjPjvhwFOX1A7nafEn36cy9f43sg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TPZLCI2s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TPZLCI2s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIYyG64BQMSsN4H/mVM9FtyLf+fOsm2ReyVj5uitUGvIA29h0v6wYi8ZktJUZLpiqYwjNRwMrp/ObjAedRmusaS3jQiHqd7QGqtfd7T38KSYXX5u7ze9
    Dcr6Jv/7POiBSQavNTsfiDWsV72TiOsBW/lMxnf2iZdm+fhIPSnwiwgLSzuaudUpPxSwFwktGO8WxKqdzY5qLhScBjjR5AhWwI5Pik0pS8OCsEA/ibqJguuE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=i6SHCG24PLcwl-ztjlgA:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeDIAvj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:51:39 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933438AbeDIAl2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 062/101] irqchip/gic-v3: Honor forced
 affinity setting
Thread-Topic: [PATCH AUTOSEL for 3.18 062/101] irqchip/gic-v3: Honor forced
 affinity setting
Thread-Index: AQHTz5t9p+EqG0em606OGWzSfzgagA==
Date: Mon, 9 Apr 2018 00:41:25 +0000
Message-ID: <20180409004042.164920-12-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:cZY1+0TTOEUwZlC7aHMKvz6dOwp/x0Pg7vfnqk2RDdTrH3CP0czHTuS6GDEAviubQzyEVa5xFUV54ASMBr9rB1ZXO1+lhpTKgkeOuF2tGA+bHhxOgguSs8LX1b92RU5yyKeXSx2A7g19aR1sd5LXYjMZc5MfPZq45mw/W3fHddmjLmYh8ExZY4sLqWpnKh2BfKTomWnjBkZNUzMkrB2xCyvCVRv4y/i/DG7JITcwSw7Rm6gzoHfK+sXBI3ZYJTkt;20:HWwh3qeuyuDzkd50L4r5jqhSszGB0Gw7HbJUenkLaYBL0Aoj0Wlzwq19zchkpQkTBdMJ1JGTM5BBZm/RrFIQEusHgbUuHw5Lydq3h5QHaRartKhmtWowrlXxvo6Q99Kvwma6bByCr4ojRNgPvxTEIyE/+/+/9Jyf+//Jc5hDivc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b45a5ab2-6201-46e4-e994-08d59db2a004
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901F6118C05A78821AD961AFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(209352067349851);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hqNzETv47ACXSLLMHhZ1ZtuzPHqiLZNKV29dWhUYwi0tC2KdMZPHCMMDRs2NRXzPL7j7HZWWg7+5jsQLBBTWtINVZHfMw6qRDmgfph/bAzlbWHraaqRbs2SnAxKj8RjyWvyhgOwrkOs8RYHX6Uxy1j5/SgAfzq8BGn8eDFoK9fywzTF+X/cQTobWHnjhdpRfhTmyKRfBDjNmhAFKnJ0s2OXINOmluvtPKJcexYKt/FulqsUaOamNCqpk5hUIZCIoBEh5y/tQNVYpq2y4J60QlGsn5uIpovcj8xoW8/QRB6xNlqLAM10EWhMpFtBpSeqIaxB2vnP2GhedvBJSiqOmK1gwuJ7ALI+1/w47Yr6mrjhUPDUvKr7RfZ7lybE/CCRhS2e0nuQJH2gv0U8pbBHMVNBNZXVBmhP71KyYdivLSfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45a5ab2-6201-46e4-e994-08d59db2a004
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:25.2365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 65a30f8b300107266f316d550f060ccc186201a3 ]

Honor the 'force' flag for set_affinity, by selecting a CPU
from the given mask (which may not be reported "online" by
the cpu_online_mask). Some drivers, like ARM PMU, rely on it.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 30b93dd1e612..ec8468829aef 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -526,11 +526,16 @@ static void gic_smp_init(void)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask=
_val,
 			    bool force)
 {
-	unsigned int cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
+	unsigned int cpu;
 	void __iomem *reg;
 	int enabled;
 	u64 val;
=20
+	if (force)
+		cpu =3D cpumask_first(mask_val);
+	else
+		cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
+
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
--=20
2.15.1
