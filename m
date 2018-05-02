Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEBGGf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:06:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750883AbeEBGGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:06:31 -0400
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
Thread-Index: AQHT4bqqrCyw41qupE6Snx2x08TdlqQb2+IAgAATigCAAARWgA==
Date: Wed, 2 May 2018 06:05:46 +0000
Message-ID: <2E9CBF79-3075-48FF-87D8-834DCE1E5D9D@fb.com>
References: <20180502120921.654cc338@canb.auug.org.au>
 <0942C278-336F-4795-BE63-FAD7FBAA231B@fb.com>
 <20180502155014.4f5acdcb@canb.auug.org.au>
In-Reply-To: <20180502155014.4f5acdcb@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.6.18)
x-originating-ip: [2620:10d:c090:180::1:3698]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1866;7:/ek63aw76RHL8c1mhURo7fyTYiG7E1bJK0jWVj48+Vj/GYxeV8vvCloehijHLb1xUnO+cfSj2cbEDxo7ptAvr01FywR+fcbNIqpJk5jUzNDmG0YaFUpXi0486QF6GoTp3xwOyZW6pL5txczJU+VidgfpI4o2meGBsUiCaLU6YMCw7JCtoU488f5dJfM4aCCg05wlJ8uk1oIJLD5HiPUtpX5/MDJ+xAS2BQ2JdV92tPULVL+2m6F4yHem205gD9hh;20:iiMdndXApl0OKh44OAf6iKov+cCTS/V8HbXpaoPxk/IzFh8+bYegAis3vZoR2vq2bHOt4L/vEJyvmv8bJpd698OAYGp+BnmYW94GZoKNHxeO8oAnKdZ80UnJtaWUR9pE9ap7eiF/GnyOp9259oedGzy2E6VNilZZ2A309O2iRT0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(376002)(346002)(189003)(51914003)(199004)(86362001)(106356001)(53936002)(99286004)(3660700001)(4326008)(6506007)(83716003)(476003)(97736004)(486006)(2900100001)(2906002)(25786009)(7736002)(57306001)(3280700002)(446003)(2616005)(316002)(11346002)(54906003)(102836004)(6512007)(186003)(6246003)(33656002)(5250100002)(478600001)(53546011)(36756003)(68736007)(14454004)(8676002)(46003)(50226002)(6916009)(229853002)(81166006)(305945005)(6486002)(6116002)(105586002)(6436002)(8936002)(5660300001)(76176011)(82746002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1866;H:DM5PR15MB1548.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1866;
x-ms-traffictypediagnostic: DM5PR15MB1866:
x-microsoft-antispam-prvs: <DM5PR15MB1866DCBB18DCE3A051EFAC73B3800@DM5PR15MB1866.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(10201501046)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1866;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1866;
x-forefront-prvs: 06607E485E
x-microsoft-antispam-message-info: doQ/I/PRWkCJhTKZ5tp1U29zdvGXqKzbXoKrSzzGJBgq2CqEz19XyJo86k6r1eRLIbFgmme/KwmJBVhpfBi6kx55w97ZRy553I3O4mh6R9ovKWe4+X0YYPzNMfzOftwK/p779zTR1ZG9L/EFNqSTLA7+G3wcexq893C1PMcVnGPKdGau051webgdNffGAIPs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC68B4369D5BAF49A4B94DC9010C5B2F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4daef919-bf7b-4363-ceb3-08d5aff2beec
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daef919-bf7b-4363-ceb3-08d5aff2beec
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 06:05:46.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1866
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4266dwd005442



> On May 1, 2018, at 10:50 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> Hi Song,
> 
> On Wed, 2 May 2018 04:40:20 +0000 Song Liu <songliubraving@fb.com> wrote:
>> 
>>> - 	CHECK(build_id_matches < 1, "build id match",
>>> - 	      "Didn't find expected build ID from the map\n");
>>> + 	if (CHECK(build_id_matches < 1, "build id match",
>>> -		  "Didn't find expected build ID from the map"))
>>> ++		  "Didn't find expected build ID from the map\n"))  
>> 
>> ^^^  Is there a "+" at the beginning of this line? 
> 
> No, this is a merge resolution diff, so the ++ means that the line did
> not appear in either parent commit.

Hi Stephen,

Thanks for the explanation! 

Song
