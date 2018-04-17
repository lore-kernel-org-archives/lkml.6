Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AIpwx48Mg1Qy1mnCSgojUQ+psIRMVXLdDlJA95NpHbXFCzr8YCeuZ4n4mCXjRIpbLR/OUvQHxs0M
ARC-Seal: i=1; a=rsa-sha256; t=1523941115; cv=none;
        d=google.com; s=arc-20160816;
        b=RKE7rW3cZU0SijJE5AIUOZq97mHiDMLf/ONCaUTSy2lYngOGRkXL/IyN3tG6Xq3ho+
         72z38Sx4iFfomCAHvXoadgVp41+EnGs5jQX3c2mOqgVzazgA1OgXN6JIxVACIdkEwEIJ
         o/R1Ujbjs72IeGnmpGVtiVPnPBTJgkG38hPZaytseyFWacUWoCD4r/IGzlE1pFidIZ7a
         RTanyyAPeAa59Lohp59LYclbvrjwlq+rTfoio8SbYIRReRY5XamnOktfI8eR8fsnkUUr
         /8bZmbX8ymDcBjj+BSEWPulqGW0wHa4/FCa/FugzxV6Gny3LkPyNv5lDrr08JmkF7WV+
         V3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=5tLJqTfSlV2e1hcHlC4nl+CRn09tnm3e3fbxC+IZOcY=;
        b=lEXbt7uf0DL/sEJYQPrm7Y2RBbkbp+xhw0Bgw0xO7uu9yLXLnEj6JlnR43RNbyzQSn
         0Rl6GMdWYY/47pef7TiePrEvbhyIEHiM7JOl8VHTOqxLMxvLkG4wtebmyqamFvUjzLxB
         Bwnxbqfqm1RINuAuA6pmnNYuu8PUFWemYWICpvUnF1bz3EcJ8sNMTYz2a2srA5E3A2P/
         a+2U6NqzLXunnkORpj80PJDsDS+f8SW76gP4eZ+qP1PwhZ9hRf5oPa7w2kE8pvkmDBB3
         CzS0XeMV94z1JsbiLNs9/4bo0ea3TimUPnALWad4I0qfnoBkOQo0JLRDyQnbEQundrdF
         RPhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=RXA/2b2/;
       spf=neutral (google.com: 104.47.33.47 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=RXA/2b2/;
       spf=neutral (google.com: 104.47.33.47 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: 
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher
	<alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, "Jason
 Clinton" <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: amd: fixed checkpatch pl warnings
Date: Tue, 17 Apr 2018 10:29:52 +0530
Message-ID: <1523941201-15665-3-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1523941201-15665-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(376002)(39860400002)(2980300002)(428003)(189003)(199004)(86362001)(109986005)(1671002)(50466002)(105586002)(72206003)(104016004)(53416004)(53936002)(446003)(478600001)(336012)(316002)(26005)(5660300001)(11346002)(48376002)(426003)(7416002)(16586007)(77096007)(186003)(106466001)(47776003)(2906002)(51416003)(36756003)(7696005)(76176011)(486006)(59450400001)(476003)(6666003)(126002)(54906003)(2616005)(305945005)(39060400002)(4326008)(8936002)(81156014)(68736007)(50226002)(97736004)(81166006)(8676002)(356003)(266003)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0755;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT029;1:gV6WsFW3MbdZ89FkUR6iVWbqU23hFWnWBdXDty19JEt/WiDOUijz21a/pPqHZiPobEehk4Z16hRvCxtAyeWMp7TTD94AI1ewb69H1EPNPCFGOR/UBPBnhEwXPkmo/OSe
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN4PR12MB0755;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0755;3:HYz2TpHF7XDniXeSphYrPbnQy+V6aPLXXwyXoBEdgj6AMry5KlrxmrK37r9f/HscN4upI3JGZ+0DBUeHMro+yTSo2P6GlufQZGTkgNiV7JUdTnsLAav8bdnMrcKUJx5+Z1RxtMeO/PycW643ysX8MONTS8v1cos339SJ8VBLpnurlnwPaP3XeqnsHGiO/G/1qCYvW4gRCb5ko3AeFlmaCccOoKkvkHTQjrqQ6Z7S2fkdjzguJNtCs0tWFKxqyRELhF6gO6tHlSpnTbUo6JYLwbrdbgPGm/BmKLoVuLaaJ4kM4bvugFCEoEQI1ZzyMJsNvF7IORpvli2RVIXeGcx0wy1egakRcLIYFSitS8HxC/U=;25:zdn78m1aBFSTgAuZHlFghJjgR3kb+62eLUsLKXEEe17+P+NCgcANELMStHxAQxqgikzKZ+DobtNgzTAd/PDT4Wsmyg83eUeZygeG9ULy4IqraWfElZQLCK8HD1IOE6kywWohxpQiIjJBhPVf720pagKgop1icyemD0EbIPous5d6o1S7KjjBAP86xukh/UvN52OqRUMRUXl6MBOTYSXgz5fZsh/0ETn9EsOndgBodekukFCKugy8TAtDvFe1tcvvSyGdzy3jvnVBSoLvmW2pQpqMOhS9z2UMFHR2jnErrZFLfXabeFfTcLtgpbFeiN90VaPPTWpfoKM5Nl/wzfI4mQ==
X-MS-TrafficTypeDiagnostic: BN4PR12MB0755:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0755;31:wC3tHGR6jklt3p1o1i3dK7RqG4C4kFoGE1gls2f5eCt4Whqt/X/ScihJ1NeaOmleNLNPBo6a7VoR0WyN1ExCc9Y62EZimNnEEDiw6HhDNL2RckiKVLmVpIgEykU/uhbdQvYXowAkhIkej9RUqXeSupEWl/lF8Z6TuvV8IkK+F69m/l5UfBAJa8xygWJYFrd7wL67zGADHzGmJoCzdNVNuKA4wb5jSPzx/g2KD/rYvYw=;20:Dgq2wKS42S0Ex/V06gaZetJ2/WFac2t2CcGfe9UGuJS6w1e/znvF8YLnjTAydADyQz6e4N/IX30VLoiLkTe5EDpw4aYpYA4p5ETFO8oQ4ufWTj4WsyMKSlsDSwP1I9KQ65SysNbLtJz398tEtwXszmLLD/FIUCetMpgdFJM/P66opPhuh2B9yfqMeKIWUw5xjmyPPmW8U/HKJ5itb1yy+L0pr/CI+OrKl1PCU243tDNHdVfQNndF9YAUMIBGZ5KRi/L869SJa8F9SbaEMLjIAS9y5PpYwbPhmoWACsN6rx/ffaqrJB3JOs8AJcPQgSOVUoc32iQdJ+2PirApaCupNXJNd08ghPwIB1GYdLeQ/kFHp7GovdN2h/gNczBhfrv3sXogBp29RnCpig2zbH+0wR9Ku06AETJuWK2XHXLYOGTS7pcaCEP+fGNQD4e9MBwCmIrTdlCEtJlOnEvJN8UKhctA+DUoNOaEGLd1rM4ClKtzmqOcjDclSyg7IgFetTFT
X-Microsoft-Antispam-PRVS: <BN4PR12MB07558C0F2537D64BAFD1B90A97B70@BN4PR12MB0755.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93003095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN4PR12MB0755;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0755;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0755;4:FpfNtAvQA76bxEvcO7kSWfUwrHxFhegAX9LW97ooLSaRBfNUJWGQ3Kq+2ruQHd6SagusXUdMFNVEMWnrn4ZntGjTVV0reKzx/8XhYB77aG90IcK8YmB68zVfmJ8NNUN+nTPNolmka2eXPaLqx852CvaiATmXzZGYyHFtsh3DO9eC+W4Aor6dAxKtxP85eZJCfmdSuEhjxdl9co1ZttNj+IgHBw2ZlRI3KvWwMdMLFNITv2GPYrBnRD9hrEDHQLlnHyBHlfCPalrqlNuBOvzECfP6rTTePgjD7UilY/ZT2ZSlpYSr2TEe8faUYRzhFrSb
X-Forefront-PRVS: 0645BEB7AA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR12MB0755;23:MUAJmC0at2Ts/8/ONpwfIzn+tuKYmp/zQ1ljFFug+?=
 =?us-ascii?Q?xjlp/AUeVxphzbP1A+YKdTe+OChMJnU0flPgf3d19VcHvz5LAVMLDJX6lr1p?=
 =?us-ascii?Q?L4kqcaanbh3bPLn8vtQYRsGmy+qqQyxH1tUg2ENFCjBLcAaF48hxeODUrb0U?=
 =?us-ascii?Q?5u/Urzef1D/udIE+deK50xHHp22Wg6ZwgrD6FanoPlbH71JiF4wVfK7Y1GK/?=
 =?us-ascii?Q?30L0h22R9wsd5q/TuLFdz6pO5kGDu1hb3IOUZLxAdphPPlEjpJ7nNiWoNqbe?=
 =?us-ascii?Q?N0qeifqSs4BYTUlJn1S0lZaGx6b8tauBhsAavdZ+6IOjaMEz2OiIhVNVcmiz?=
 =?us-ascii?Q?fVn6NNodpkXQP09E9+Ysj6M/YCoWLMlcVR50TODQDXmNuWLtZv+WFQuRM0fI?=
 =?us-ascii?Q?lN0rPRlScSlPNPdWJR9LYp6YqHJAeOlWqungsV8DUuFW9fpMkorkZKVN0wqF?=
 =?us-ascii?Q?zwtHyv8g6Ifkq01KbDZ/gNvWcJxZIa2keo1PMjAXdPKmejXzrMJ+u1BHJZQ3?=
 =?us-ascii?Q?irx3ZYyLIfeV56JKBlhXPdozUkW/rL6qsV9WjcwKQ4G/QgKUQkDpAjTjuiHK?=
 =?us-ascii?Q?0UMiFMM86bgMTrqFrXUD4EHi8FxkBAzDFxMrmAn+SJTeXiWG12U4N/nhxtEB?=
 =?us-ascii?Q?DcjC6OCXExX0iaNoBpDpRFH+Mpv5c2xgO6zjGdwNK/BuArKQDJi5igQCLnOH?=
 =?us-ascii?Q?Vt1VrubS+b60GmstdntkjmL4pqzCm4MK09TnUDeQvEp9ai3R3HDEhp67vtjW?=
 =?us-ascii?Q?P1qUmqRM/XtL1Uecot1t+XNNmbPwyqGbcQlhq+O3x5I2QtawNGyXfo3wOq19?=
 =?us-ascii?Q?N3P4/ekN5IC0dMN56tRyWc873xoDQ2t6ms0vbqLWhSosnAP/KA5LpH464T/r?=
 =?us-ascii?Q?hYg/zNMdn2mTEb4xyc8QrdnYb8I9/cxRLwgUo10BFQxaPwsZAPun16aD4ywx?=
 =?us-ascii?Q?mkqYV5M7yazbJndpG/vHL0n70YBlxv5CigpUyZhTBrLpdtse1JQ/Ek++LmDv?=
 =?us-ascii?Q?90YDlTj9ULq4DgiRXxZZCprSZI8O2Q7I463BL1JK/Z3Ccr6zo/7Mc6EnWnnL?=
 =?us-ascii?Q?ISIBweXWbogE0cIDSQ5fGluhzSa7r3PZUhu9ln3k15cwfBlsikMFmtLgDiee?=
 =?us-ascii?Q?53G2QDbPDZiECFvlsloJuwG73dLS2Xv97UdDU+zcPiXMhr0iMXZAKokE2L+n?=
 =?us-ascii?Q?neWwnIePFfN9Ti2ew4t4n3GpVgIQe0+9jZ+9UPdUvl82bV6XnPwiw9HmKO4e?=
 =?us-ascii?Q?Dz09BhUvn7tqN2gJPWLiUqoju6x6TpDWRbr1RVgJKT/as8WF4cJ3cd2laQJq?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: A+tPQlkwCLEBCMNeFUxj8aJO2SJCPR44XVqknGJLP3fuGRd6ztVqCdaq8WA+Lk6Wu6y0+0qw38oc9VaXacSaEZrpmda4xlfEjzyt9SuQ/qyZmATXiwj7yzYFByUWcwnKWJOa9KSj1UVDWZIMK6E1qfFlqeTxKCV1Vut92dJy9Vp5Ja3gVZ18HPC00j8f+h1h
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0755;6:avZA7JqBouzeVBfJc2iicdzVnAaZ82s8a1ZvJx6ZUjI630EBvLnfsa0ofy1m8WJcxpk+/3HHK92Ie4NNwz3XJ79lpNwyJ4Te6+FygaiCoxhEbbi010EQX+5ivDeDHChr9J5fiq6NigBZ86ThB3l2Cdw2aapYgWKfINWIjzQi4otDO2ypL5kW0cMyk9HPKpFOlf3pOddQ2+YNY7GqzpipX51XFBcY28yOw33SVgfTQWzptH7E0VIBROYThEazUK5MEEdHnezjgM1pCfNJhOy8ret/N6mbk5E1jMzDq9bEVVQGdymwQc+49DaaUFE1zpBGhgY4xTPeLYhLtW49aUMdqW2jBVQDp8ZzEA408BM992K+2H3G4/1BKWEVUDTtKeIXgkR7EBCbznS0fTr/4y5gupE4pH+ORn1TU+6yLGwHSOfAZm/w+CmOPKvqqZavws/9LKQsucMjj7CsnIpEofuvKQ==;5:LsNHAbau0x//YtaESsIjm+T428yNlvR5nmKH3UzQX5mXP38niNOt5hE1XnH3Rsr9fy7JqCWmVPw85gAkd4F+LmBdwZxLegHe3yJU825hrCFGhCPxKTeQnqu23+qMLR2rPG6F4PGwG0vVo+7rbdVBPTEnIY9xEzAbOWzO/s6ewTU=;24:9p4s4AU00CwSFEUOvkx/TgHD8viOuh04l5PNVPOydkqPfGr09wCtPR4jl35g6o3/ko/1BlcXzx9qHMzYU9YtnxU0fWfm1znqFn9unrxWQX4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0755;7:14xCTxOhoey41m8fhvm6R1I716b4ZE1BeSwJTyavBCwJoTVdoFv989YMw2y2nTnesJ24eg86f8RRXyDeOVrBZecpYS38OCoz9upVfk9G1VjZRZNTomU+O67t59VE5Pe9tdatlKDht5xUdVCpnMJllQVb9FRMT06evvj8oEl2b8pr3DFfTS4X+3fQGKPRIS4sCgnCO30Wuu3wXJx9scY6zkhT3Mrn9yiRB7NtlJKjCt7srOqoPKlcb7Hkgf4hP1oD;20:9s+W5KQcBB/ZoVm/lHN6Eb9zKMwj07Is+EAp6FZxvzPYEFsjf3Z5RmTChLag5xpWqjL7NUZHoUaCBlpWnBxKnMfVjALCUX7BtfHw8DACWRf05/eF1ujL3vpEKZFClwVUDYBRxRD1zVa5rS6SAAzsa9S4NMup27l33/8+PkCuQJnKSCP5gzb2o7evriL2YQ9chfV2pbCoqQmyazmsGfqTh/7YlU1wjtbvOuyeqVXLjd7QHWrMYjNOnMf7E6v2oj1E
X-MS-Office365-Filtering-Correlation-Id: 0f541d4a-8d5d-4367-d63c-08d5a41fdd79
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 04:58:30.3702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f541d4a-8d5d-4367-d63c-08d5a41fdd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0755
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968078640223451?=
X-GMAIL-MSGID: =?utf-8?q?1597968078640223451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

fixed checkpatch pl warnings.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 259 ++++++++++++++++++++++++--------------------
 sound/soc/amd/acp.h         |  22 ++--
 2 files changed, 153 insertions(+), 128 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 540088d..5ffe2ef 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -130,7 +130,8 @@ static void acp_reg_write(u32 val, void __iomem *acp_mmio, u32 reg)
 	writel(val, acp_mmio + (reg * 4));
 }
 
-/* Configure a given dma channel parameters - enable/disable,
+/*
+ * Configure a given dma channel parameters - enable/disable,
  * number of descriptors, priority
  */
 static void config_acp_dma_channel(void __iomem *acp_mmio, u8 ch_num,
@@ -149,11 +150,12 @@ static void config_acp_dma_channel(void __iomem *acp_mmio, u8 ch_num,
 			& dscr_strt_idx),
 			acp_mmio, mmACP_DMA_DSCR_STRT_IDX_0 + ch_num);
 
-	/* program a DMA channel with the number of descriptors to be
+	/*
+	 * program a DMA channel with the number of descriptors to be
 	 * processed in the transfer
-	*/
+	 */
 	acp_reg_write(ACP_DMA_DSCR_CNT_0__DMAChDscrCnt_MASK & num_dscrs,
-		acp_mmio, mmACP_DMA_DSCR_CNT_0 + ch_num);
+		      acp_mmio, mmACP_DMA_DSCR_CNT_0 + ch_num);
 
 	/* set DMA channel priority */
 	acp_reg_write(priority_level, acp_mmio, mmACP_DMA_PRIO_0 + ch_num);
