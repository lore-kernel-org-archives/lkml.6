Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbeEBEkz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 00:40:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750822AbeEBEkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 00:40:51 -0400
From: Song Liu <songliubraving@fb.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "Linux-Next Mailing List" <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
Thread-Topic: linux-next: manual merge of the bpf-next tree with the bpf tree
Thread-Index: AQHT4bqqrCyw41qupE6Snx2x08TdlqQb2+IA
Date: Wed, 2 May 2018 04:40:20 +0000
Message-ID: <0942C278-336F-4795-BE63-FAD7FBAA231B@fb.com>
References: <20180502120921.654cc338@canb.auug.org.au>
In-Reply-To: <20180502120921.654cc338@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:3698]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1194;7:JNqTTTWYRfWCmQ5zKl72tZgm3wZ2Ogri0QatJfxXywqULDJzcvdGNjIVVkrbscJkecpx26m6mnAo+XvqYUtq7lGdcIhA8dSU8FbJZFg9crxa7fQILaQo0r7j/loIqcsuk88AaXtUlu6Qw4HCIqHpRd0hV1AUgJL5oqbQL1wvnFLRoDO3KNZe34K2AsmfnioqYybr1NltO1wIzRE91HlS6PNiN28QW/O5ruewCG24lSonZ44cf8o+n0s6s8a//tX3;20:7tBK/I5AQYTtxp/PVEG9OpZiSU+siGsnTyOCdu/JuVHSTXgJ3yXvhf6uUWydN/+Sa00YlNIrRi6Hrfa7Nwc+hTTb1pcFmxWPKrE5oG5nqt15LI417wvtkBA4tvG2G9MCFX075puMrWB6tbPH7ZMPpO3x6iXV+3AYfiXKRznsVJ4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(366004)(39860400002)(346002)(199004)(189003)(53754006)(83716003)(6506007)(102836004)(53936002)(53546011)(6512007)(106356001)(36756003)(575784001)(6436002)(5660300001)(76176011)(33656002)(86362001)(97736004)(57306001)(99286004)(105586002)(478600001)(25786009)(54906003)(446003)(2906002)(3280700002)(14454004)(81166006)(229853002)(6246003)(81156014)(68736007)(6916009)(50226002)(8936002)(82746002)(3660700001)(5250100002)(46003)(8676002)(305945005)(6486002)(2900100001)(2616005)(476003)(11346002)(486006)(4326008)(6116002)(316002)(186003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1194;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1194;
x-ms-traffictypediagnostic: DM5PR15MB1194:
x-microsoft-antispam-prvs: <DM5PR15MB1194B45F07AF1457F7E7A4D3B3800@DM5PR15MB1194.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR15MB1194;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1194;
x-forefront-prvs: 06607E485E
x-microsoft-antispam-message-info: 5AhmYinLiYvet4ZuW9zOs/7rykKCBWVPPQf/Jh7vfSTXfXxkBAV1CG7QlTf+MeCnr9QyOkCobllLPq0QKe8njKs2eLmnGRmtch0RZVpjdNQ3ZPk6mxksZpz8Gmy2SJNhIOvmlotugRCtvgK8djJRbte5jX0uPJvRyKabdGgZ0DZjUN/MIm/P9r9aHJrav5dX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E61EC67A3C5E7C459973C23488EB61CB@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f1f11003-3832-4926-0f30-08d5afe6cfb0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f11003-3832-4926-0f30-08d5afe6cfb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 04:40:20.2835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1194
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w424f10e008982



> On May 1, 2018, at 7:09 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>  tools/testing/selftests/bpf/test_progs.c
> 
> between commit:
> 
>  a4e21ff8d9a3 ("bpf: minor fix to selftest test_stacktrace_build_id()")
> 
> from the bpf tree and commit:
> 
>  79b453501310 ("tools/bpf: add a test for bpf_get_stack with tracepoint prog")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc tools/testing/selftests/bpf/test_progs.c
> index fac581f1c57f,aa336f0abebc..000000000000
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@@ -1137,9 -1193,14 +1193,14 @@@ static void test_stacktrace_build_id(vo
>  		  err, errno))
>  		goto disable_pmu;
> 
> + 	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
> + 	if (CHECK(stack_amap_fd < 0, "bpf_find_map stack_amap",
> + 		  "err %d errno %d\n", err, errno))
> + 		goto disable_pmu;
> + 
>  	assert(system("dd if=/dev/urandom of=/dev/zero count=4 2> /dev/null")
>  	       == 0);
> -	assert(system("./urandom_read if=/dev/urandom of=/dev/zero count=4 2> /dev/null") == 0);
> +	assert(system("./urandom_read") == 0);
>  	/* disable stack trace collection */
>  	key = 0;
>  	val = 1;
> @@@ -1188,8 -1249,15 +1249,15 @@@
>  		previous_key = key;
>  	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
> 
> - 	CHECK(build_id_matches < 1, "build id match",
> - 	      "Didn't find expected build ID from the map\n");
> + 	if (CHECK(build_id_matches < 1, "build id match",
> -		  "Didn't find expected build ID from the map"))
> ++		  "Didn't find expected build ID from the map\n"))

^^^  Is there a "+" at the beginning of this line? 

Thanks,
Song

> + 		goto disable_pmu;
> + 
> + 	stack_trace_len = PERF_MAX_STACK_DEPTH
> + 		* sizeof(struct bpf_stack_build_id);
> + 	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
> + 	CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
> + 	      "err %d errno %d\n", err, errno);
> 
>  disable_pmu:
>  	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
