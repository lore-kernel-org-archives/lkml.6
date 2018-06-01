Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeFAQ3m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:29:42 -0400
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:20499
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753103AbeFAQ3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:29:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vvs@virtuozzo.com;
From: Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] lib/mpi: headers cleanup
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Message-ID: <fb2fc1ef-1185-f0a3-d8d0-173d2f97bbaf@virtuozzo.com>
Date: Fri, 1 Jun 2018 19:29:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR08CA0054.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::25) To DB5PR08MB0598.eurprd08.prod.outlook.com
 (2a01:111:e400:52c9::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR08MB0598;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0598;3:L5i+aDKujJGbBMxCk87vdBQchJ5sHwni+LjSqKRO0WSd5zjbJaDa2MR3nNAO9nUsRtZcpU7ZjFhehJLpNiArVzIBVdMS1g331YLdT3fExNS/AEBEwZqR6uD+UD7dhR3Iks5tYdrSUmWX/zNV0KY3B28lCVtmQaeMA0hj/5Slghq0aVqKsbLTkHsKON+Ksr0KwaOq3WVe5chknrj7gdJAB+mvtOK6zpAGzc9tx7LoMHQzNLUy5jXqaH0oyPf9bykM;25:RdT9lEfgxbARxWVRoh0RPXmn5j6SDaWyFojIB+ByTd96LSWWes6g+3ER7HlKP9o/5t8RfMs3m8U6xRQ23wy6/9Hu8bdheL3LgKKx4rexZs9WB71dSsPXMQVdahVCBzD9+w0pruTwRgvTMPzAGW3gQPhcE5F9OAKwW3uFdhpM7ufYRA3BJ7CmiFxHe9oUy1q+zs+lf+8eEmsGKEYJGJLJyj9MUWNGiJtwXhpOvHijh721Pa6+cGVbwQaOw8mIPbjEqVkIDzw9cHVo7GPnLdG44KYmBMJlzjlY//QwuIwqhuQbH7ot8uJouDCVN+XZzdufzyfM7fXw+RmiSaWP93B7sg==;31:+iFdY7MG/LTHJEQLB2kVmaWL5kcAEtQNLwfEgvmRsmwKbiW+9v5OPP/EXerBgXq4TAi/yKnU3HplXp+19k1t3S/FMcsPxsEMx2w32lbQvRrdxjSE9TJizEmb5+LDlo566av1y50+dEhaEyA+8C9hZ2FBEUh5Z62JY/GMwJEfvTAyYI5MkMSN5+dIzvewBO2m+tmytUhnwPZHjO7ewRE8TV83F6125uSFfSUz5TZpBVI=
X-MS-TrafficTypeDiagnostic: DB5PR08MB0598:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0598;20:G1IAzNUDtc/3P1GtgBThZrvklFzBEOUT1bN+SL55VZf0X+zsOK1qDWRJI+oAyKocwNtJO3JEgPzzaqYI1a/RxKzV/5ODgaoF5Q5kyMZDlKUs5cpSA6kIUgIXJZxQhQuhVE7EWSPfwPcw3gzEm/jUZ3UWqBGtMhQtAumF36ic2xvfE7QTJ8qx+voY5ZbJLe253ksP4uLCZmtVjGkAuPFTx913zjFo5k6BdyiMyFMAJ5FNpUNz/ENDV10eMl+VA2GpUIpGENjCHEpPKKO5h353+oRpT7jl6dF8Cpfx545ZVJc7BrQUQ0G01LYuXh0+FD74SFl5Q8pdPGuwOd5pWfDv+6DHCZ8+G5HDhVrM55a+BL9GaGsEquckGaB6H5mNU14aHk8R5rEWm3xYav4Ou8HsaTjmSpQG79hcFKXaAKxpQk2OgG02PTNlrGYb+arW+Y7+mjVEWVmhiUXYAjmjN3LONtHmny4qq3QbtIAf8zmqeZxAZ3lhdTt+g7L8/TR6PG8X;4:C4LkUspBTKtC+VEx6j+1g++0hjqtbejR5Gt467edIaVd6nwTuf9cmSbKfmHwMNycLGe5/tctThE2EJxsO0jeZSarVxZkZ4QSNICrllOD77rnIX4CaxRr5RLXg6OlVfZbAEXN9cTe+aDHg6ji7soS55C4fKc3T04TfPJSoQT6hDcCD58et7qBNTcJ6239bk0ZIPByB7RDhSa6Z5mLReJ16l2r7F0FuvCE92AMZ1rIclxDaFSqGHTBDkdwVgx0WaibF1zqZMsh04Y3PpT/oEGVmZhub1j2gx3Aslqv0fTONzYt9+KQ2GS3jkqZJc3biqKo
X-Microsoft-Antispam-PRVS: <DB5PR08MB0598D99C8DA0FC7A81F24616AA620@DB5PR08MB0598.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB5PR08MB0598;BCL:0;PCL:0;RULEID:;SRVR:DB5PR08MB0598;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(366004)(346002)(39850400004)(39380400002)(199004)(189003)(6116002)(386003)(47776003)(65806001)(65956001)(68736007)(230700001)(2906002)(478600001)(66066001)(52116002)(23676004)(2486003)(305945005)(55236004)(7736002)(26005)(77096007)(52146003)(6486002)(186003)(1857600001)(486006)(8936002)(58126008)(16576012)(36756003)(316002)(65826007)(86362001)(64126003)(31696002)(3846002)(956004)(2616005)(476003)(8676002)(16526019)(53936002)(4326008)(97736004)(81156014)(25786009)(106356001)(6666003)(81166006)(50466002)(105586002)(31686004)(5660300001)(21314002)(42262002)(376344003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR08MB0598;H:[172.16.24.21];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjVQUjA4TUIwNTk4OzIzOnJsdThoYnVpNjVoMnQxaEpGYWlJcUExWFla?=
 =?utf-8?B?Qlk3MHlRaUh2ZFlpVkhsRDdCYW9tdHZOSTBpMzI0eVJ3MVJHZ2JVREtCTG5G?=
 =?utf-8?B?WEJNUUwxemNqeUovejlWK3NvR0ZBalFjcnptMG9ORkkwdWpGbHZETGNmM2NV?=
 =?utf-8?B?MDVjVDNSOXBDUjc5L2NaVXByQnNhUnkwTGZkdW9qMXhpNnBlQ3N5MUJyTTZE?=
 =?utf-8?B?ZTZVbkJzQnEyZFd3R3o3UEVmajhGeWhjaEliek96Z3FHTGtBdzczL1lhQWF1?=
 =?utf-8?B?YXN4VTlPOC9OalhmU1hzSmVrMHZvbnAwZVhpQkh1R3VUZStBejU0TUhxOGxq?=
 =?utf-8?B?OEYrN1JPUVU3ZktyUDZabzhIZFNoY05rYWZ3SnMwOTVUNGptQkZnczRnUGh2?=
 =?utf-8?B?Z3RpcVROZktxQWZYbHVWOUdtd2RCMkVIQzZMa0oxcTlVZDd0R280YmtDYXJM?=
 =?utf-8?B?RU1oYjlLS2prUzF6Wlo4c0lGN3VlWUZvTEdLZHBCcngzOWhnSTUvNHhPMXo4?=
 =?utf-8?B?cUYwUHdFOUJ6eVpoZTQrT2lsTFhORkQ3bGFRTG5qeHh2NXo1dFlPV0pWN2hM?=
 =?utf-8?B?K2NlSGlKVnR6aTBTNGdjNmdtWkdhd2N3L2tPUWVzdG1pbUZZck55ZmhKTm5k?=
 =?utf-8?B?clNET0NVZGtsc0lKeVFLTjdsa2NtSWE0a0dtOVY0VjYxTnJUV3RNQVAwYlZJ?=
 =?utf-8?B?TGdPU0M0S0hQVk55bDg3akJVbWh5Z2lZRjRlQksramZoNFIzKzJUTlNzOXJu?=
 =?utf-8?B?cEVTQ0ltMGZUTW4xRzZiSVVEUGVReWV6N01xY05Fb0Jyd2Mvcjg0RTA4Lzkw?=
 =?utf-8?B?Y1hscEtHdTN2ckM4MzIzSjI1WDdlRG1DWXI5UnZlcW1aTFRKTlVabUl3cmVI?=
 =?utf-8?B?Mlkrc0tmT1hIZWI2MmFya2xWQUpyNmE1ZGJncm5MVlZuSmVWdU82Tkk4cTl3?=
 =?utf-8?B?MTlzVFlaMDZHcVBONlFtdDVOaEdmb2tjK29TZndqV2Z1MzUvNU4ycFp4Y0Fa?=
 =?utf-8?B?cUt0QlZ1ZUNMY2xjSzQvUlVCUWJacms3Q2JrbWcyNE94eWR1dWRPNkEzL3Y3?=
 =?utf-8?B?Z0VGVTVnT1NWWW8rd1ZpaUhjb3RqK3hMNnJLd1MwNVZlblFKZmprOHgrVERw?=
 =?utf-8?B?RElXYmV3WVlFeGRHcGF3WkQ2d3E4R01MMWNQajc2NWZKdzdibGRCZTdxNklV?=
 =?utf-8?B?dk9tZGdDSFNqRjc2YlIxZll1WWFZNDVjdlAzQ1V1Z0N1cFlvUUt3T1JXeVFS?=
 =?utf-8?B?ZnYvbzd6dkx1Z0ZFWnh6QXZwL0lWN0JoWlA1RmtQcWRPNDhEK3BXcU8yWUhz?=
 =?utf-8?B?SDV6UWt0VGVJRThBaUdCd2E3ejYvSVVhR0tUWjVBRkNSVHlseVRldkc1TzJH?=
 =?utf-8?B?Z1BsbzFpUVhLelZmWnZMRy9rbHVkRi9ZcEtRakJ1WW85Z0pDekFQaWRHaXNP?=
 =?utf-8?B?ZnhIZlMyeWFBTEFsUDFYUk8xUEhjeHdnWWJBckM5TWlaQW0rRlpxd1hld1Vx?=
 =?utf-8?B?c3RTZUVxRHZzMHdpekNrZ092dnZUOFg4dG5lWFJrNTE3eTRwMUYzWFRHUWta?=
 =?utf-8?B?Tnc5YXZoeVM1UFhsYWNnVStreVY2NllGYm5XS1VWQStLNUc4VXRYbjE4bTND?=
 =?utf-8?B?WkttU01kZnZQSVVsZVJ6ZHkxSit3bktKeGhCWC9Cb1VoK202dWNEeHo4THdV?=
 =?utf-8?B?eE5QM1cvcjJtbkd6blZ6czM3UDFJODNKRjFQRUY5L2RKMWk1SWdYdi9KUWJW?=
 =?utf-8?B?WFJMZGdMVmdtc21ycFlGMUw1bndrSkNxYm5Hbm4vRGNTb01adUNVbnNPZG5U?=
 =?utf-8?B?YlNuZkxVeUF6S3BFR0dNaVgwWlFwWkZxbFJIOW5wbEhJL3JINk1wNjVKNmEv?=
 =?utf-8?Q?043P1wLu4/ZcwPxKDnvEprOCAgWqTvnv?=
X-Microsoft-Antispam-Message-Info: wNsPEVgjP8bLNdjmO3nTFdOKs2IX2lO0R50bSN8bRkZzJuNDpxr+JR0VMJUNfRvzU4ap+0RpVfe+3D3ossL4P4JowAI3081DM26PN37RjUO6S1vGpCBAdmiiCpPP3Jx7p3ykG174ZRwUU+ofGjXdRZCZffpjTX5cAZwoE+8HMx6ypkiazn2kwE7yPUA8yr1m
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0598;6:Svcv73Tond/+BO9RtxxgI8W5LYiFNMkhb1PpgBOTF4iDCjsL4KBVIbGBEKq2DOvgRw/T4tboz7Ta4gLQ9Kb+pwrJhTr02lpyqjQiTyC4S3kZO2to4N0U+ineYCAID2yy0HrSx+Ks9mJ5rUKoERttVTDZvMIaxZNvnFgUBr2KJb+VzvWslbSO5fe3mw6v6qrHUkgEg11+siSoqGgnvIha2S9oSvnJIaheFSi7Bx7ZpstkdKuSHnJ2FhoxMNrd/SSowY3vM75JHbkKjOL3Q3a87qeZKsd/kzpxM/41GUmY+MNuRHNJJWNn3GgpqWMnLTgq9iMNC/9l4LhVkHkcCoXhpxVPr2bieTLczFp0O0C/Aso+sAN2JSIUwbREQIGbMtgrEC/e852Wschryqn/wGtI+fwXBlaw4D/+SaNz65nGRzvLuEEhw/3Nj+uWve28aeWAIaxcS8WTxIaIYm8B/mcVpw==;5:bo5537sVSoRTzgi/yYNGenDywjvXQg34lKkcAOQzTkAraM1lKmRimPHIBOLMu6XkKaCM/br6kkHgKaNEFTHA5jZncq97CUw+99ka7S3Kxr/7z/8lv72lkENJg2W4FfMZLGGZ1ZWBp/rs6ZzWAVgetO/Rrd/vMmA+syycu6NvPWU=;24:GXvZmsQLdWp6OcyrApfS4Xj8R0Qa8UjOi/pZ5vGWhf2sM2+krwyrqnKQc4iZ8zRlGlvmrBgsb7AtlyWA4x863ZAVlUx8S0UbTKQdvcWUNt0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR08MB0598;7:wz86oLl02Q4ygYEykpXvrt3GmM0/jiP4XrMOEhHMokhQAsAs47lz6k4fA6NiAmoZ5y/xtS4WcaH6ZKzOlKG9N4PxM1cJ1dfVsNE6wbfL+9WE9iqf2YZdrbn4aIL9vD7kxygioWtit9lRV0yMZSeavnppJAysuPi+jyZXydQnCu5qMqIAzSCHow07zqqeZ1aubdfr9pA5MTAULrlD7klWy2zGP5XyYWut/fvIlG9sJK/B/dgLzSRXuYTeSQ+yE8Yz;20:QknyyHJnyaQZ1oB9FJSS3okoPuiMfv0+yDCCcO8ND1cWfrL+FXh+LMx+XuErpzOMT+32dXjpkWwDNchvcS68FhAiMR3qZE4ILbwl/hDUor9GFlopba0RK/XUQ41qxaA06/MPRgxPIPEopLdXNn3Ar7mZDv5q/T7SVp772xPG3L0=
X-MS-Office365-Filtering-Correlation-Id: a52fa733-4d0e-4514-9fae-08d5c7dcdad5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 16:29:31.6427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a52fa733-4d0e-4514-9fae-08d5c7dcdad5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB0598
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPI headers contain definitions for huge number of non-existing functions.
Most part of these functions was removed in 2012 by Dmitry Kasatkin
commit 7cf4206a99d1 ("Remove unused code from MPI library")
commit 9e235dcaf4f6 ("Revert "crypto: GnuPG based MPI lib - additional ...")
commit bc95eeadf5c6 ("lib/mpi: removed unused functions")
however headers was not updated properly.

Also I deleted some unused macros.

cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 include/linux/mpi.h    | 61 ----------------------------------------
 lib/mpi/mpi-internal.h | 75 ++++----------------------------------------------
 2 files changed, 5 insertions(+), 131 deletions(-)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index 1cc5ffb..7cd1473 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -53,93 +53,32 @@ struct gcry_mpi {
 typedef struct gcry_mpi *MPI;
 
 #define mpi_get_nlimbs(a)     ((a)->nlimbs)
-#define mpi_is_neg(a)	      ((a)->sign)
 
 /*-- mpiutil.c --*/
 MPI mpi_alloc(unsigned nlimbs);
-MPI mpi_alloc_secure(unsigned nlimbs);
-MPI mpi_alloc_like(MPI a);
 void mpi_free(MPI a);
 int mpi_resize(MPI a, unsigned nlimbs);
-int mpi_copy(MPI *copy, const MPI a);
-void mpi_clear(MPI a);
-int mpi_set(MPI w, MPI u);
-int mpi_set_ui(MPI w, ulong u);
-MPI mpi_alloc_set_ui(unsigned long u);
-void mpi_m_check(MPI a);
-void mpi_swap(MPI a, MPI b);
 
 /*-- mpicoder.c --*/
-MPI do_encode_md(const void *sha_buffer, unsigned nbits);
 MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
 MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
 MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int len);
-int mpi_fromstr(MPI val, const char *str);
-u32 mpi_get_keyid(MPI a, u32 *keyid);
 void *mpi_get_buffer(MPI a, unsigned *nbytes, int *sign);
 int mpi_read_buffer(MPI a, uint8_t *buf, unsigned buf_len, unsigned *nbytes,
 		    int *sign);
-void *mpi_get_secure_buffer(MPI a, unsigned *nbytes, int *sign);
 int mpi_write_to_sgl(MPI a, struct scatterlist *sg, unsigned nbytes,
 		     int *sign);
 
-#define log_mpidump g10_log_mpidump
-
-/*-- mpi-add.c --*/
-int mpi_add_ui(MPI w, MPI u, ulong v);
-int mpi_add(MPI w, MPI u, MPI v);
-int mpi_addm(MPI w, MPI u, MPI v, MPI m);
-int mpi_sub_ui(MPI w, MPI u, ulong v);
-int mpi_sub(MPI w, MPI u, MPI v);
-int mpi_subm(MPI w, MPI u, MPI v, MPI m);
-
-/*-- mpi-mul.c --*/
-int mpi_mul_ui(MPI w, MPI u, ulong v);
-int mpi_mul_2exp(MPI w, MPI u, ulong cnt);
-int mpi_mul(MPI w, MPI u, MPI v);
-int mpi_mulm(MPI w, MPI u, MPI v, MPI m);
-
-/*-- mpi-div.c --*/
-ulong mpi_fdiv_r_ui(MPI rem, MPI dividend, ulong divisor);
-int mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor);
-int mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor);
-int mpi_fdiv_qr(MPI quot, MPI rem, MPI dividend, MPI divisor);
-int mpi_tdiv_r(MPI rem, MPI num, MPI den);
-int mpi_tdiv_qr(MPI quot, MPI rem, MPI num, MPI den);
-int mpi_tdiv_q_2exp(MPI w, MPI u, unsigned count);
-int mpi_divisible_ui(const MPI dividend, ulong divisor);
-
-/*-- mpi-gcd.c --*/
-int mpi_gcd(MPI g, const MPI a, const MPI b);
-
 /*-- mpi-pow.c --*/
-int mpi_pow(MPI w, MPI u, MPI v);
 int mpi_powm(MPI res, MPI base, MPI exp, MPI mod);
 
-/*-- mpi-mpow.c --*/
-int mpi_mulpowm(MPI res, MPI *basearray, MPI *exparray, MPI mod);
-
 /*-- mpi-cmp.c --*/
 int mpi_cmp_ui(MPI u, ulong v);
 int mpi_cmp(MPI u, MPI v);
 
-/*-- mpi-scan.c --*/
-int mpi_getbyte(MPI a, unsigned idx);
-void mpi_putbyte(MPI a, unsigned idx, int value);
-unsigned mpi_trailing_zeros(MPI a);
-
 /*-- mpi-bit.c --*/
 void mpi_normalize(MPI a);
 unsigned mpi_get_nbits(MPI a);
-int mpi_test_bit(MPI a, unsigned n);
-int mpi_set_bit(MPI a, unsigned n);
-int mpi_set_highbit(MPI a, unsigned n);
-void mpi_clear_highbit(MPI a, unsigned n);
-void mpi_clear_bit(MPI a, unsigned n);
-int mpi_rshift(MPI x, MPI a, unsigned n);
-
-/*-- mpi-inv.c --*/
-int mpi_invm(MPI x, MPI u, MPI v);
 
 /* inline functions */
 
diff --git a/lib/mpi/mpi-internal.h b/lib/mpi/mpi-internal.h
index 7eceedd..c2d6f4e 100644
--- a/lib/mpi/mpi-internal.h
+++ b/lib/mpi/mpi-internal.h
@@ -65,13 +65,6 @@
 typedef mpi_limb_t *mpi_ptr_t;	/* pointer to a limb */
 typedef int mpi_size_t;		/* (must be a signed type) */
 
-static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
-{
-	if (a->alloced < b)
-		return mpi_resize(a, b);
-	return 0;
-}
-
 /* Copy N limbs from S to D.  */
 #define MPN_COPY(d, s, n) \
 	do {					\
@@ -80,13 +73,6 @@ static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
 			(d)[_i] = (s)[_i];	\
 	} while (0)
 
-#define MPN_COPY_INCR(d, s, n) \
-	do {					\
-		mpi_size_t _i;			\
-		for (_i = 0; _i < (n); _i++)	\
-			(d)[_i] = (s)[_i];	\
-	} while (0)
-
 #define MPN_COPY_DECR(d, s, n) \
 	do {					\
 		mpi_size_t _i;			\
@@ -111,15 +97,6 @@ static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
 		}				\
 	} while (0)
 