@@ -180,13 +182,15 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
 	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 }
 
-/* Initialize the DMA descriptor information for transfer between
+/*
+ * Initialize the DMA descriptor information for transfer between
  * system memory <-> ACP SRAM
  */
 static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
-					u32 size, int direction, u32 pte_offset,
-					u16 ch, u32 sram_bank,
-					u16 dma_dscr_idx, u32 asic_type)
+					   u32 size, int direction,
+					   u32 pte_offset, u16 ch,
+					   u32 sram_bank, u16 dma_dscr_idx,
+					   u32 asic_type)
 {
 	u16 i;
 	acp_dma_dscr_transfer_t dmadscr[NUM_DSCRS_PER_CHANNEL];
@@ -195,58 +199,58 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 		dmadscr[i].xfer_val = 0;
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			dma_dscr_idx = dma_dscr_idx + i;
-			dmadscr[i].dest = sram_bank + (i * (size/2));
+			dmadscr[i].dest = sram_bank + (i * (size / 2));
 			dmadscr[i].src = ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS
-				+ (pte_offset * SZ_4K) + (i * (size/2));
+				+ (pte_offset * SZ_4K) + (i * (size / 2));
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
-				(ACP_DMA_ATTRIBUTES_DAGB_GARLIC_TO_SHAREDMEM  << 16) |
+				(ACP_DMA_ATTR_DAGB_GARLIC_TO_SHAREDMEM  << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
-				(ACP_DMA_ATTRIBUTES_DAGB_ONION_TO_SHAREDMEM  << 16) |
+				(ACP_DMA_ATTR_DAGB_ONION_TO_SHAREDMEM  << 16) |
 				(size / 2);
 			}
 		} else {
 			dma_dscr_idx = dma_dscr_idx + i;
-			dmadscr[i].src = sram_bank + (i * (size/2));
+			dmadscr[i].src = sram_bank + (i * (size / 2));
 			dmadscr[i].dest =
 			ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS +
-			(pte_offset * SZ_4K) + (i * (size/2));
+			(pte_offset * SZ_4K) + (i * (size / 2));
 			switch (asic_type) {
 			case CHIP_STONEY:
 				dmadscr[i].xfer_val |=
 				BIT(22) |
-				(ACP_DMA_ATTRIBUTES_SHARED_MEM_TO_DAGB_GARLIC << 16) |
+				(ACP_DMA_ATTR_SHARED_MEM_TO_DAGB_GARLIC << 16) |
 				(size / 2);
 				break;
 			default:
 				dmadscr[i].xfer_val |=
 				BIT(22) |
-				(ACP_DMA_ATTRIBUTES_SHAREDMEM_TO_DAGB_ONION << 16) |
+				(ACP_DMA_ATTR_SHAREDMEM_TO_DAGB_ONION << 16) |
 				(size / 2);
 			}
 		}
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
-						&dmadscr[i]);
+					      &dmadscr[i]);
 	}
 	config_acp_dma_channel(acp_mmio, ch,
-				dma_dscr_idx - 1,
-				NUM_DSCRS_PER_CHANNEL,
-				ACP_DMA_PRIORITY_LEVEL_NORMAL);
+			       dma_dscr_idx - 1,
+			       NUM_DSCRS_PER_CHANNEL,
+			       ACP_DMA_PRIORITY_LEVEL_NORMAL);
 }
 
