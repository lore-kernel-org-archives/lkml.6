Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeEPMMa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:12:30 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.9]:41265 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751510AbeEPMM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:12:28 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfUwTdxjH++u99Eo486OU8FgpuiYmisKEGHN
  ZjOL+MJeZLMZkW0YUPLZb29gXvKuKbkYaZAEEZJpRqcyCr4goG22NCkHjiAMl4kvURIMEJaiV
  uCBRDCW4Xg/U/fd5nu/z8v398jCE4TFtYsRijyi5BIeFTiCt6ZGlmUsWTOUtOzKl5xraWmnua
  JeN83n7ddzdSw0097j1PcVdONGl5QZrcrnD3hrERd810Ll6Pticwbe/PqDjew5FSb4tdI/k+x
  q7dXzwxs98eHIVXzaRwo+3p6/X51F2V6G7eDNlCxxtoYquJRZXTQ5TJagpoRLpGQN+hsA3vak
  SJcT4GoLOM4coJSBxMwG9v7+hVKVGC48mwjo1GERwrvW4Vumn8WLoHb1PVCKGMeJFMBrKUWoI
  HCbg74G3SKlJxgUwXRciFTbizRConkAqfw3tf9ZTCpN4Idy+NE4rzOKNUN8foNVlE1oYu7I3L
  ujxSnhwMBgfhLAZ6p4Mxk0QOBX+qPPHBwHGcLyzn1A5BV48naYUcwhvgFehfDVtgaCvglTZDH
  cC+5CyC3AtBaUVx3SqkA3/nL5MqMILCiL1k6QanEcQHXs+054Bdy/vRSpvgZHmYd1svrzbr1U
  5HVqqh2aaTxMwfurmTEMa/HbOR9aiz/2fvELlpdDY8ZpWeQmcbHpJ+ONfkwS99cNkIyJb0CJZ
  lLaLUmbOiqxCyW61eZyC3ZGZnZ2T5RRlWbCKDqFQzvrB7WxHsVvbo9GgC6jF+9VVNJfRWlLYm
  ulonmFOofvHnTZBthVI2xyifBWlMYwF2P70qTxDkiRaxeKf7I7Ywc7KwCRajKxfkVm5SHDKdq
  sqXUeZTGvoQBVhIF1ul2hKZefNjxVhpci2zfVhxOzZ30FmUzKLNBqNIbFIlJx2z//1CEplkCW
  ZDSurEu0uz4dNkZgJbcwEuhJVTHiEj5IpdtYEGE/szyr94iExNvRlX8kvu8uX/+UJ0E9Sy4J0
  0tSus03mz3ZcrO7rWMtGtqx6taJg2QBVnt/T1GU2fjeav9U/0v2v803423cj+yTHkbLlrl/P+
  zyjz2orq75BXncJlzZ3tXFTxcC6Nd/n3jJlDO0Jr/F2XLQHO+/ly1Jpz/W2Agsp24TsDEKShf
  8A8GYmN/EDAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-10.tower-143.messagelabs.com!1526472740!6495762!1
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
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH v1] include/linux/gfp.h: getting rid of
 GFP_ZONE_TABLE/BAD
Thread-Topic: [External]  Re: [PATCH v1] include/linux/gfp.h: getting rid of
 GFP_ZONE_TABLE/BAD
Thread-Index: AQHT6HxSRcNgfj0RT02kxPWBEx8Dn6Qp2QqggACtQICAAWwJoIAANhyAgAYdDvA=
Date: Wed, 16 May 2018 12:12:00 +0000
Message-ID: <HK2PR03MB1684A881A868E9676C7E55E692920@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525968625-40825-1-git-send-email-yehs1@lenovo.com>
 <20180510163023.GB30442@bombadil.infradead.org>
 <HK2PR03MB16843E14AD56B3E546D9F52D929F0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180511132613.GA30263@bombadil.infradead.org>
 <HK2PR03MB1684BC9802BC2E5C1BF2DC74929E0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180512142249.GA24215@bombadil.infradead.org>
