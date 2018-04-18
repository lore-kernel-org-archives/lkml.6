Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeDRLCi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:02:38 -0400
Received: from mail-bl2nam02on0068.outbound.protection.outlook.com ([104.47.38.68]:43552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751878AbeDRLCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:02:35 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; embeddedor.com; dkim=none (message not signed)
 header.d=none;embeddedor.com; dmarc=permerror action=none
 header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Jose Abreu" <Jose.Abreu@synopsys.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] ASoC: dwc: I2S Controller instance param added
Date: Wed, 18 Apr 2018 16:34:52 +0530
Message-ID: <1524049494-19526-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(346002)(376002)(2980300002)(428003)(189003)(199004)(9170700003)(53416004)(26005)(104016004)(11346002)(486006)(476003)(50466002)(105586002)(446003)(2616005)(426003)(336012)(86362001)(36756003)(97736004)(54906003)(4326008)(47776003)(356003)(16586007)(305945005)(72206003)(316002)(6666003)(39060400002)(8936002)(8676002)(50226002)(81166006)(77096007)(2906002)(109986005)(126002)(51416003)(7696005)(53936002)(1671002)(106466001)(478600001)(5660300001)(186003)(48376002)(76176011)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0323;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:InfoDomainNonexistent;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT048;1:sxm5rBIKVCAL3G83LEvJn2q7fMv84GPGegIdiZ1ABvOvuErp9VtG84cu88HOwrS4gsr+BbqMCiPIIczJ/QDdjVyxxGu9JEoffBNEkO7A2lmR82ARzUOytmZEGWpb2aJu
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR12MB0323;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;3:Gl2L2o7tH3dIL5dN5tUo5toNyZ3bkf7WC2OSmdhi9IrhM8PPErTsP2Y0Abp7o+uaKkIoJnjws1F6pz2xHvkVGUiRKK1sqCie7SRSCKnulUKGvKnUqgpMqcSNFd9I+9jZpiIdz86H3cpqIR04DnOXaKp447cLIJqeaUbMTTc7Yk23lPGmdFEKUoIbGlc2tJ3q5Nb5npjHbAUXMQJp3WtGku3Gt+kMiVmC7g2K8Q3/pJrWCYfy6vSKVlN9sXL4Ktvp2aZ4qrbws3AS50qbgE0VOb0s2/RlouVNxSo1Oo1rkY8umjfPI+CpsnarIEqLGXIiltbrxGTHuNeWDZ9gbvmYa+nBAoFxs0O1YpKw88IxkTM=;25:ZSg8kIKwg/FVbjzG0esUsrBybPm+JKk95SorSth1GeaVONipgsJPQwoMqt3t8JnpahARq4qt2iLgkBNLLz/LRfupmuYZcW2nRLFQH7CBbTdjiH78Nat9xLquLaP3dCHtrv2s8IYFExmv+a7jbi6l11GFjoqs31nqZC51pFI069B9aAaAcluRGZfVF50DDtempogttyzqzST4DR8wkppbCc01FREHM2mFksax+V+491oUAFiDB2DP9ozTld+I5iArq3Uiz4G6i8Dk1Ic/EJ/LJlfCh3FvTIgvNzKNw0pr1aT5HYkeRou0ws3HVsZvi5B5ttXbXKcDOYn27ksX4MPkaylP6QeC4/QU1Iryq2cb7iI=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0323:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;31:WZIlpnhzE4y87ojhAO5MMi1qv3UJ/SuP3fu6pXITfIBr9POu+rWGPmtOc/ZNgm+auwQUa3SI11dC9kBXvejXmcohqjr0RH3Sa2SOVjtJ0gKJeuZBdkb8yB/CPo0dA7Rtx9/SQqA5By7/rB0EkNXDm094VtGvKLGl0fqtHyW5k+WERieP2Rpi/1lB686KX10Bo6whICi/KDBRAlY+z2X7ncpmpj/bfFmC/sgCqxKggLI=;20:Ed9GgACH+JJh1csJO/ef/QKlxfsbDHXGDhOcw0M6awYCaaNyRWEr9N7VammmNVTYkwJNmPMrBQa3Tm/PeMzn/EiwuYzRIjM17bqCAzEJSOjB9sFWmDmPTlV3J66Teke/H9ogULxsCWcap6Uu8ouLBevNYpxX1IHTodHdu/3eZ1n6TIFi/UnbhMTzyMLDIYnwLil9DIdSaIf4vosEgXiAj740/ae7Htony9P1Isc8ek90yseWd/ZU2/Da71kYQLAGP++DaZCmHYplIfrLRMH1pR2DjE9eaSf0xeDwclF4lbhbKlIEYE9rMRbwsPZcrOACBwWIY9Zy9moiplzVg+Bzhy7YQB/mqIwzrdXmB7jQ7rl0UfRKNO8lIVPhUTwbd3kkBYOd6t86TE4CN9epj+DrnhVwqDla4sYU+Jx0o2RwT66HhmtkgZxRIcfL/X/t6rkE6uFDgAg6M31jgyIy713L0hEgppn8GPBPrlUjmRY92SG0uIC5XoAH6x07tjk10ei7
X-Microsoft-Antispam-PRVS: <BY2PR12MB03239330CC2D0A5F598FF9C697B60@BY2PR12MB0323.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0323;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0323;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;4:RTOVRhqmvJch/C8+LHXGgwvb+yBydYdICEP/jvJHIIsDZ8oFq48Vd2JYeFTsWRc4ANrnL+tM/fsrTYDwMmrSCfejOdc7Ggp9zG55T29kSQYNFWvb6y2s1///zdPpwdYl941CjdTmQ/GBRAO4zXgk4zIsPMKVP+DfKpMZqNIaCEb8ECoAModISwHLfpywp0rFpLgIrTXwJSJZ/93oTpk39zYenh61PHLvAPSY4F20eYNJlkDTK8LepfhBOghRQ5CoCfIJKnMiMT2e7k5sNoFfTNhomvOCx90rpU2WddwO2NdmGlwaTZU9AXyY2a8dc689
X-Forefront-PRVS: 06469BCC91
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0323;23:uDgApnqUWoNjpciDwSMQLuHYQrIeq3RAkReWyGSlQ?=
 =?us-ascii?Q?tbdkVoOEXfU9otC8fAJWo2j8k7LHZaY/+qYFURwbOHxgzq7RIkUK8tgGijJr?=
 =?us-ascii?Q?dFM8Wn+SKre4aCU06UEm8FL4ivc6SVRsfPWzbeAbYddopr98iRs23KsDrVHS?=
 =?us-ascii?Q?s7+/1yBs7kyq+Ts/knaeqV05LVp3Fwe8ZU4gJW8x+mqGCqxDG8AjscrZGU7k?=
 =?us-ascii?Q?gw9gyZt9msQndPXz8Td6RTqH1IJzJDb35yrjY9ndvk58GklPFROj+mCsztcE?=
 =?us-ascii?Q?qeMp5M4iE/ef2Fq3qL2eaTCoeOZqvUzBpQp1d8CkHjI7D5TawhuCxeoTvZ4u?=
 =?us-ascii?Q?a6zxZhOWUhwx2w/apvJm9N9e9sUgtnshG7q2uVOhs/QM4MZocmy8p2bjt4ZW?=
 =?us-ascii?Q?BERwAsyuWUSmHTV7gnF9o0/r4o+mbGsPEb1qcsRS84fZ970s9dYIk7M7a4ZM?=
 =?us-ascii?Q?wiNcVujiIRvA1XOXOg229v2Yu3niH2KSweQpgYfihNgVEWJnw6xVPjd4KImR?=
 =?us-ascii?Q?15aG9ZEWMPptB9VopcAXd4vwC5S9UYXUJzjPFOiHpKB5DVkFC+KekhzWZ/9d?=
 =?us-ascii?Q?6oKGPh4nRzMO74ntLV3d6XTp9subijPaKAcjr8p7jLHEX7vX1VeMzgdxC9in?=
 =?us-ascii?Q?S5fdUbuP5r8lvYtYuFZjVedzy0YH74b/PqvOgROe900uYhs46CzUD8Ry7o/C?=
 =?us-ascii?Q?zAkyQ5DSER0gY5nZqpHrNH1LSjk8p6PdrNBmXCbAGDIscIa5g7OGMs/+HaO+?=
 =?us-ascii?Q?/EPDiSCYW/i8H9q+1FANA5LaoUxBmA04FTFGZUV3n48Sd+Akk/85e0Tqqlnk?=
 =?us-ascii?Q?2o8trIBQHWV460wGaf/wUe7Va3nxY2HgODLFVTna5phUo0L8dZ56723PxSsR?=
 =?us-ascii?Q?+qETg7o+meNt7F/gOX3pzvNTmiDYXPB16IDoIAFiOa9azz3hLSe0MUHPhD+J?=
 =?us-ascii?Q?aPbdWg23XgybiIHffB1oa1SoN+3F07hFFiU+WRd7rXH3SYtY1lxgB4htppSg?=
 =?us-ascii?Q?WOc6o1KnfMKBqbriCgy4gx7e27E/rCDzuFV0tw8ViW3bzsv+P2S+xN1ov2BG?=
 =?us-ascii?Q?FKCX5kmjDQ8Yaa2k1xCXVJQkkk+Q9ppTpjd+1J8EVKT6rVxCz3VXlG6NPWH6?=
 =?us-ascii?Q?x6z2Fy1S03lKLmlHoiEBNHlGq85mrW7LOdHNFc3cnEKACh9McAV+v27qkrvn?=
 =?us-ascii?Q?p4Hsmk8Mzo+o3KLYU1yyVcfYkDfcYkfnZuj?=
X-Microsoft-Antispam-Message-Info: YvP6sQjAZqeqsdNltS+BZvCQTZah/zwfVRPutiKIKBEpPogg9H3CFNCzQJWztu13WuNcfJ4Irvps3T6wwAg194L2xND1KllyagcTRtpdRUxjTcK9BwljOA9ZJhMAHQCnnmcpdYSaAQPOZqTzzOD81R5nasHJ9PX5eldINx008tsGLjDMUIBAWZ7uTXwtffL2
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;6:C6ziGFddKSvnO8Bs23zADjDfyL5wLIfDBK3rcJs96EaOErYIeqyuG0PgPa3xERL2Ujn2mXAFrpWCBMz3BORMpKG+uGGW0CGyGpywrUYisd1AYwAKexsJ1UptHlFiG7211R+vAef/5JwlnZ4bNrjnTcTtcjqOK3qyzeDIXuHvwGKz3yjm2S4Iv4chL+UO43xIIArEIgGoK18bO3hmguJ/O0s+cPKw14xSqirZy7HferVhmSTwa8Ekpy2xRCyFTE4aBgIKF++A28T4VwNlzHzKO+boCcOGmRRiH/cBBmocgOSHKZOQbQLazzPPZpoP0p71YtK51jljsgqtuOzMFdJaOlvYPwYF5pZBd0Fzf5BsKxpBruwKvLTGU3L9P1q7v417HMQjWsYhStchRiQkZGgU7I1gvEto4RMssj7YsGmTFjnDx9oWtkyevHWKBAsWIgtzpYrHiX9JYMpYrs3paZDEeQ==;5:C9myi05uLLwY6tUu3FyslNzImc4W1Lu342Q7DNtZ0ckn2HjgsvYVY38EI50v5xUp+LdJhhMTfhO+Ai3DRouCDcMuaGZtXU7adHUZrUYyzZbkRcsHToiJkv0GYBG/aa1l5B0MkYDL+b8jFp4gnigzTbzqeKPMPqWApDtunF8iun8=;24:cSVyyJL2uyUBJobMg8VamjcLMeeUt91IgtNXRfTly8ArJIDHbmqSNMegWnY4OAK/R73/vdMqzuVu3hHFukGLQFDxANqxzRQFnJCYapZ/5go=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0323;7:X+Fm9EZKrwFGniisgxCd7XUXpr/8tnrZOnYmF90wfVtd7GbLX00eTDFxGIKvAj85mx8R4ghKgTyhY/R78CPY3zZp94szhQOWTCtnfAS1DX3aErsemaXGpnvdztlkPgIQMEhiALFtPOXq/DU1qvA3Dfa+jmlneMR9YKNvNsfLeubmZavVZPbLE7VQv4YF/NA/oy83tqNtHb8DGe53sxolbM04F15u8i/7izbB5T6RLtJFknYfcoYV6AKJ8J6be1tm;20:/vj1WGP0gpEJy8n/MgcfLj8xNM7SmsY038174Ar5bsFuRpJWZoeWZumOAavWd134grTeMifY59FGysR/EdfzI0LSPOHWJh3J2J1HdWyzsXxWUhRNfF0A69WMON/d6OIT3/Yexe0u4qeSCA5LX0zAy48rd+pHHe/iIFgyyhhlg4lDyW+eJXNIOn59u5zZO6FJ0kRnbq6n5SMy+p0iirWsoeEWsvWS/eTl5AXZtjFaexF0Vu6w4Hu9fm2Ra8FVr+er
X-MS-Office365-Filtering-Correlation-Id: 92378f35-6ae0-43da-6641-08d5a51be26a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 11:02:32.2398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92378f35-6ae0-43da-6641-08d5a51be26a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0323
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple I2S controller instances created,
i2s_instance parameter refers to i2s controller instance value.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 v1->v2: removed acp dma driver specific macros from dwc header file
 include/sound/designware_i2s.h | 4 ++++
 sound/soc/dwc/dwc-i2s.c        | 1 +
 sound/soc/dwc/local.h          | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 830f5ca..2a94e7c 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -44,6 +44,10 @@ struct i2s_platform_data {
 	int channel;
 	u32 snd_fmts;
 	u32 snd_rates;
+	/* i2s_instance parameter returns I2S controller instance value
+	 * when multiple I2S controllers instantiated
+	 */
+	u32 i2s_instance;
 
 	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
 	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 65112b9..58f81a4 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -553,6 +553,7 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev *dev,
 
 	if (dev->quirks & DW_I2S_QUIRK_16BIT_IDX_OVERRIDE)
 		idx = 1;
+	dev->i2s_instance = pdata->i2s_instance;
 	/* Set DMA slaves info */
 	dev->play_dma_data.pd.data = pdata->play_dma_data;
 	dev->capture_dma_data.pd.data = pdata->capture_dma_data;
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index 91dc70a..e89e464 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -98,6 +98,7 @@ struct dw_i2s_dev {
 	u32 ccr;
 	u32 xfer_resolution;
 	u32 fifo_th;
+	u32 i2s_instance;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
-- 
2.7.4