-#define MPN_NORMALIZE_NOT_ZERO(d, n) \
-	do {				\
-		for (;;) {		\
-			if ((d)[(n)-1])	\
-				break;	\
-			(n)--;		\
-		}			\
-	} while (0)
-
 #define MPN_MUL_N_RECURSE(prodp, up, vp, size, tspace) \
 	do {							\
 		if ((size) < KARATSUBA_THRESHOLD)		\
@@ -128,46 +105,11 @@ static inline int RESIZE_IF_NEEDED(MPI a, unsigned b)
 			mul_n(prodp, up, vp, size, tspace);	\
 	} while (0);
 
-/* Divide the two-limb number in (NH,,NL) by D, with DI being the largest
- * limb not larger than (2**(2*BITS_PER_MP_LIMB))/D - (2**BITS_PER_MP_LIMB).
- * If this would yield overflow, DI should be the largest possible number
- * (i.e., only ones).  For correct operation, the most significant bit of D
- * has to be set.  Put the quotient in Q and the remainder in R.
- */
-#define UDIV_QRNND_PREINV(q, r, nh, nl, d, di) \
-	do {								\
-		mpi_limb_t _q, _ql, _r;					\
-		mpi_limb_t _xh, _xl;					\
-		umul_ppmm(_q, _ql, (nh), (di));				\
-		_q += (nh);	/* DI is 2**BITS_PER_MPI_LIMB too small */ \
-		umul_ppmm(_xh, _xl, _q, (d));				\
-		sub_ddmmss(_xh, _r, (nh), (nl), _xh, _xl);		\
-		if (_xh) {						\
-			sub_ddmmss(_xh, _r, _xh, _r, 0, (d));		\
-			_q++;						\
-			if (_xh) {					\
-				sub_ddmmss(_xh, _r, _xh, _r, 0, (d));	\
-				_q++;					\
-			}						\
-		}							\
-		if (_r >= (d)) {					\
-			_r -= (d);					\
-			_q++;						\
-		}							\
-		(r) = _r;						\
-		(q) = _q;						\
-	} while (0)
-
 /*-- mpiutil.c --*/
 mpi_ptr_t mpi_alloc_limb_space(unsigned nlimbs);
 void mpi_free_limb_space(mpi_ptr_t a);
 void mpi_assign_limb_space(MPI a, mpi_ptr_t ap, unsigned nlimbs);
 
