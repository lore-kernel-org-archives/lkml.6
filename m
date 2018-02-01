Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeBAXWU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:22:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56448 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751530AbeBAXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:22:12 -0500
From: Song Liu <songliubraving@fb.com>
To: Joe Perches <joe@perches.com>
CC: Andy Whitcroft <apw@canonical.com>, Kernel Team <Kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: False positive of "open brace '{' following function
 declarations" in checkpatch.pl
Thread-Topic: False positive of "open brace '{' following function
 declarations" in checkpatch.pl
Thread-Index: AQHTm68fmlC6CWEygE+nhcagifqOTKOQLdYAgAABuIA=
Date: Thu, 1 Feb 2018 23:22:02 +0000
Message-ID: <C897C365-ED74-436A-A4E5-99EB22ADB7F3@fb.com>
References: <01433B62-D050-4A86-83AB-485BB0FA2F3D@fb.com>
 <1517526952.7489.85.camel@perches.com>
In-Reply-To: <1517526952.7489.85.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.5.20)
x-originating-ip: [2620:10d:c090:200::5:9e97]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR15MB1159;7:97s8m2SA2rd6MCIdifYflaf0Fta7KC/uBuLUjggvR2y3x+7NTyTr0gGJ0GtEusXOt81qNd7E6chLlZuNQLQFG6wGXqcgDZuJXRxZxs4PENczCAifpH/n1EvBsr1UHrHsh8DDnrqfu3fEo1ElDCR86qw6TiltTXuoQ9EI40UCUfcsr8wnvzZC50yC94PmDZRQnssn//01TtCqA5T0AKDOkjAPdo3iCrJozTwgFEGHGl99R3wuLqX2I31QfPQWYsVO;20:tkWci8rpBRVq7Q6DKd3vz52KQbcmO2bf1lIBOOQIFfr+Z6ct2sQAQgUC/D3nDYp0j+SifVn/YvNQ0s56cvtDa0YlR2PR5BkcT3Z7SExYyjyfgU4ieMK92yF68JPwjeIXoaj3dGFxJOPW5vJ4HbNO8RHVg9GHJ/q5eJm1t/1c6N8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 6d4796cb-1622-4a8d-406b-08d569ca9998
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1159;
x-ms-traffictypediagnostic: CY4PR15MB1159:
x-microsoft-antispam-prvs: <CY4PR15MB1159B525054D99F64F307F76B3FA0@CY4PR15MB1159.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(11241501184)(2400082)(944501161)(93006095)(93001095)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR15MB1159;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1159;
x-forefront-prvs: 0570F1F193
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(377424004)(199004)(189003)(3280700002)(3660700001)(316002)(478600001)(305945005)(102836004)(81166006)(83716003)(77096007)(4326008)(105586002)(76176011)(6246003)(2950100002)(106356001)(50226002)(186003)(8936002)(6916009)(86362001)(54906003)(575784001)(2906002)(81156014)(82746002)(36756003)(6116002)(6486002)(8676002)(5660300001)(25786009)(53546011)(7736002)(97736004)(68736007)(6512007)(229853002)(53936002)(57306001)(6506007)(33656002)(2900100001)(14454004)(6436002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1159;H:CY4PR15MB1512.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PHYma93X9eAWxnFlYUztzykwLECbtuaOtm/5kPQq10oh4WfNiAFQ00Q8oqUpXEnRgLYbUDk51B7ObOyhXuiG8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DC3EA8508A95B42ACBF1B58E4FCFF01@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4796cb-1622-4a8d-406b-08d569ca9998
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 23:22:02.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w11NMOKh010429

Thanks Joe! This patch eliminates the ERROR. 

Song

> On Feb 1, 2018, at 3:15 PM, Joe Perches <joe@perches.com> wrote:
> 
> On Thu, 2018-02-01 at 22:50 +0000, Song Liu wrote:
>> Hi Andy and Joe, 
>> 
>> I am getting the following ERROR from check patch.pl:
>> 
>> ERROR: open brace '{' following function declarations go on the next line
>> #235: FILE: tools/testing/selftests/bpf/test_stacktrace_map_build_id_offset.c:11:
>> +struct bpf_map_def SEC("maps") control_map = {
>> 
>> 
>> I guess it treats SEC("maps") as a function. But it is actually struct:
>> 
>> struct bpf_map_def SEC("maps") control_map = {
>>        .type = BPF_MAP_TYPE_ARRAY,
>>        .key_size = sizeof(__u32),
>>        .value_size = sizeof(__u32),
>>        .max_entries = 1,
>> };
> 
> This seems to work better:
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 78e7a310af46..b6a0da9c7de7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3919,8 +3919,10 @@ sub process {
> 
> # function brace can't be on same line, except for #defines of do while,
> # or if closed on same line
> -		if (($line=~/$Type\s*$Ident\(.*\).*\s*{/) and
> -		    !($line=~/\#\s*define.*do\s\{/) and !($line=~/}/)) {
> +		if ($^V && $^V ge 5.10.0 &&
> +		    ($sline =~ /$Type\s*$Ident\s*$balanced_parens\s*{/) &&
> +		    !($sline =~ /\#\s*define\b.*do\s*\{/) &&
> +		    $sline !~ /}/) {
> 			if (ERROR("OPEN_BRACE",
> 				  "open brace '{' following function declarations go on the next line\n" . $herecurr) &&
> 			    $fix) {
> 