-/* Initialize the DMA descriptor information for transfer between
+/*
+ * Initialize the DMA descriptor information for transfer between
  * ACP SRAM <-> I2S
  */
 static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
-						int direction, u32 sram_bank,
-						u16 destination, u16 ch,
-						u16 dma_dscr_idx, u32 asic_type)
+					   int direction, u32 sram_bank,
+					   u16 destination, u16 ch,
+					   u16 dma_dscr_idx, u32 asic_type)
 {
-
 	u16 i;
 	acp_dma_dscr_transfer_t dmadscr[NUM_DSCRS_PER_CHANNEL];
 
@@ -254,7 +258,7 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 		dmadscr[i].xfer_val = 0;
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			dma_dscr_idx = dma_dscr_idx + i;
-			dmadscr[i].src = sram_bank  + (i * (size/2));
+			dmadscr[i].src = sram_bank  + (i * (size / 2));
 			/* dmadscr[i].dest is unused by hardware. */
 			dmadscr[i].dest = 0;
 			dmadscr[i].xfer_val |= BIT(22) | (destination << 16) |
@@ -269,12 +273,12 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 				(destination << 16) | (size / 2);
 		}
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
-						&dmadscr[i]);
+					      &dmadscr[i]);
 	}
 	/* Configure the DMA channel with the above descriptore */
 	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