-/*-- mpi-bit.c --*/
-void mpi_rshift_limbs(MPI a, unsigned int count);
-int mpi_lshift_limbs(MPI a, unsigned int count);
-
-/*-- mpihelp-add.c --*/
 static inline mpi_limb_t mpihelp_add_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_add_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
@@ -175,7 +117,6 @@ mpi_limb_t mpihelp_add_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 static inline mpi_limb_t mpihelp_add(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
 		       mpi_ptr_t s2_ptr, mpi_size_t s2_size);
 
-/*-- mpihelp-sub.c --*/
 static inline mpi_limb_t mpihelp_sub_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_sub_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
@@ -183,10 +124,10 @@ mpi_limb_t mpihelp_sub_n(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 static inline mpi_limb_t mpihelp_sub(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr, mpi_size_t s1_size,
 		       mpi_ptr_t s2_ptr, mpi_size_t s2_size);
 
-/*-- mpihelp-cmp.c --*/
+/*-- mpih-cmp.c --*/
 int mpihelp_cmp(mpi_ptr_t op1_ptr, mpi_ptr_t op2_ptr, mpi_size_t size);
 
-/*-- mpihelp-mul.c --*/
+/*-- mpih-mul.c --*/
 
 struct karatsuba_ctx {
 	struct karatsuba_ctx *next;
@@ -202,7 +143,6 @@ mpi_limb_t mpihelp_addmul_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			    mpi_size_t s1_size, mpi_limb_t s2_limb);
 mpi_limb_t mpihelp_submul_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			    mpi_size_t s1_size, mpi_limb_t s2_limb);
