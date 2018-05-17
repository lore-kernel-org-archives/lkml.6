Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeEQRmy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 13:42:54 -0400
Received: from mail-sn1nam01on0107.outbound.protection.outlook.com ([104.47.32.107]:25316
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750825AbeEQRmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 13:42:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        0-Day Mailing List <lkp@lists.01.org>,
        Linus <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: a new pending-fixes branch
Thread-Topic: linux-next: a new pending-fixes branch
Thread-Index: AQHT6aqo3IHN4ANv/EKCtE3wEE/0N6Q0OZqA
Date: Thu, 17 May 2018 17:42:49 +0000
Message-ID: <20180517174247.GI8514@sasha-vm>
References: <20180512143523.250ab803@canb.auug.org.au>
In-Reply-To: <20180512143523.250ab803@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1106;7:chn4jLh69duDAXJyjbJCNoZs/9K50Vz4zV/7xAtda4rkGtpUfjr3YNm8EwcT6a/V3JA41yC0Ny+/HHYYW/18B/lva3krlkictLEVIrYheZGEVDcshoYDSp4QkGk0B9jrph+uVQHGOg12oEqlJQ5On0HDAtOU6LrKntNLiXozSK/ntGtb/uSi0e2bfa31kRiaL8xdQZrAACgrs7TcTR5lpNy1V9QfRcaJRexGqbXnfk0VN4DgtPQbac/XRKgTMouV;20:UDKGxm0SY/WiKaGo1no9ATktaVvwj2a+20ULK2bzvWwE00RTO1rlEW7wErXTw6rEDRy/ibqeYMyS+QU5zwHCMKihdsVMW2QWkoJBMA49847dQR1RAif6qhEfFB3ia2jb2T3hiD3lBLEyutrcRiZUnUNqsZi08o3rZKq8z5WB5tQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:BL0PR2101MB1106;
x-ms-traffictypediagnostic: BL0PR2101MB1106:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB1106FB0BDDA1F3B6ADCCDE73FB910@BL0PR2101MB1106.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1106;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1106;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(39380400002)(366004)(346002)(396003)(376002)(199004)(189003)(53754006)(10090500001)(1076002)(25786009)(26005)(305945005)(10290500003)(6116002)(3846002)(5250100002)(3280700002)(6436002)(66066001)(33896004)(99286004)(186003)(11346002)(486006)(76176011)(476003)(446003)(59450400001)(6506007)(102836004)(54906003)(5660300001)(2906002)(68736007)(3660700001)(6246003)(105586002)(97736004)(22452003)(106356001)(6916009)(4326008)(316002)(9686003)(6512007)(7736002)(86362001)(53936002)(229853002)(2900100001)(72206003)(478600001)(14454004)(33656002)(86612001)(8936002)(33716001)(6486002)(8676002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1106;H:BL0PR2101MB0913.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kFIA2roBOBrI+oraABa14vOziqE8Vtf6gY2o6tmoWzaQoV7a6TDtaoYFMB/OmxcS+kB8FrNVa2Cz91ZzNh/C17OtvatzwJvAYn09taxJdBLHsL8FidrC9VCee+0hjYbpoJa8G8lh9/jeIreBzFEUcH5mQD5oicDhBLas1DbEedKxn8alfOplqe/KaFqXWG1R
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B786F4B7A3AB694292676B980981013C@namprd21.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 49fa61de-ea14-4ac1-7731-08d5bc1d9bb0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa61de-ea14-4ac1-7731-08d5bc1d9bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 17:42:49.3068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1106
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4HHgxMY028433

On Sat, May 12, 2018 at 02:35:23PM +1000, Stephen Rothwell wrote:
>Hi all,
>
>As an outcome of some discussion, I have added a pending-fixes branch
>to linux-next.  This branch contains Linus' tree merged with branches
>containing only fixes pending for the current release.  The branch is a
>strict subset of linux-next each day (as so rebases like linux-next
>does).

will you be keeping a history of this branch like the linux-next history
tree?