-				NUM_DSCRS_PER_CHANNEL,
-				ACP_DMA_PRIORITY_LEVEL_NORMAL);
+			       NUM_DSCRS_PER_CHANNEL,
+			       ACP_DMA_PRIORITY_LEVEL_NORMAL);
 }
 
 /* Create page table entries in ACP SRAM for the allocated memory */
@@ -291,7 +295,7 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 	for (page_idx = 0; page_idx < (num_of_pages); page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8)),
-			acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
+			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 		addr = page_to_phys(pg);
 
 		low = lower_32_bits(addr);
@@ -301,7 +305,7 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 
 		/* Load the High address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8) + 4),
-			acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
+			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
 
 		/* page enable in ACP */
 		high |= BIT(31);
@@ -313,8 +317,8 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			struct audio_substream_data *audio_config,
-			u32 asic_type)
+			   struct audio_substream_data *audio_config,
+			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
 	u16 ch1, ch2, destination, dma_dscr_idx;
@@ -341,7 +345,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
 	}
 
 	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
-			pte_offset);
+		       pte_offset);
 	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
 	else
@@ -349,8 +353,8 @@ static void config_acp_dma(void __iomem *acp_mmio,
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset,
-					ch1, sram_bank, dma_dscr_idx, asic_type);
+				       audio_config->direction, pte_offset, ch1,
+				       sram_bank, dma_dscr_idx, asic_type);
 
 	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
