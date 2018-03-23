Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCWDUY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:20:24 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:26172
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751861AbeCWDUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:20:22 -0400
From: "Kalluru, Sudarsana" <Sudarsana.Kalluru@cavium.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] qed: Use true and false for boolean values
Thread-Topic: [PATCH] qed: Use true and false for boolean values
Thread-Index: AQHTwhmbkuQWxViA6UOVoTB/ne4K3aPdJyOg
Date: Fri, 23 Mar 2018 03:20:20 +0000
Message-ID: <MW2PR07MB41395C591E4F4F436ADF05CD8AA80@MW2PR07MB4139.namprd07.prod.outlook.com>
References: <20180322200849.GA28033@embeddedgus>
In-Reply-To: <20180322200849.GA28033@embeddedgus>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sudarsana.Kalluru@cavium.com;
x-originating-ip: [2402:3a80:503:edf:6902:1e7b:f65c:36ab]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR07MB4028;7:6v1d3dWNELOvCdZPUgBvjdC69dSmzcmK65BODBWiZYTwzOBVvFEhBd+vnc1NFyHNyrvAnsRYM/OHTYzgcn1gDs9X9d54fzPW9RJXyGfiNd9Ez4OYThrtUK/9xv/TFzQikB2PpyeiRLp4XAuWFqUFCzu7GjwdIhvzFJP9I+jaAXy12Oub48A8UOC9he9KuXBjyWqjAWAdVjwWa/Ch/MOfgRIDNslLOVSYPJ6/zxiGpwg9342sJZXn7xZlwKq+KeDS
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 9b1d0030-7724-485f-5d12-08d5906d0219
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR07MB4028;
x-ms-traffictypediagnostic: MW2PR07MB4028:
x-microsoft-antispam-prvs: <MW2PR07MB402862C591F5907834B8A2548AA80@MW2PR07MB4028.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MW2PR07MB4028;BCL:0;PCL:0;RULEID:;SRVR:MW2PR07MB4028;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(13464003)(189003)(199004)(6246003)(2906002)(6506007)(4326008)(5250100002)(53546011)(33656002)(6436002)(53936002)(6116002)(68736007)(59450400001)(55016002)(25786009)(72206003)(9686003)(5660300001)(46003)(105586002)(478600001)(6636002)(110136005)(76176011)(8936002)(81156014)(81166006)(2900100001)(7736002)(99286004)(7696005)(54906003)(316002)(186003)(8676002)(3660700001)(3280700002)(102836004)(229853002)(74316002)(86362001)(305945005)(14454004)(97736004)(106356001)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB4028;H:MW2PR07MB4139.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ylvJ04WOTRFMa3B/sD6j6SQM+hb50V+36qBPH9k+4UCZveK+zVgtHnek9XlVxHGffozVpuxYVCIr30AFAcRkXOsrKQtOejntktH++quOyE1OAXUeSg+XLun98uJ/KlzhnjIf82knDqLSeAbxpZbDMVBjJws4rY0TlyM689N9ui0hxCdjj6UnGYb/qsMcjDecQPS1UiCEdYjR58aTCr26t41lz3x2subyJhY2fT15/3mJdUc8ifh7BbbVS61r38WnCpdBMZJK+V0EQQC2PtCF6HuaGorntb6t0B1m2wR2Xowd2XmgVseqjSHyjmkoqcZw99cp2/LIe5bUTLM+qHCnSQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1d0030-7724-485f-5d12-08d5906d0219
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 03:20:20.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4028
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N3KUSo018573

-----Original Message-----
From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com] 
Sent: 23 March 2018 01:39
To: Elior, Ariel <Ariel.Elior@cavium.com>; Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
Subject: [PATCH] qed: Use true and false for boolean values

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 553a6d1..cdb3eec 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -298,8 +298,8 @@ static void qed_init_qm_params(struct qed_hwfn *p_hwfn)
 	qm_info->start_vport = (u8) RESC_START(p_hwfn, QED_VPORT);
 
 	/* rate limiting and weighted fair queueing are always enabled */
-	qm_info->vport_rl_en = 1;
-	qm_info->vport_wfq_en = 1;
+	qm_info->vport_rl_en = true;
+	qm_info->vport_wfq_en = true;
 
 	/* TC config is different for AH 4 port */
 	four_port = p_hwfn->cdev->num_ports_in_engine == MAX_NUM_PORTS_K2; @@ -1276,9 +1276,9 @@ static int qed_hw_init_common(struct qed_hwfn *p_hwfn,
 
 	if (p_hwfn->mcp_info) {
 		if (p_hwfn->mcp_info->func_info.bandwidth_max)
-			qm_info->pf_rl_en = 1;
+			qm_info->pf_rl_en = true;
 		if (p_hwfn->mcp_info->func_info.bandwidth_min)
-			qm_info->pf_wfq_en = 1;
+			qm_info->pf_wfq_en = true;
 	}
 
 	memset(&params, 0, sizeof(params));
@@ -1630,7 +1630,7 @@ static int qed_vf_start(struct qed_hwfn *p_hwfn,
 		qed_vf_pf_tunnel_param_update(p_hwfn, p_params->p_tunn);
 	}
 
-	p_hwfn->b_int_enabled = 1;
+	p_hwfn->b_int_enabled = true;
 
 	return 0;
 }
--
2.7.4

Acked-by: Sudarsana Kalluru <Sudarsana.Kalluru@cavium.com>
