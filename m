Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeCET2i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:28:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34458 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751490AbeCET2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:28:36 -0500
From: Sahil Rihan <srihan@fb.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [Regression] TPM char device not created if TPM 1.2 is disabled,
 but visible
Thread-Topic: [Regression] TPM char device not created if TPM 1.2 is disabled,
 but visible
Thread-Index: AQHTszZzFC58ocR1302YTljwLq5BPaPBkKuA///zDoA=
Date: Mon, 5 Mar 2018 19:28:26 +0000
Message-ID: <7A0881B1-6581-4D0B-A4A9-B014F995B338@fb.com>
References: <875E6A7D-483D-4A8F-9382-6B3970598866@fb.com>
 <20180305121445.GA3138@linux.intel.com>
In-Reply-To: <20180305121445.GA3138@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::4:9f32]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1567;20:bKFq/dUHguwcJtAgn81wk18GrUqgRIOD6MbzMHhE8DH2MVzQ2HXaEMhYLlJ8GNNI0NRucmFSWf4M2vrIIfL9cdnir9KyQevXcVzMemv4rdWd+ySHTBcKI0Uh95NpAGSfdErr4SUHTpI/+SjYxDRCi9adZG6OJdPDXVOln/G8pGY=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(189003)(199004)(51914003)(86362001)(4326008)(53936002)(6436002)(6486002)(82746002)(6246003)(105586002)(2950100002)(6916009)(186003)(2906002)(83716003)(8676002)(76176011)(5660300001)(14454004)(33656002)(99286004)(97736004)(3280700002)(6512007)(316002)(54906003)(6116002)(68736007)(81156014)(2900100001)(8936002)(81166006)(59450400001)(102836004)(478600001)(6506007)(106356001)(5250100002)(3660700001)(46003)(305945005)(229853002)(36756003)(7736002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1567;H:MWHPR15MB1149.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-correlation-id: eb2092dc-eec6-4a4a-2587-08d582cf4509
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1567;
x-ms-traffictypediagnostic: MWHPR15MB1567:
x-microsoft-antispam-prvs: <MWHPR15MB156767E239AF20168EA6B772BEDA0@MWHPR15MB1567.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR15MB1567;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1567;
x-forefront-prvs: 06022AA85F
x-microsoft-antispam-message-info: qY5ELwOZS4sbcdKGAfJSKyabAmSXR/DLFyU84aPaqV4+6DNSbO24Tg9gLt6zthXJ9VlCrV+W+V3uoIfl7MKA4Pw49BmTRmdQIBL63VntN84jkHj/vSb43wrVUKpKv9r1izcqElnf1PDJyXGg7lk8jU/79iimOvWeGH1mhWghj2o+GpDc7imd+5tE2QO2LjIw9APmn/J50g+0vyeA3d+kKIqPxeZdJNob2AAKBgwmO9eQ4cvfdjM0qUiJcggu3q/WF9slxZZOw/HrWQc4EaWMHzv7G5pOLTpIq8bDTiklpDlIGYIlkQ6/vyC9bcmYX7rlbhIgKGojqKYsp21uEu+SmA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <78FECAC95990E34BB396EF847C51B27B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2092dc-eec6-4a4a-2587-08d582cf4509
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 19:28:26.8674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1567
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25JSgJI021293

> On Sat, Mar 03, 2018 at 09:27:36PM +0000, Sahil Rihan wrote:
> > (Please CC me on replies - I'm not subscribed to LMKL)
> > 
> > Prior to  0cf577a03f21 if a TPM 1.2 device was disabled, but visible (sysfs node "enabled" returns 0), creation of the TPM char device was only skipped if  tpm_bios_log_setup returned -ENODEV. 
> > 
> > On some systems like HP DL380 G9, if the TPM is disabled but visible, the TCPA log is empty, which means tpm_read_log_acpi returns -EIO.  Starting with 0cf577a03f21, -EIO triggers an early return from tpm_chip_register which means the char device is not created.
> > 
> > Log snippet:
> > [    4.320387] tpm_tis 00:00: 1.2 TPM (device-id 0xB, rev-id 16)
> > [    4.455389] tpm tpm0: A TPM error (7) occurred attempting to read a pcr value
> > [    4.457762] tpm tpm0: TPM is disabled/deactivated (0x7)
> > [    4.459461] tpm tpm0: tpm_read_log_acpi: TCPA log area empty    <----------------------
> > [    4.461312] tpm_tis: probe of 00:00 failed with error -5
> > 
> > Thanks,
> > Sahil
>
> Thanks for the bug report, I appreciate it!
> 
> Personally I think we should keep the warning if the log area is empt
> but tpm_read_log_acpi() should return -ENODEV in this case.
> 
> /Jarkko

Agree on keeping the warning. 

I'm guessing you want to return -ENODEV from tpm_bios_log_setup. Doing it from tpm_read_log_acpi will just fall through to calling tpm_read_log_of, which I think will end up returning -EIO again.

In terms of semantics I'm not sure if -ENODEV is the right return code if the BIOS event log is absent. I guess you can claim it's some sort of "device". I don’t have a strong opinion here.

Sahil