@@ -358,14 +362,14 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-					audio_config->direction, sram_bank,
-					destination, ch2, dma_dscr_idx,
-					asic_type);
+				       audio_config->direction, sram_bank,
+				       destination, ch2, dma_dscr_idx,
+				       asic_type);
 }
 
 /* Start a given DMA channel transfer */
 static void acp_dma_start(void __iomem *acp_mmio,
-			 u16 ch_num, bool is_circular)
+			  u16 ch_num, bool is_circular)
 {
 	u32 dma_ctrl;
 
@@ -375,7 +379,8 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	/* Invalidating the DAGB cache */
 	acp_reg_write(1, acp_mmio, mmACP_DAGB_ATU_CTRL);
 
-	/* configure the DMA channel and start the DMA transfer
+	/*
+	 * configure the DMA channel and start the DMA transfer
 	 * set dmachrun bit to start the transfer and enable the
 	 * interrupt on completion of the dma transfer
 	 */
@@ -410,9 +415,10 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 
 	dma_ctrl = acp_reg_read(acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 
-	/* clear the dma control register fields before writing zero
+	/*
+	 * clear the dma control register fields before writing zero
 	 * in reset bit
-	*/
+	 */
 	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRun_MASK;
 	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 
@@ -420,9 +426,10 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 	dma_ch_sts = acp_reg_read(acp_mmio, mmACP_DMA_CH_STS);
 
 	if (dma_ch_sts & BIT(ch_num)) {
-		/* set the reset bit for this channel to stop the dma
-		*  transfer
-		*/
+		/*
+		 * set the reset bit for this channel to stop the dma
+		 *  transfer
+		 */
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChRst_MASK;
 		acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
 	}
@@ -431,13 +438,14 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 	while (true) {
 		dma_ch_sts = acp_reg_read(acp_mmio, mmACP_DMA_CH_STS);
 		if (!(dma_ch_sts & BIT(ch_num))) {
-			/* clear the reset flag after successfully stopping
-			* the dma transfer and break from the loop
-			*/
+			/*
+			 * clear the reset flag after successfully stopping
+			 * the dma transfer and break from the loop
+			 */
 			dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRst_MASK;
 
 			acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0
-								+ ch_num);
+				      + ch_num);
 			break;
 		}
 		if (--count == 0) {
@@ -450,7 +458,7 @@ static int acp_dma_stop(void __iomem *acp_mmio, u8 ch_num)
 }
 
 static void acp_set_sram_bank_state(void __iomem *acp_mmio, u16 bank,
-					bool power_on)
+				    bool power_on)
 {
 	u32 val, req_reg, sts_reg, sts_reg_mask;
 	u32 loops = 1000;
@@ -530,7 +538,7 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 
 	while (true) {
 		val = acp_reg_read(acp_mmio, mmACP_STATUS);
-		if (val & (u32) 0x1)
+		if (val & (u32)0x1)
 			break;
 		if (--count == 0) {
 			pr_err("Failed to reset ACP\n");
@@ -546,11 +554,11 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 
 	/* initiailize Onion control DAGB register */
 	acp_reg_write(ACP_ONION_CNTL_DEFAULT, acp_mmio,
-			mmACP_AXI2DAGB_ONION_CNTL);
+		      mmACP_AXI2DAGB_ONION_CNTL);
 
 	/* initiailize Garlic control DAGB registers */
 	acp_reg_write(ACP_GARLIC_CNTL_DEFAULT, acp_mmio,
-			mmACP_AXI2DAGB_GARLIC_CNTL);
+		      mmACP_AXI2DAGB_GARLIC_CNTL);
 
 	sram_pte_offset = ACP_DAGB_GRP_SRAM_BASE_ADDRESS |
 			ACP_DAGB_BASE_ADDR_GRP_1__AXI2DAGBSnoopSel_MASK |
@@ -558,17 +566,18 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 			ACP_DAGB_BASE_ADDR_GRP_1__AXI2DAGBGrpEnable_MASK;
 	acp_reg_write(sram_pte_offset,  acp_mmio, mmACP_DAGB_BASE_ADDR_GRP_1);
 	acp_reg_write(ACP_PAGE_SIZE_4K_ENABLE, acp_mmio,
-			mmACP_DAGB_PAGE_SIZE_GRP_1);
+		      mmACP_DAGB_PAGE_SIZE_GRP_1);
 
 	acp_reg_write(ACP_SRAM_BASE_ADDRESS, acp_mmio,
-			mmACP_DMA_DESC_BASE_ADDR);
+		      mmACP_DMA_DESC_BASE_ADDR);
 
 	/* Num of descriptiors in SRAM 0x4, means 256 descriptors;(64 * 4) */
 	acp_reg_write(0x4, acp_mmio, mmACP_DMA_DESC_MAX_NUM_DSCR);
 	acp_reg_write(ACP_EXTERNAL_INTR_CNTL__DMAIOCMask_MASK,
-		acp_mmio, mmACP_EXTERNAL_INTR_CNTL);
+		      acp_mmio, mmACP_EXTERNAL_INTR_CNTL);
 
