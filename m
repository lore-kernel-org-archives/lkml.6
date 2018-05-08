Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753738AbeEHAz2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:55:28 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.209]:33304 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753663AbeEHAz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:55:27 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjl+JIrShJLcpLzFFi42JJl3ulo1vz9UO
  UweV7shZz1q9hs1i0L8NieuN5dovVm3wtLu+aw2Zxb81/VovmibfZLXYs3cdkcb/PwaL18E4W
  i9kt71gtZjf2MVr8/jGHzYHX4/Cb98weO9euYvLYvELLY9OnSeweJ2b8ZvHonv2PxePj01ssH
  uu3XGXxOLPgCLvH5tPVHlt/2Xm0fhf1+LxJLoA3ijUzLym/IoE14/ivHewFjzkq7mxZyd7AeI
  Wji5GLQ0jgOaPEtC3LmSCco4wSZ24fYgZxWAR6mCX2nnjNCJHpY5LYs/4VC4Rzh1Hi9LoVQGW
  cHGwCmhIn31wDsjk4RAQ0JN5sMQKpYRZYyCpx4d4rdpC4sECIRM9jD5ByEYFQib1n3jJC2EYS
  b56dYgUpYRFQkfi2FizMKxAj8WnrBrDpQgKFEldvrWMDsTkFbCTubjsDFmcUkJWY9ug+E4jNL
  CAuMXfaLFYQW0JAQGLJnvPMELaoxMvH/8DGMwoESbzbEgcRVpKYdXAJVLmsxKX53WAvSghMYJ
  X4emwfVMJQ4vjK/cwQib+sEsfvLmODcLYxSiz9vYUJokpL4s+ug1B2tsSjtrOsMPGOI7Og4nI
  Sq3ofskA0r2SWeLXrMxtEQkZizt19LBMY9Wch+WIW0LXMwDBdvwsqrCgxpfsh+yxwwAhKnJz5
  hGUBI8sqRo3i1KKy1CJdQ0O9pKLM9IyS3MTMHF1DAwu93NTi4sT01JzEpGK95PzcTYzA9MgAB
  DsY132MPMQoycGkJMrL/eB9lBBfUn5KZUZicUZ8UWlOavEhRhkODiUJXo8vH6KEBItS01Mr0j
  JzgIkaJi3BwaMkwvv2E1Cat7ggMbc4Mx0idYrRkmPNlkk9zBwd76cAySeXp/UwC7Hk5eelSon
  zNoPMEwBpyCjNgxsHyyaXGGWlhHkZgQ4U4ilILcrNLEGVf8UozsGoJMw7H2QKT2ZeCdzWV0AH
  MQEdJAjyC29xSSJCSqqBMbo2I3/FssX3RLVvvZF2+X5hm/ZhHcf+LtO0A7sMzW40iNVK1jYp1
  TUdcfyhFRO3NUQ+RJhhfx33uyk7k1hVl4Q+2nOAI2D/R2a+tiW/f3pn5oSVMmhdXP6q5/8Ty7
  Al6byL/f1drBgf7hUvSsj3do0Ls2lju8Xdm3P52ecyyUP1u1bcXJ2pxFKckWioxVxUnAgANSw
  SiiEEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-9.tower-144.messagelabs.com!1525740914!24493604!1
X-Originating-IP: [103.30.234.44]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@suse.com" <mhocko@suse.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [External]  Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem)
 zone
Thread-Topic: [External]  Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM
 (pmem) zone
Thread-Index: AQHT5jPWfBz2tzl9Xk+fNx5ZDx4cXqQlAJdQ
Date: Tue, 8 May 2018 00:54:59 +0000
Message-ID: <HK2PR03MB1684FC2E2FB3C59C913D0C97929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
 <20180507184622.GB12361@bombadil.infradead.org>
