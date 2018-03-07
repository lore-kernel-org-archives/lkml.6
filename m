Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeCGWep (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:34:45 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933415AbeCGWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:34:44 -0500
From: Sahil Rihan <srihan@fb.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [Regression] TPM char device not created if TPM 1.2 is disabled,
 but visible
Thread-Topic: [Regression] TPM char device not created if TPM 1.2 is disabled,
 but visible
Thread-Index: AQHTszZzFC58ocR1302YTljwLq5BPaPBkKuA///zDoCAAY5DgIABym2A
Date: Wed, 7 Mar 2018 22:34:38 +0000
Message-ID: <7BE685E0-F107-4E1A-A9E1-72DCB58186AE@fb.com>
References: <875E6A7D-483D-4A8F-9382-6B3970598866@fb.com>
 <20180305121445.GA3138@linux.intel.com>
 <7A0881B1-6581-4D0B-A4A9-B014F995B338@fb.com>
 <1520334831.7549.5.camel@linux.intel.com>
In-Reply-To: <1520334831.7549.5.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:96c5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1695;7:RAmomgkArvBcCkzmOV4JA9bWQc7rF340ZX/frFRgQDHO2eXtKwQedMOaJ3xTPfL4NJGDqon6pfDVRnDr64XbH6SKPLtXLuWru37VabKcNr3gU1yCzTS6XGphHqwfS0SBDQwtgeYLIL5X0qlLxMlscpaEBl8pR1zUUFsH46uf3tIor9cOl72ni6ypvGL/HR0++SKGicje2D3ZTsdUHycxlVwuTKAsOGO62ZV27azO5ei/o5vHHSdeXTwuAPCg5nXC;20:zKVnaiCZmcvkdedo5YO8Pr8LOyp9tz9mFrd4+rb/0GNc5McNC92qvOcmdsFWzNnTTFzn1UhqBb1qpv+BpcsDj4yAKMtumHDMWjzl6tvGED0I96PoUurvtHU79psTjKfIkLHhDwAFlOkVQ9bKtiKG6Ua32J1xgoVqcXHG+VmjoC8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(189003)(377424004)(199004)(106356001)(3660700001)(54906003)(59450400001)(82746002)(5250100002)(86362001)(6486002)(2950100002)(6916009)(3280700002)(102836004)(2906002)(316002)(36756003)(229853002)(478600001)(186003)(93886005)(46003)(105586002)(6506007)(53546011)(76176011)(99286004)(5660300001)(8676002)(305945005)(7736002)(25786009)(4326008)(14454004)(81156014)(33656002)(83716003)(81166006)(8936002)(97736004)(2900100001)(6436002)(53936002)(6116002)(6246003)(68736007)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1695;H:MWHPR15MB1149.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-correlation-id: 6233a98c-d656-467a-e2d4-08d5847b9c81
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1695;
x-ms-traffictypediagnostic: MWHPR15MB1695:
x-microsoft-antispam-prvs: <MWHPR15MB16950B77B2B3B0C3C2D2C3C8BED80@MWHPR15MB1695.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(11241501184)(944501244)(52105095)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR15MB1695;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1695;
x-forefront-prvs: 0604AFA86B
x-microsoft-antispam-message-info: 8Akfh73IKS+9QSGCrglnzSiUQ8Mo+T4bBNF56P/CzER7itA5SRNFS+5+2FMgD6Qk2Lxim+aEnznYfNO9/SJyjZW2ELs+XpDV/H8cN1FNiiob3VpuJ5lh2iivwuYedpL4hMOhaOM6t54C417bu2LW4dtIJ9ylSUE2qeWM3p9Txk+P+ABhcMaVfJKMrECIixE2hXawlZW8QIZuABmcV+O5CYlm8ewBUiw19q2qfVQVIDS1pCJsLZmSziLvI3vzT+4Z+UJAWMHMzU73VxZamY8j+tYs4tcJZbeTVDUWOOIBWN0qXz/tFfZGh9msDst5TZQInXlE1HXcRYI3i6W9EiIMYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E302F747007C04D930EDE356E31DDEC@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6233a98c-d656-467a-e2d4-08d5847b9c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 22:34:38.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27MYpSK002228

> On 3/6/18, 3:14 AM, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com> wrote:
> 
>   On Mon, 2018-03-05 at 19:28 +0000, Sahil Rihan wrote:
> > Agree on keeping the warning. 
> > 
> > I'm guessing you want to return -ENODEV from tpm_bios_log_setup. Doing it from
> > tpm_read_log_acpi will just fall through to calling tpm_read_log_of, which I
> > think will end up returning -EIO again.
> > 
> > In terms of semantics I'm not sure if -ENODEV is the right return code if the
> > BIOS event log is absent. I guess you can claim it's some sort of "device". I
> > don’t have a strong opinion here.
> > 
> > Sahil
>     
> You are absolutely right. Printing warning and returning zero would be
> the right measure to take.
>     
> One more cosmetic detail. Should the log level be info or warn? I mean
> as far as I'm concerned everything is in a legit state.
>     
> /Jarkko
   
Yeah, I tend to agree. I think INFO should be fine. 

My reasoning is as follows: if the TPM is disabled, you shouldn't really be checking/using the BIOS event log measurements anyway. 

Sahil
 