-       /* When ACP_TILE_P1 is turned on, all SRAM banks get turned on.
+       /*
+	* When ACP_TILE_P1 is turned on, all SRAM banks get turned on.
 	* Now, turn off all of them. This can't be done in 'poweron' of
 	* ACP pm domain, as this requires ACP to be initialized.
 	* For Stoney, Memory gating is disabled,i.e SRAM Banks
@@ -606,7 +615,7 @@ static int acp_deinit(void __iomem *acp_mmio)
 		}
 		udelay(100);
 	}
-	/** Disable ACP clock */
+	/* Disable ACP clock */
 	val = acp_reg_read(acp_mmio, mmACP_CONTROL);
 	val &= ~ACP_CONTROL__ClkEn_MASK;
 	acp_reg_write(val, acp_mmio, mmACP_CONTROL);
@@ -615,7 +624,7 @@ static int acp_deinit(void __iomem *acp_mmio)
 
 	while (true) {
 		val = acp_reg_read(acp_mmio, mmACP_STATUS);
-		if (!(val & (u32) 0x1))
+		if (!(val & (u32)0x1))
 			break;
 		if (--count == 0) {
 			pr_err("Failed to reset ACP\n");
@@ -658,7 +667,7 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 		snd_pcm_period_elapsed(irq_data->play_i2ssp_stream);
 
 		acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) << 16,
-				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
@@ -673,14 +682,14 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)
 		acp_dma_start(acp_mmio, ACP_TO_SYSRAM_CH_NUM, false);
 
 		acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) << 16,
-				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
 		valid_irq = true;
 		snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
 		acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) << 16,
-				acp_mmio, mmACP_EXTERNAL_INTR_STAT);
+			      acp_mmio, mmACP_EXTERNAL_INTR_STAT);
 	}
 
 	if (valid_irq)
@@ -695,11 +704,12 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	int ret = 0;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct audio_drv_data *intr_data = dev_get_drvdata(component->dev);
 	struct audio_substream_data *adata =
 		kzalloc(sizeof(struct audio_substream_data), GFP_KERNEL);
-	if (adata == NULL)
+	if (!adata)
 		return -ENOMEM;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -731,17 +741,19 @@ static int acp_dma_open(struct snd_pcm_substream *substream)
 	adata->acp_mmio = intr_data->acp_mmio;
 	runtime->private_data = adata;
 
-	/* Enable ACP irq, when neither playback or capture streams are
+	/*
+	 * Enable ACP irq, when neither playback or capture streams are
 	 * active by the time when a new stream is being opened.
 	 * This enablement is not required for another stream, if current
 	 * stream is not closed
-	*/
+	 */
 	if (!intr_data->play_i2ssp_stream && !intr_data->capture_i2ssp_stream)
 		acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		intr_data->play_i2ssp_stream = substream;
-		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		/*
+		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
 		 */