In-Reply-To: <20180507184622.GB12361@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0787;7:AmR8Oz4zQ2kf3ZPkYOWBIRm/0pcbDiFQ9C8510EnKMtlevb65xR98mEVSI1d/NSvvLy9346INsnTVw7UwgWrJilD5Zvy4mQidg2i36yVYgkLvm/zw09CvohjYTDGlrKxSUGsPUA1x6pmJbF/JcOQLltVSX3KQHpfj8+XMSwGlMXgjqcFwdsZ73LiQ1LDZounYCiwG6b7kLNjYXLijoc8J0dr761kPuWxqh1dOf28LCEofAAAQajt8ni07wuno9UO;20:b/4PTabitMxkyCe1cgm6OXdxOS7kbQPYuCSiNFq6zz9RYFiu7zgFm/ZdbF/QnDqqkRbvxA9o5izJOASw1ojeiTSVpUtt5wr5/8HRrz6aLCtk/9+HsmtU/Mzxh7kNyHjTQZgvqHC7gSOY5AZXnc76o2e8CmlehANMpF0NR/8OQqzDABXp2/+5/qOvfMEH3RB0HBLtbT9qXicJERj9G7cr5W2r6UyF60vuCjQ9dKZEZFY4uis7mS3vNMo9Y0d/QGqSg4yJYmtdnTqytkj3r/6gdcwet+Hw8wIQjybPIzXBlIRuppe41lOmsqdpPiAZa6lqIlwKWF3xOZExEFMMGzLovg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39850400004)(39380400002)(346002)(396003)(376002)(199004)(189003)(52314003)(6506007)(86362001)(102836004)(486006)(9686003)(25786009)(6436002)(4326008)(76176011)(7696005)(68736007)(53936002)(6246003)(26005)(66066001)(55016002)(186003)(2900100001)(99286004)(476003)(11346002)(229853002)(5250100002)(446003)(5660300001)(8676002)(106356001)(105586002)(7416002)(54906003)(33656002)(7736002)(305945005)(3660700001)(81166006)(97736004)(6916009)(81156014)(2906002)(74316002)(478600001)(3280700002)(3846002)(6116002)(316002)(14454004)(8936002)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0787;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0787;
x-ms-traffictypediagnostic: HK2PR03MB0787:
x-microsoft-antispam-prvs: <HK2PR03MB07872CBFDBFE0D01BF425FEB929A0@HK2PR03MB0787.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HK2PR03MB0787;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0787;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: BYozRjF0qAN51y3Y/L4BWO0qsy5TGNRB7R5Npi616/RJxQ8qtlMbViUZrWM/tAlRs+ZKWaMk7W1tp+Elnn8aOxYRYNYuzv5BmFVi3ChVMpnarOd8NwzMiFVMWaTnOIEG7kmCq/zQTo0qfcP7Db+Ro7MbsfhFRBJAuw4EO1fMundq8w/oji/nDsUxylUiUCH5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bb11eb35-6bbb-47ad-5179-08d5b47e5320
X-MS-Exchange-CrossTenant-Network-Message-Id: bb11eb35-6bbb-47ad-5179-08d5b47e5320
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 00:54:59.5308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0787
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w480tYJU003003


> 
> On Mon, May 07, 2018 at 10:50:21PM +0800, Huaisheng Ye wrote:
> > Traditionally, NVDIMMs are treated by mm(memory management)
> subsystem as
> > DEVICE zone, which is a virtual zone and both its start and end of pfn
> > are equal to 0, mm wouldn’t manage NVDIMM directly as DRAM, kernel
> uses
> > corresponding drivers, which locate at \drivers\nvdimm\ and
> > \drivers\acpi\nfit and fs, to realize NVDIMM memory alloc and free with
> > memory hot plug implementation.
> 
> You probably want to let linux-nvdimm know about this patch set.
> Adding to the cc.  Also, I only received patch 0 and 4.  What happened
> to 1-3,5 and 6?

Sorry, It could be something wrong with my git-sendemail, but my mailbox has received all of them.
Anyway, I will send them again and CC linux-nvdimm.

Thanks
Huaisheng