-int mpihelp_mul_n(mpi_ptr_t prodp, mpi_ptr_t up, mpi_ptr_t vp, mpi_size_t size);
 int mpihelp_mul(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t usize,
 		mpi_ptr_t vp, mpi_size_t vsize, mpi_limb_t *_result);
 void mpih_sqr_n_basecase(mpi_ptr_t prodp, mpi_ptr_t up, mpi_size_t size);
@@ -214,21 +154,16 @@ int mpihelp_mul_karatsuba_case(mpi_ptr_t prodp,
 			       mpi_ptr_t vp, mpi_size_t vsize,
 			       struct karatsuba_ctx *ctx);
 
-/*-- mpihelp-mul_1.c (or xxx/cpu/ *.S) --*/
+/*-- generic_mpih-mul1.c --*/
 mpi_limb_t mpihelp_mul_1(mpi_ptr_t res_ptr, mpi_ptr_t s1_ptr,
 			 mpi_size_t s1_size, mpi_limb_t s2_limb);
 
-/*-- mpihelp-div.c --*/
-mpi_limb_t mpihelp_mod_1(mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-			 mpi_limb_t divisor_limb);
+/*-- mpih-div.c --*/
 mpi_limb_t mpihelp_divrem(mpi_ptr_t qp, mpi_size_t qextra_limbs,
 			  mpi_ptr_t np, mpi_size_t nsize,
 			  mpi_ptr_t dp, mpi_size_t dsize);
-mpi_limb_t mpihelp_divmod_1(mpi_ptr_t quot_ptr,
-			    mpi_ptr_t dividend_ptr, mpi_size_t dividend_size,
-			    mpi_limb_t divisor_limb);
 
-/*-- mpihelp-shift.c --*/
+/*-- generic_mpih-[lr]shift.c --*/
 mpi_limb_t mpihelp_lshift(mpi_ptr_t wp, mpi_ptr_t up, mpi_size_t usize,
 			  unsigned cnt);
 mpi_limb_t mpihelp_rshift(mpi_ptr_t wp, mpi_ptr_t up, mpi_size_t usize,
-- 
2.7.4