@@ -772,7 +784,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	runtime = substream->runtime;
@@ -782,12 +795,14 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (adata->asic_type == CHIP_STONEY) {
-		val = acp_reg_read(adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		val = acp_reg_read(adata->acp_mmio,
+				   mmACP_I2S_16BIT_RESOLUTION_EN);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
 		else
 			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
-		acp_reg_write(val, adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		acp_reg_write(val, adata->acp_mmio,
+			      mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
@@ -797,7 +812,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 	pg = virt_to_page(substream->dma_buffer.area);
 
-	if (pg != NULL) {
+	if (pg) {
 		acp_set_sram_bank_state(rtd->acp_mmio, 0, true);
 		/* Save for runtime private data */
 		rtd->pg = pg;
@@ -885,18 +900,18 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 		return -EINVAL;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH12,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       PLAYBACK_START_DMA_DESCR_CH12,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH13,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       PLAYBACK_START_DMA_DESCR_CH13,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 	} else {
 		config_acp_dma_channel(rtd->acp_mmio, ACP_TO_SYSRAM_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH14,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       CAPTURE_START_DMA_DESCR_CH14,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 		config_acp_dma_channel(rtd->acp_mmio, I2S_TO_ACP_DMA_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH15,
-					NUM_DSCRS_PER_CHANNEL, 0);
+				       CAPTURE_START_DMA_DESCR_CH15,
+				       NUM_DSCRS_PER_CHANNEL, 0);
 	}
 	return 0;
 }
@@ -910,7 +925,8 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
 	struct audio_substream_data *rtd = runtime->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 
 	if (!rtd)
 		return -EINVAL;
@@ -924,7 +940,7 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			if (rtd->i2ssp_renderbytescount == 0)
 				rtd->i2ssp_renderbytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio,
-						SYSRAM_TO_ACP_CH_NUM, false);
+				      SYSRAM_TO_ACP_CH_NUM, false);
 			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
 						BIT(SYSRAM_TO_ACP_CH_NUM)) {
 				if (!loops--) {
@@ -936,41 +952,41 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			}
 
 			acp_dma_start(rtd->acp_mmio,
-					ACP_TO_I2S_DMA_CH_NUM, true);
+				      ACP_TO_I2S_DMA_CH_NUM, true);
 
 		} else {
 			if (rtd->i2ssp_capturebytescount == 0)
 				rtd->i2ssp_capturebytescount = bytescount;
 			acp_dma_start(rtd->acp_mmio,
-					    I2S_TO_ACP_DMA_CH_NUM, true);
+				      I2S_TO_ACP_DMA_CH_NUM, true);
 		}
 		ret = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		/* Need to stop only circular DMA channels :
+		/*
+		 * Need to stop only circular DMA channels :
 		 * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM. Non-circular
 		 * channels will stopped automatically after its transfer
 		 * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
 		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			ret = acp_dma_stop(rtd->acp_mmio,
-						SYSRAM_TO_ACP_CH_NUM);
+					   SYSRAM_TO_ACP_CH_NUM);
 			ret = acp_dma_stop(rtd->acp_mmio,
-					ACP_TO_I2S_DMA_CH_NUM);
+					   ACP_TO_I2S_DMA_CH_NUM);
 			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			ret = acp_dma_stop(rtd->acp_mmio,
-					I2S_TO_ACP_DMA_CH_NUM);
+					   I2S_TO_ACP_DMA_CH_NUM);
 			ret = acp_dma_stop(rtd->acp_mmio,
-						ACP_TO_SYSRAM_CH_NUM);
+					   ACP_TO_SYSRAM_CH_NUM);
 			rtd->i2ssp_capturebytescount = 0;
 		}
 		break;
 	default:
 		ret = -EINVAL;
-
 	}
 	return ret;
 }
@@ -978,26 +994,27 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 static int acp_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	switch (adata->asic_type) {
 	case CHIP_STONEY:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-							SNDRV_DMA_TYPE_DEV,
-							NULL, ST_MIN_BUFFER,
-							ST_MAX_BUFFER);
+							    SNDRV_DMA_TYPE_DEV,
+							    NULL, ST_MIN_BUFFER,
+							    ST_MAX_BUFFER);
 		break;
 	default:
 		ret = snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
-							SNDRV_DMA_TYPE_DEV,
-							NULL, MIN_BUFFER,
-							MAX_BUFFER);
+							    SNDRV_DMA_TYPE_DEV,
+							    NULL, MIN_BUFFER,
+							    MAX_BUFFER);
 		break;
 	}
 	if (ret < 0)
 		dev_err(component->dev,
-				"buffer preallocation failer error:%d\n", ret);
+			"buffer preallocation failer error:%d\n", ret);
 	return ret;
 }
 
@@ -1007,14 +1024,16 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
-	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd, DRV_NAME);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
 	kfree(rtd);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
-		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		/*
+		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
 		 * added condition checks for Carrizo platform only
@@ -1022,20 +1041,21 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 1; bank <= 4; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-				false);
+							false);
 		}
 	} else  {
 		adata->capture_i2ssp_stream = NULL;
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-						     false);
+							false);
 		}
 	}
 
-	/* Disable ACP irq, when the current stream is being closed and
+	/*
+	 * Disable ACP irq, when the current stream is being closed and
 	 * another stream is also not active.
-	*/
+	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 
@@ -1054,7 +1074,7 @@ static const struct snd_pcm_ops acp_dma_ops = {
 	.prepare = acp_dma_prepare,
 };
 
