Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeEAUyp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:54:45 -0400
Received: from mail-sn1nam02on0066.outbound.protection.outlook.com ([104.47.36.66]:8192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750803AbeEAUyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:54:43 -0400
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/10] ASoC: AMD: Add const to snd_soc_ops instances
Date: Wed, 2 May 2018 02:20:03 +0530
Message-ID: <1525207810-1305-9-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(2980300002)(428003)(199004)(189003)(68736007)(186003)(6346003)(126002)(2616005)(81166006)(476003)(7696005)(50466002)(51416003)(50226002)(76176011)(356003)(109986005)(336012)(1671002)(8936002)(81156014)(39060400002)(77096007)(446003)(498600001)(426003)(53936002)(11346002)(36756003)(486006)(86362001)(72206003)(4326008)(16586007)(105586002)(53416004)(5660300001)(26005)(106466001)(47776003)(104016004)(8676002)(6666003)(48376002)(97736004)(2906002)(305945005)(54906003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0327;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT025;1:gYiR32fnHDOaWoq/+KanaB+Qs/GKwKTC6+MWUKgO6f1V6loUO1vG8HFbnsUe9nQIgFHnQdXng+iWGP2ZwSTYKf4oBAONWMvqToy/p6Lyn5pjlkQCan0KXvlAkLDs1LmA
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;3:86BXG4cjVoaqi+e+H5e/De+ob56nEDAQTGMkGveESu3k1vzc88nyyFpz5qmyRW7JfuptoQeqOuTQEqqcYsckl/8y+BCcpxWG3g2gKe67bmXANwu3AL9IXl9fAzsggElHTsTxHhiESdt7nRW/uAZUjO3Y730WEskcq/n/crf9qhO7F6fIeyF3pQ2ZT7F2tSkGZpgW1xeEb6y58sENQPMjA4roj0weq5T2/jU+bPI2EAE++JvhVAKlWnAi8vBx4RTykd9lO9wPnfEGKdJuVCH4NZvg9Z2X9IlPoIJDeCiUU8TiLWRqNV/H64pvzH65ki37xSpnjRKzXvdOarjMSVJJ93z3XxFZy0XvL3H4pn1J1sQ=;25:gmJUdaFPSbCJ23zV45wQ02vtf6qwF3Q+/QbJT1psVphHncXqR2qru0GLRGlURU/lMKroFCZpSSyn+fDjHGdDD4j6eMS22rNaXg2HJ6ZObrvM/XSFQzeJviMFVyDrEHKrsTN/eegcjNwSO0O7FIHbBv0YBbu2IKBRLtsbupr1TuenaTWkaHBHEsiyDnz4gj2YR9wG8uOfi3eRWoZDXBOxW+pAVmS24xf6DlXsHjBVpY9xk5gRDR/TKLAOxv7w+aIq3QVfOJnOQPZ4E30AmYCML9hIxdzoo/zVETeyjyPyM8QnXuQGB0M026GjSIsxives5BFWGu/AtslKfjFqC87x3w==
X-MS-TrafficTypeDiagnostic: CY1PR12MB0327:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;31:uA/Ywc674liRYJCq/YMxHIwUWidlHxQpjsvIMUeqIBqEdKE4/1WGB9wgw7Q67V0RJBhr8mV7H+p7D4poFHKd4H/B4cbASXWMA1P5Qy0e9MRnXGcltdBF2XXurR4kNYdj5rlbJ1XZVg9b0XgA7hdK8dE9Rg4k4weHDBC+83jdUSlZ1FQgpWr0Yq5WrAPeBx56L8A419m/TFGvfJA2uomnF+3syzbcBm6v1ImG+LcnmVM=;20:j6KRInOP8+US9PYXNtKMWuBMrWhN3Aq8xgDLJou/LFQoZd24oauC5oZ+ntHfMTNhaF6wv65ymp8MLqZ1LO8ga+XX3Cmbh6I9Jut7ECLGqITFzFKN0JLhpAsaD0q3CoPMvvuuC0/F4HU+0OEbT4u8OZPAC5wxLlRtJg4CSDSdH6AgO8HoS6gpsdPBJKaQR8nFkitHkK45bZF1FSSXFCV8duIYK4/u//l9SMvY0D6myG/4G6A9apcwyn8Gg5MNeKwy3BSyghZOQqg4cN1M99L5mNcvvfs6V2jguZni46Dz7pFbGJkC2PuTeQHDqBUb8DESYRlHkba12WF20Df0aQVrAD1kYbT4ZuNDkB1wfrvqvoYyLqBtsNtRsrh3jSo3gA9oqPTijhrYdbE3q3Ub1JxL1+CXH20Xy77pr4WxpN7IqwW2GDq95Cdy0ulEsDdbXeu1xSl7/OVY3xaHy3PinFfJGouaAi64FMLy8qh4zAXfmGyZEjDpA1ogwhL4tMmQLQCB
X-Microsoft-Antispam-PRVS: <CY1PR12MB0327A8116CC6A7E1E24A77A797810@CY1PR12MB0327.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93003095)(3002001)(6055026)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201703061421075)(201703161042150)(6042181)(6072148)(201708071742011);SRVR:CY1PR12MB0327;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0327;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;4:Is6JETga0pfMRGZ1y02lAra/z46yJ+H99qufdBDGer28JokYfFQmdZ8clWAhpHv7hkvjIr5RIm7uwSVSgK2Tu6nMW5QZ7JFRibK3Ysk3nRd+2ChSdh0EsO9Cl4yh0KNDnBhFCizjCOqRDfv/Tab4owGaSNlZltzrlmy0/8tIWi0LhB46Hxm4eLACWZq4rsZiHFMuC2ogQu6l6LsDCEQAX541uxPz4bguanje9XFKRYUFPGUSRvOZVpDpLBuRH4a5hNx1/y63cwuqOwuj1T9ZehC1tNMGZWxGH/5/OaQ1/wor0zVSeUcXlPnAWWx3o2KL
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0327;23:27sKAzJsXsWokwU5iCGJJAcSFTIEuFf0XA5oh8HSt?=
 =?us-ascii?Q?nE9FdB2JyF2LnNsUZwcYxLX1WE+SqnRl29ZxziNuMYja6Q5p1298sAbdCF+o?=
 =?us-ascii?Q?m7dcJKOAvpF9gXY3LVTkVvhrxLo3bCbsL3IBxoxiEvkGQisj8+K+XpHy5Jbn?=
 =?us-ascii?Q?iaqYp27yhQkA2Pre1D/pzMTCg9be9vktdJXmQjFSPWilpLZxYc5A8okY0x05?=
 =?us-ascii?Q?uxSy4obJ0fgARQGR4FjsFNtkYGThtIsIN0CDMxND5kvVhNzYyFVi9vhsIrYd?=
 =?us-ascii?Q?BqPv0bAhnWsBUdTIP30BrRSOSBO1pnDnVmElw6nh7k7diFFjlrOYxTjPWE00?=
 =?us-ascii?Q?pj3lCPvVHVyTdE6bvmYUB31yDqbo2H7W5j3rxOGqZ/BMNHh7fVjgqTL/kIWd?=
 =?us-ascii?Q?M3DHyD63GDnyRBgpATueBHyGOppVsO5jrfHnET7XORZMjpleGyzjfuDyr9bB?=
 =?us-ascii?Q?LqzGz3S8isNlOkujGVyafPqvB7E4Aq38BAdVh5DsfZIgndRBvrg3aaEogaYf?=
 =?us-ascii?Q?xYYdAA0FPEjpcrdKn7J32G4cvr8iyZR2HeJ1SfQvAhEmwp2KtHiAWPLCOKpo?=
 =?us-ascii?Q?jvfOyZ5E/l9kT3/BOkwqGgvV42bZKzMGIMM6zsoVXCVGCkjBJEhNpEqq9wuL?=
 =?us-ascii?Q?es+Pk7jj0twYrjS6elT49LkOHZqIT+hWjDfVnDNQR/bD9t8UJ0NQYVQyVIUK?=
 =?us-ascii?Q?nRtNkhdRuT/UYHyzJCpsNrnqD0ShOrfZ7d3wNyl7m6Fe9gpWZ2n5eCeCSokq?=
 =?us-ascii?Q?kB9chbhKFaOR7ZXNxTWORNnBQB1OrFujfcXBbkXQghg/ytF/KuB/eigbs9yq?=
 =?us-ascii?Q?QYLR5mzq6gDNRLvJ7cNC/cU77W+CaNop8DB2CBI2FALIWYjkj9e9LzSKpyA8?=
 =?us-ascii?Q?m/XN08aC+A6OPnOOqgbOt5MLom2WK1FbY4xmBpJOvMD7D/11zWtvY7ruiyxt?=
 =?us-ascii?Q?D1QU2xzAWiol+/XIN0/CthUDofKBCTwTkHcomBnPcoqPBE6Mfn3vWNS9Pug7?=
 =?us-ascii?Q?GrmF672cplZJZVuG7yJAbSY1LVZ5PLdiyPcRebMmg3HPUftwt0IfuRYUjF6l?=
 =?us-ascii?Q?fHKC84+iQIb5WJNL8hJYL9XXnSaV/HCxgcBNywEvfU1RFb+Ih+8wEwqz8U1K?=
 =?us-ascii?Q?cNUEADkOzU=3D?=
