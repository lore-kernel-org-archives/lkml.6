Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeDJT6Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:58:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45528 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752345AbeDJT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:58:14 -0400
From: Song Liu <songliubraving@fb.com>
To: Vince Weaver <vincent.weaver@maine.edu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: perf: fuzzer leads to trace_kprobe: Could not insert message
 flood
Thread-Topic: perf: fuzzer leads to trace_kprobe: Could not insert message
 flood
Thread-Index: AQHT0NsKF6lgcxb36UeZZJCEysMOEaP6arGA
Date: Tue, 10 Apr 2018 19:57:50 +0000
Message-ID: <A3B3905F-3364-462A-BE02-B01D52482791@fb.com>
References: <alpine.DEB.2.21.1804101043490.6068@macbook-air>
In-Reply-To: <alpine.DEB.2.21.1804101043490.6068@macbook-air>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:200::6:6de2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1756;7:uaxyyk7I076fdjaytXgsknRrVM0YuN9SQwM7M718FJo4T9fD+noItaBUL1DztK6lNvV5ILu28YgOoSxYWjtcQTejnumZPM0rJWSJrvoGPjwWjWc4Mc4bVn8JtedydbAIbZctbxw/900A8/5FDgCC7vkZzCh8l+VzCT1g+xi6MyDz178bTtxVhB4nAloS+0UcBZYmxOToIwVhftNdByli0hNlzYihaOzua2ljOOe4A+7it+Cqhpj5+91n6ee4UR58;20:h0YWn2LtKQQg+bNa2VI60PAEtO2gnPnWzLg069r3DAApDbilrKyGOvpFLjQm2tHq5sOU5BQVr00ZAYjOmX05yTghjUlXZAyn353/aHPa8fzMPaoRhDblVbg1M6ibwbNgiUMAYdVdow0xvfuhV+wpksjVsJJJVHb/896otRvFuRU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1756;
x-ms-traffictypediagnostic: DM5PR15MB1756:
x-microsoft-antispam-prvs: <DM5PR15MB17565A6C605177B9B161D809B3BE0@DM5PR15MB1756.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(15185016700835)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR15MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1756;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(51914003)(199004)(189003)(36756003)(229853002)(6306002)(966005)(8936002)(76176011)(305945005)(99286004)(25786009)(106356001)(2900100001)(5660300001)(6486002)(478600001)(57306001)(6916009)(86362001)(102836004)(8676002)(186003)(6246003)(3280700002)(3660700001)(97736004)(446003)(81156014)(53936002)(5250100002)(6506007)(46003)(486006)(81166006)(6512007)(105586002)(68736007)(53546011)(50226002)(83716003)(316002)(54906003)(2906002)(4326008)(2171002)(11346002)(2616005)(14454004)(33656002)(476003)(6116002)(15650500001)(82746002)(6436002)(7736002)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1756;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: n3xxTTncDOg0tKJnWtPRqxdnkfC32VcXbFv1/ea/IZOzmopQ92FwIUx3Ouz2B669CCGeyGry9Oxi2xBDptzWcNdy11bM9b9Cdk5CWuIv9+VfrGiNBuIdwvWGSO1evtfc4njvabRylrEz+vAu+q+4HRPXMNzuTvlBLKBHYLVnbesG3pMvZPk082m6pTy/geL90vavRTiVFgiTdQrIVv5WssfAyP+tbkI03f5dFIPM+B1VqRNWK+JTfdzMluJg2ozBqtfxcRZzZg8KRaw0/5QDhKur1VWOeDM3pqNVdnJwYD2pl64SCau3656Xo8XJEH8Cus1fe/GpYPdOwkJ7xf4r7rJoRmWmNTym3kNs1Om92irY+3LFhVFp8Z6fCcAeB689oR3fbrFiQ0Te04S7+fBQjx7T9DnZChws3RYf/yZvrZs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A339817453B4AD45A5871491263FE1B6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cef312a2-4033-455f-f7cb-08d59f1d5741
X-MS-Exchange-CrossTenant-Network-Message-Id: cef312a2-4033-455f-f7cb-08d59f1d5741
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 19:57:50.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-10_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3AJwM0N024844



> On Apr 10, 2018, at 7:48 AM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> 
> Author: Song Liu <songliubraving@fb.com>
> Date:   Wed Dec 6 14:45:15 2017 -0800
> 
> When running the perf_fuzzer on a current git checkout my logs are flooded 
> with messages such as this:
> [71487.869077] trace_kprobe: Could not insert probe at unknown+0: -22
> [71488.174479] trace_kprobe: Could not insert probe at unknown+0: -22
> 
> Presumably this is due to the introduction of the perf_kprobe PMU in
> 	commit e12f03d7031a977356e3d7b75a68c2185ff8d155
> 	Author: Song Liu <songliubraving@fb.com>
> 	Date:   Wed Dec 6 14:45:15 2017 -0800
> 
> Is there a way to get this error disabled, or else rate-limited?
> 
> Vince

Hi Vince, 

Thanks for the report. 

This is a new API that creates probe together with perf_event_open(). Based on 
my limited understanding of perf_fuzzer, it doesn't understand this API, and uses 
it in an abnormal way. I would recommend perf_fuzzer to understand this new
API and test it. For more information about using this API, please refer to the 
man-page diff available at:

      https://patchwork.kernel.org/patch/10097283/

Thanks again for the test and report. Please let me know if you have further 
questions. 

Best, 
Song