-static struct snd_soc_component_driver acp_asoc_platform = {
+static const struct snd_soc_component_driver acp_asoc_platform = {
 	.name = DRV_NAME,
 	.ops = &acp_dma_ops,
 	.pcm_new = acp_dma_new,
@@ -1073,8 +1093,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 	}
 
 	audio_drv_data = devm_kzalloc(&pdev->dev, sizeof(struct audio_drv_data),
-					GFP_KERNEL);
-	if (audio_drv_data == NULL)
+				      GFP_KERNEL);
+	if (!audio_drv_data)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1082,7 +1102,8 @@ static int acp_audio_probe(struct platform_device *pdev)
 	if (IS_ERR(audio_drv_data->acp_mmio))
 		return PTR_ERR(audio_drv_data->acp_mmio);
 
-	/* The following members gets populated in device 'open'
+	/*
+	 * The following members gets populated in device 'open'
 	 * function. Till then interrupts are disabled in 'acp_init'
 	 * and device doesn't generate any interrupts.
 	 */
@@ -1099,7 +1120,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	}
 
 	status = devm_request_irq(&pdev->dev, res->start, dma_irq_handler,
-					0, "ACP_IRQ", &pdev->dev);
+				  0, "ACP_IRQ", &pdev->dev);
 	if (status) {
 		dev_err(&pdev->dev, "ACP IRQ request failed\n");
 		return status;
@@ -1115,7 +1136,7 @@ static int acp_audio_probe(struct platform_device *pdev)
 	}
 
 	status = devm_snd_soc_register_component(&pdev->dev,
-						&acp_asoc_platform, NULL, 0);
+						 &acp_asoc_platform, NULL, 0);
 	if (status != 0) {
 		dev_err(&pdev->dev, "Fail to register ALSA platform device\n");
 		return status;
@@ -1154,28 +1175,30 @@ static int acp_pcm_resume(struct device *dev)
 	}
 
 	if (adata->play_i2ssp_stream && adata->play_i2ssp_stream->runtime) {
-		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
+		/*
+		 * For Stoney, Memory gating is disabled,i.e SRAM Banks
 		 * won't be turned off. The default state for SRAM banks is ON.
 		 * Setting SRAM bank state code skipped for STONEY platform.
 		 */
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 1; bank <= 4; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-						true);
+							true);
 		}
 		config_acp_dma(adata->acp_mmio,
-			adata->play_i2ssp_stream->runtime->private_data,
-			adata->asic_type);
+			       adata->play_i2ssp_stream->runtime->private_data,
+			       adata->asic_type);
 	}
-	if (adata->capture_i2ssp_stream && adata->capture_i2ssp_stream->runtime) {
+	if (adata->capture_i2ssp_stream &&
+	    adata->capture_i2ssp_stream->runtime) {
 		if (adata->asic_type != CHIP_STONEY) {
 			for (bank = 5; bank <= 8; bank++)
 				acp_set_sram_bank_state(adata->acp_mmio, bank,
-						true);
+							true);
 		}
 		config_acp_dma(adata->acp_mmio,
-			adata->capture_i2ssp_stream->runtime->private_data,
-			adata->asic_type);
+			       adata->capture_i2ssp_stream->runtime->private_data,
+			       adata->asic_type);
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index ba01510..0e6089b 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -115,23 +115,25 @@ enum {
 };
 
 enum {
-	ACP_DMA_ATTRIBUTES_SHAREDMEM_TO_DAGB_ONION = 0x0,
-	ACP_DMA_ATTRIBUTES_SHARED_MEM_TO_DAGB_GARLIC = 0x1,
-	ACP_DMA_ATTRIBUTES_DAGB_ONION_TO_SHAREDMEM = 0x8,
-	ACP_DMA_ATTRIBUTES_DAGB_GARLIC_TO_SHAREDMEM = 0x9,
-	ACP_DMA_ATTRIBUTES_FORCE_SIZE = 0xF
+	ACP_DMA_ATTR_SHAREDMEM_TO_DAGB_ONION = 0x0,
+	ACP_DMA_ATTR_SHARED_MEM_TO_DAGB_GARLIC = 0x1,
+	ACP_DMA_ATTR_DAGB_ONION_TO_SHAREDMEM = 0x8,
+	ACP_DMA_ATTR_DAGB_GARLIC_TO_SHAREDMEM = 0x9,
+	ACP_DMA_ATTR_FORCE_SIZE = 0xF
 };
 
 typedef struct acp_dma_dscr_transfer {
 	/* Specifies the source memory location for the DMA data transfer. */
 	u32 src;
-	/* Specifies the destination memory location to where the data will
+	/*
+	 * Specifies the destination memory location to where the data will
 	 * be transferred.
-	*/
+	 */
 	u32 dest;
-	/* Specifies the number of bytes need to be transferred
-	* from source to destination memory.Transfer direction & IOC enable
-	*/
+	/*
+	 * Specifies the number of bytes need to be transferred
+	 * from source to destination memory.Transfer direction & IOC enable
+	 */
 	u32 xfer_val;
 	/* Reserved for future use */
 	u32 reserved;
-- 
2.7.4