X-Microsoft-Antispam-Message-Info: L5SHytQr/3CHW8OxX44f1zAWer7Aom8qwQVmQ9F9il/+nQghRpf4+xQ7zsMmaYursu7FvEgvNnzoz4KrO+xWNPN/6SIlICbgbZuFoV5FUUj5kOPedCXef+mzcTXx8zNRUfH3uCt7Vk7DjnpPmWb2AgmaUhmkXZ/wfAQpTSl1AHrIbVMVZy1FwXhg2o05EqOC
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;6:oEyXmGc9H8Cr5GpuFSsBIoF64BHJOGuVDQizubjd7CDYJsAKOvYnN6ph1HIvvwfjwYxfMR2UjRdXLGQpxpHinxXcBIATdeWYdVCS5mywGTIe5DmMI/vX94qT8D9khWDq8IhiYCIn7AB2OsB+Yd2sGkXfOOZzczzMcEpGsaS5yKQiv4mi5X3Pg6b2fY5z7CjcMirHeUlylotFTUhY+KYBq+jjdsrQZDc+NlSZOTkfXG65dkuY6XK/zjF5dAGlCId44q2xhyFfjFsas9KzLvpFXfUzuyzHh26ozXbvMCxnOc4jeVin8bEK4htWIcxKNdRfskcPSW90DC1f1FpmyzX1F54dua63vw/HCB6bxENFXNr0nJqzTuv3fE2DI+DSPqWhUVSOTnxsy0JumfClS1dRHBfpeP7whxn7xhAFMbj5asWmiApAoXGnV5/udXdMOfKx3tzvNGJ1j7qSCVkT7YykpQ==;5:mhbuZv1MGOpIqgMkiDl3k9+WFnvRJ6TSOqPZYNDZ6nNiyYqLHJ4OgSm60y7L5VET17+bMdoAxnwVyj/pLHcFod98t1s0kHkMXoFZhVSf308RPrbg52lFMuWmMRzp420h8kTSRsPuUpBa5KMmlDnp1hIjj8S1PW7KWWV7btcLS1I=;24:+9wPnCq9w6WQLoeSAy2EGxhgDpVPgXJ7CX/gjIZf1IZUioVP10A3R9unoWna2MBdTs+Nw+MzZGXQMhmQNSeHBUOhtYGyLH5LsArcuWBQmmE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0327;7:bsDR6AzWwVDxOU4pCDSU3kiR6OA1yXc8SfRbROU+vkTUDUbmFPEUpZtgY9hpCCptk762DtsELYkFVeMR5JYmf/tz1UGImhomsIzvV5185Zo2IOSKLzPQaFt1BTDw93GlqUoqp1njHzYXeT3glX/DStmKAq7uflbE5+iFBX3Dbv38TVVD6n0ldIHDhetIJ9Mo54RksEIEGk/LjwQllBQebflJDPJb5w3f4rpzk/2F5IPlroTU/YbHJnSLxvf6bUzP;20:iOtOTfsBPTMGxWTCuDUrGRoMD8Xee4ORT4knHqkA9iozihdsevI9EAWqvG1UvvRUzI/SgZJ/PpcM3cFmWpwcE8/lF5oRkyfOB2QdZZ7PJ+8OTiFm8sz0NWoQ/QtUzmVxMT4mhw7bIjWlMOqisdePAJy/XXg0jCWpXHiNE54QJ7atwtAZI0xo4rKxBMULll+b8K7xbQWGxz0a86fEyG2ZTR1UokiFRqDmk/ac2Yr5agPGEiBBY/P+xB39lXepaOAc
X-MS-Office365-Filtering-Correlation-Id: 206a8b94-20d5-4237-b137-08d5afa57661
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:52:32.9152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 206a8b94-20d5-4237-b137-08d5afa57661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0327
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

Marking snd_soc_ops instances const

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index fa5ad5b..133139d 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -171,17 +171,17 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
-static struct snd_soc_ops cz_da7219_cap_ops = {
+static const struct snd_soc_ops cz_da7219_cap_ops = {
 	.startup = cz_da7219_startup,
 	.shutdown = cz_da7219_shutdown,
 };
 
-static struct snd_soc_ops cz_max_play_ops = {
+static const struct snd_soc_ops cz_max_play_ops = {
 	.startup = cz_max_startup,
 	.shutdown = cz_max_shutdown,
 };
 
-static struct snd_soc_ops cz_dmic_cap_ops = {
+static const struct snd_soc_ops cz_dmic_cap_ops = {
 	.startup = cz_dmic_startup,
 	.shutdown = cz_dmic_shutdown,
 };
-- 
2.7.4
