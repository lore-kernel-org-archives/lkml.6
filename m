Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeEHEsS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:48:18 -0400
Received: from mail-by2nam01on0076.outbound.protection.outlook.com ([104.47.34.76]:24637
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753510AbeEHEsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:48:16 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/10] ASoC: AMD: Add const to snd_soc_ops instances
Date: Tue, 8 May 2018 10:17:52 +0530
Message-ID: <1525754888-14124-9-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(428003)(199004)(189003)(51416003)(7696005)(76176011)(77096007)(97736004)(186003)(26005)(106466001)(126002)(68736007)(47776003)(53416004)(2616005)(446003)(5660300001)(11346002)(476003)(426003)(316002)(36756003)(16586007)(486006)(105586002)(54906003)(86362001)(4326008)(109986005)(1671002)(72206003)(53936002)(50466002)(2906002)(39060400002)(104016004)(305945005)(336012)(48376002)(356003)(478600001)(50226002)(6666003)(8936002)(8676002)(81166006)(81156014)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0336;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT044;1:cXEpQzBBvbSLgN+8DrSudQpuMqAcgJiloXepHXM+Ed/qMS27Fi/4xAIuDudGy1m371/+ssgtWNO9yRgqCjzQJYodqtn33bi9z23xrZvjnkOuAm9DNOJoaop3DcGTv2HQ
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060);SRVR:SN1PR12MB0336;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0336;3:NPq6GRZ4wJXzLI/Der0dCDj2eCTGurzOzwcVFFgpXqPO4+oQ9roqwhwoE2fKQ/6MWtw92pQ5sKkvzCzpeUOZc6oJZKmo1xRDashUJOii0QX8MdTRRKJAfiGJJAfEMQqIYfFYDmWhwNoAnflvsf1QCYTUbgxgjBpKYqYAz2kzbofd2XdKXTXY4gyivbV9DpzBfRUFLq8ewYBbmcmV9gv+nxduSNgrBsHN+d0K+e+3HYQ8D874k9ewdT5K/oSPvVb81wknvnEcdtMVPBtOkPSl+ZsMrJVbipqcmye+fPFJZSDALiBU03/WlM9ZUIJGms+JU/MHLqZTuwPkWfTFodRAPI5IvHNVhFCHsrAE7q1Ujv8=;25:DppWsyFKNvFxpBrcL9DbF/HHRl2StK0kU6Az7YyCqGq0hQsfaS+IExvtN1ece8teRaVPXXtYRxqno9ALqhf8O9vrr6GBuyePk5hbjZFActdmzX9Qm5SverCbtTySh9t5aCarggmXweumIxkf+TMDm9jYMU8LA9r9MWcLiPgQPVz3UFH85Jdhv41D7r0NRXsZ+SkcUcPKtlTyleyP3HvePpzdhnI5ger97ihv3iXYzV4wpGvfoAd3EP3NKigemegJtim9Wi3oVOUX4qhCCX2fV3lLNuIwSNA7Qziqcj8zTYAYvsoiqWVQ+wpur6PVSPrG4s0HWgxRVrDv8RUMwqb8EQ==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0336:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0336;31:7Tl8sxNKGHbJWO0Xtr/91epD+O66KXj910wsQJLOR0erB+V4ahwALSa8TJ3MSGmgbxZWPaql4O4yjxbYFWf7uWRVjwR6zq9N892DPbJ6v7E/2W6klcNnQSZamI1ikZdQ7f86LNjsnvqSW31kuJmQk1PDCvwCKfnryQQmMuMzIXqE1NAhDjEvS+JOehSellRIV+/oUbSl9usvjMTjcX6/LxuBpOHgOdQ7cbIovtPwcjM=;20:rKB0UxbQZucQRjueuxz//+FvpmZsOPxtA7wE5ffzq4SXEP98m+AtYZmzP9lmyuTL0fJbh+m7FGGKWP9+92ZEoneTIQYM5La0obrGXba/lKinpqyoNFlaG0IzekSnpg6sQq37xPa9CI5x2m6u/RAEhlfGg2v4zzdf+7saxqB9lcNsDs9o9wU186LqQLwg0CSi1BomIQDBgY2fMfCZx5JKjUpP72BuHwo5jyUYQ5E3OSkaA8zWyoh2vLTdVS7PO19dfZZ3yd/LJUAWPDFduW5m8G2yZDWES0J0zX4osGjHgGvsmJNDRANj2q/8+RBZy8xOLLuVuCKmeTvdLATCJsVhYhgquXXQvxRbo4i3RkxI7G/wQqh7WjhuxkAUmcdlUyXkRNOrwEKoxcQO7R+x5BMCkknqQMzqYTas5by+25en5wkunrP/FGhYKtF3VuSN/Hf8E6bnC78m1A9vQSTCAupNhm9FQf6ziArGfkA+LEPx9AjQ0SCHHyrULjGqaESFJpPA
X-Microsoft-Antispam-PRVS: <SN1PR12MB0336C8AAE4B8BB7515C8F47D979A0@SN1PR12MB0336.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93003095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0336;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0336;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0336;4:9DDmh/YZw7rrILMWzITWlJCA0n7U8lrKluAVgSYtgkPEpBjeGxAkZFyxzcWOL07F4YdcqUi/Sp3ib2AaVl8f90JWUAjtzSQwwz50j+hy+myuj1sYWobD8Rp8CXyvNHRpTfrXRRJWaEH7XCSDlCgkerwFfzbPCtMdx6UWlcVFUkVK1JpKuR8+3jgafpt7oQddbHEz6lWA/p8KRJVSQxiNiWB0q6v0IpAcszmNjIzJv8IGMI+aM8Jt13R4HsWp84c5CpwHReN6YJVk9z3aWM1+jKlGRVdfJ3ntoh9IUGVRYFGRpxQEGOhjVqMbyIoofhcD
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0336;23:p6tSoWJVVScDJQykdIGHADWdO8KB9RTFaJwfFY/mq?=
 =?us-ascii?Q?PNVx9Ewg+NZbfCXkpuSA1bK9g7Z5aLG9f6uZ/6Y30yjbzB6tzlGxyVHQSKbi?=
 =?us-ascii?Q?UsHdQ46JuvWjZVYNgxwyIPYVjkTpeSDVwYh/85jgT10NIGTsGcGHwIiIxcaG?=
 =?us-ascii?Q?0DoC+11LCLXU+h8I3EjuMNufNwktxgRfZVVZOKWsbhWqLPWqWdVyfgX7KoLw?=
 =?us-ascii?Q?+zNllELM+axrgy5835DJqU68XHHcvmaolWgnWghzeYDpFmlNjAiX5uO0S0YZ?=
 =?us-ascii?Q?fusk/jUaQeMcDGVa4dLQoLvpUg0tTHlppvErwRF1cbrZun3zY+KKwENa7GQU?=
 =?us-ascii?Q?ePCaBHx8rRk+qHsQAfEdqha1mLvk54IhJxhjjDrs5aBxE48BOl9Hip4/STco?=
 =?us-ascii?Q?A8hCc+47n0V7nbcZbq5dUlsg/ZmHv0awZVi7RmQkUEQJmaAIP3Zi5XU9N3S2?=
 =?us-ascii?Q?IU5Fkddpi0QUa9N8BD/NzQwy8RKLS8DJ2d+GgqXVB8WgmRmRyhTAjX3YWpev?=
 =?us-ascii?Q?eLFiWJJ5gIReVcp2SN2THAX0VqMW9yzhLmYrPlFl9talo5GJMgvWtbcZCwLU?=
 =?us-ascii?Q?HHlpLcyL2VBsh7600L2RZ6MwXUsemaI2nioK57qTZH75tr4yda0uweYTnEpC?=
 =?us-ascii?Q?QEIUlGUoQALWPVUe+JNxbaIbZ9vxeTbcwdMz7+2/z6f99OK5T73tRaZqm17F?=
 =?us-ascii?Q?+zhC/OQz8bqFHV9kxInbLmmJR5YCOK3Msw+TAQyozNLMkeh1NlXSvksmPUlB?=
 =?us-ascii?Q?jdFDjEjszdEIDlNILVLOMrLfMkGpa0VuzQ8LXHzL5sSrEGGKNblTKtqzpcFP?=
 =?us-ascii?Q?zhW1JHzmEnFQ4mu/Ha9g1EFX+yJ8j/pVaAdQ1PLW267fFQ5MRXcEbjh2XHMH?=
 =?us-ascii?Q?H35bFoXOCRlY6iMDxUJCJAcq5fu8Kirt1wzYo1SAEijcOGf864JyLUfjcBPv?=
 =?us-ascii?Q?psb7GcKz8OxV5ULxr6W+IsiF3SWE8/BIti5okeVWXEK5tM/7e+w7Q0BOeay9?=
 =?us-ascii?Q?bZB1yHkqbIEPyKms8f2pNhzJNw7Bb75/Z+Mjyptt3AK7LSXIW1nvuosmEQz0?=
 =?us-ascii?Q?LElO6H5LFvh0/QTbVyPr6NnN7XJ9Q3XtpukVmoabO/hwBeSAI1BS8hLKAnWm?=
 =?us-ascii?Q?4X3cwU8/Z2tBL4MNtejGjMhAaNmbG6IRNZkAmqdXyT31SvnncR8kFw8XYZ/n?=
 =?us-ascii?Q?mHAwpWtvuSGcaMa7QDJV8cG4QRI5YPa6AQs1RdKWUEgkW3bnyLPHwsi5g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: daKFFZCKUUzNUlmtxGbGsujF+9OAb7mauQygek6oPiz0vvtX2WPrK3oUb5WvOKtXHSYsfFQxsP/sxu1kfCuGwj37Nuk1kKy8J119hOJhbqUkSeHvPmUftaYzgiuDAuCv4WQ4x0ribAiDX5EagQKwOgjF2C8xMBVNCkPk5H+yeGVnfn7BVgv8f6MgUHQSUC4J
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0336;6:4zuGZKtm+SN7cZXiakbmZQSkooJXWTUM5+OTksyAqX8FDUy1S6TBpzzGgoCC4lso216O4XWYkQh25/RFrk5s1yNpcyR6CZzDPyQQ0t/0PjSc5YqucvpkOojV8sV8dJObBe4Ltl8i9jgpBDnTBFccrHXhYR8xCE35RGAh+HtoAsJ2YkEPsp9N/nf+m3gwlMscfAPzDRzN4R4Tym+r4WcxTHlgG1oS6EJbGas4MG/bZ8zMTvBWT0ewAmfNMx1Xs9pdL5BG1Mvnx3ZI7bkwrazlUagnqfwwJBb476BH7+9lIot9H9fHJaZDnRoCh8ZD5mkOGys5ZbRSn8XpCt/xdNQyZ1xnzI7SLhLrsbyF4R411LZBb90r0IbTIW4HNtkPR6SsZTtzE5jdaXTR3SwQNjuPCXwtLo1RCsIVWGJguUTLUaQdwFX5n929bGCm4zko5IrqyD6YJaJvSDG6ohiGoM6GNA==;5:QtkA3mfroRaAYlvgjhjWvwzEGu2+1KXgJ1KNmmUdBR8k+kbM1+SKim0FU3wntwzusPv7M+vODLjp/gMeiG7WfUEUXCH5qpBXComDfzwMw4YepVT5HbhnyY3u34X2tvejDm6ZcsyZsfN23Q6ggHYkaEtVCpRECDzKrFpiGJoanf0=;24:KRaKEB3YUPnTXKs+IeN06voyPsIvM5RiATV1yqhrOIhY9NwQG/4Q7tGrtBRmRlnrHOKERbw4RSNFmtmw25vyAAJwJnNFheZgtyoDulnrG9s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0336;7:40F5qROTVn6X27gQK8IROxeECZS6moDCou0HuKqhKjYkjAHSQKwFnbWUsIVfqdNdhpS6JGooxYrVMYI0r6lKwOnQL3Wsg3PhXG6G6PnJyTx3EUxtER3VCZek0Ydp/N3zy+kBX+aNhrPZ4k8BIYU1bx5bBN81/5aNXhqglaVv69DfQ3SxCX21X+8SejlLqqKHc/VyZuctuMO83xkAsLUWkbyVBPAzWsfhEOF2Qs48CsCQXm3gIETYl1AFd44it7ng;20:bMgTdJG/dqC+2FgLzigokESQ9aElyS0p4uoa1WJH/K8GSHaM1TW2TNvYOJb3TR1GXpF8eVW+h6xOlaN+X9mB93y7l0eGhGjikHsY+rYQO+y3+nAeeyK8BDKU+LtsD/FHw0LCf0zYLHAZ+bbyA1NLvxvHmfVUKT8FXZmvQB5+kkohdf8R+H2fLG0YJSGCH0yvQTKGW9jDBBvl6dFQzz3uV+DKXqGIVtNw5cQOMPxe7EuVJmTAgj2fACsZjjOFnARM
X-MS-Office365-Filtering-Correlation-Id: 15ab0376-d032-4306-25bb-08d5b49ee846
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:48:13.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ab0376-d032-4306-25bb-08d5b49ee846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0336
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