In-Reply-To: <20180512142249.GA24215@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.201.10.230]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1763;7:jB2rjKKoLn+tdkPAIgFcKqNmxyYIAlBX2nMrwSJdpmkq87XwLAC/3ZaxB53zq/nBvexWa2g6atVXLWRglaQNhtXZi7r1L3tpUf3iGdHuUFzx77BWu6kvejoaqK2yk7s6wBeqKjopnaCq5fHfd6TJodQsE3IyE5rnxj8sOq1hPwBezpQ0AZL61FuOgd3AFwyc5/XaJjF2yUS+RstvcqwrHnddtNUy1rnfk2FXr4Sc+bYyf1CQtpK6m9gvs8CU2tBA;20:U0IxIs+6436/ScAJA6hGNSrAl3XmJoGqEoPNO3stwNQf7Fkhrg58X74An0Id3GD5nDeRtoY3zHUCQYrQCB4hBX9Aglm94PZabRvuszcmHJ9bQ8Qtcuvw0LAjFRWXlzy7d0K8/10KbGv06hl37wXVW59CJR2dJzNkzGLnqliy/P5R6k7qXxfZsarUB72Plc1PQgbRCEp70IhOmcipZCbWbRtQ/d7mQLPbjcAEaPQEoplMVZT6YIercW035W/023v4oz1FJpetnsdUTSFbu33idV951+7eyOV/Hm0qG6G4ys4etec8jnlviViZJeb+eEUi9m7MidqEt7vB1R1+89gpsg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(39850400004)(346002)(376002)(39380400002)(366004)(189003)(199004)(186003)(316002)(2900100001)(6916009)(5250100002)(99286004)(25786009)(97736004)(7696005)(4326008)(76176011)(66066001)(6116002)(53936002)(3846002)(86362001)(478600001)(14454004)(6246003)(68736007)(81156014)(55016002)(9686003)(8936002)(106356001)(81166006)(446003)(2906002)(3280700002)(3660700001)(5660300001)(476003)(93886005)(105586002)(74316002)(8676002)(305945005)(102836004)(229853002)(486006)(33656002)(26005)(7736002)(11346002)(6506007)(6436002)(54906003)(13296004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1763;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1763;
x-ms-traffictypediagnostic: HK2PR03MB1763:
x-microsoft-antispam-prvs: <HK2PR03MB176399F6F64BE69328AEB86592920@HK2PR03MB1763.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB1763;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1763;
x-forefront-prvs: 0674DC6DD3
x-microsoft-antispam-message-info: PeMCLTflEl4I+Y3QHg2Jmve9LhnOiTibpQJJoewp9otk4xrlxn4Jkxos8zlS1BPXaibvUQZeUm11j7TMtgDtEQW9MQSvBDHvZILXCnrR6cOxVJnzC+gwCeWpAG3IAKLHb3+F6drtJ/5Qa8FD5s8gM4E/ocOGkq65EOTRpZu2sSE3DhwlXDvD/KUgCwJJ6JFs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5b8bd1dd-318d-4e7f-daf4-08d5bb263a95
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8bd1dd-318d-4e7f-daf4-08d5bb263a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 12:12:00.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1763
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GCEjom001129

> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Saturday, May 12, 2018 10:23 PM> 
> On Sat, May 12, 2018 at 11:35:00AM +0000, Huaisheng HS1 Ye wrote:
> > > The point of this exercise is to actually encode the zone number in
> > > the bottom bits of the GFP flags instead of something which has to be
> > > interpreted into a zone number.  When somebody sets __GFP_MOVABLE, they
> > > should also be setting ZONE_MOVABLE:
> > >
> > > -#define __GFP_MOVABLE   ((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed
> */
> > > +#define __GFP_MOVABLE   ((__force gfp_t)(___GFP_MOVABLE | (ZONE_MOVABLE ^
> ZONE_NORMAL)))
> > >
> > I am afraid we couldn't do that, because __GFP_MOVABLE would be used potentially
> with other __GFPs like __GFP_DMA and __GFP_DMA32.
> 
> That's not a combination that makes much sense.  I know it's permitted today
> (and it has the effect of being a no-op), but when you think about it, it
> doesn't actually make any sense.

Yes, you are right.
After checking almost all references of __GFP_MOVABLE and other __GFP_* flags, perhaps I was far to get excessive pursuit of logical correctness.
For those nonsense combinations, I should ignore them.
Current GFP_ZONE_TABLE can ensure all logical correctness. That makes me want to pursue same effect.

Next, I will revise the patch according to your advice, then try to get overall testing result as far as possible.
There are many combinations because of a lot of conditions in file system and drivers. Hope I could test all things related to the lower 4 bits of gfp.

Sincerely,
Huaisheng Ye
