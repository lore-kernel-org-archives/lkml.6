Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeECOGK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:06:10 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.15]:8265 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751121AbeECOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:05:56 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRWlGSWpSXmKPExsWSLvdKR9dJ/HW
  UwdFlqhZz1q9hs1i0L8NieuN5dovLu+awWdxb85/VYsfSfUwWr78tY7aY3djH6MDhsWlVJ5vH
  pk+T2D1OzPjN4nFmwRF2j82nqz22/rLzaP0u6vF5k1wARxRrZl5SfkUCa8b8y+0sBRO4KjZMO
  szcwDiFo4uRk0NI4DmjxIdrqV2MXED2UUaJBf+mMYM4LAI9zBJb5j5kgsj0MEnsf3acBcK5wy
  jRu+4hO0g/m4CmxMk315hBbBEBFYn1fXfYQYqYBfqZJe583swKkhAWcJNoOzSHCaLIXWJZywV
  GCNtK4vK5n2wgNgtQc9PVdSwgNq9AjMTECT+YIA7MkOh5+QYszilgLLFpyhuwZYwCshLTHt0H
  q2EWEJeYO20W2C4JAQGJJXvOM0PYohIvH/8DinMA1QdJvNsSBxFWkrjfcZsRwpaVuDS/mxHkZ
  gmBCawS6yatZYFIGEocX7mfGSLRyCYx/+dTJghnG6PEtrVdTBBVWhIN09exQdjZEkd2fGGHsC
  0lOi7dYIFomMkscWD2K6iTZCTm/lvJCPPavyV/mCYw6s1C8gWErSOxYPcnNghbW2LZwtfMs8A
  hIyhxcuYTlgWMLKsY1YtTi8pSi3Qt9JKKMtMzSnITM3N0DQ2N9HJTi4sT01NzEpOK9ZLzczcx
  ApMYAxDsYPy2xPkQoyQHk5Io7/eTL6OE+JLyUyozEosz4otKc1KLDzHKcHAoSfCyiL2OEhIsS
  k1PrUjLzAGmU5i0BAePkggvD0iat7ggMbc4Mx0idYpRl2PNlkk9zEIsefl5qVLivAogRQIgRR
  mleXAjYKn9EqOslDAvI9BRQjwFqUW5mSWo8q8YxTkYlYR5WUGm8GTmlcBtegV0BBPQEZ+/Pgc
  5oiQRISXVwKinuzlt+xfpT41vv1Vrn9DcbLb/hPa0fBkVe5N4AbFzRQHN117c8DV9rnC2NFRE
  5nL4ni3ys/8fXVD4RkxWRvxouKZvFfvrVl5OgSm/rPKmZ/2492fz/c6Jx1dJfj50Wc96ydG6I
  8+37hdf+/+G0oknl+bw26XPu/2qbTm3snQ/k+Zjmwv7nTiVWIozEg21mIuKEwHvTxb76AMAAA
  ==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-11.tower-168.messagelabs.com!1525356348!68562086!1
X-Originating-IP: [103.30.234.44]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>
Subject: RE: [PATCH] include/linux/gfp.h: use unsigned int in gfp_zone
Thread-Topic: [PATCH] include/linux/gfp.h: use unsigned int in gfp_zone
Thread-Index: AQHT4o9teqgAn3/L3Emr1MuuTG129qQdn7mAgABpwQA=
Date: Thu, 3 May 2018 14:05:28 +0000
Message-ID: <HK2PR03MB16841DAECCD847FDEB812D6A92870@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525319098-91429-1-git-send-email-yehs1@lenovo.com>
 <20180503074327.GA4535@dhcp22.suse.cz>
In-Reply-To: <20180503074327.GA4535@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.112.141.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1361;7:8JM1uGinJQyohtXjnWKorHMS9n6kIr5yvljrKxczm1pE/Dswcq/lg67uNlqiPO3pQond4SB/FxCcbwA9fyif9FXdunRoTPpcua4uC+ZIOYkE7ELlvFTqKsR1K7fBkQ1cnHiIkizYf7jVzC/uKg/a/ooiZUd98RePKGh0sA/SaFu/nQAk5EmwIjj7JkN7yYMcYM4ahGkNvpA9/qZwfXmzojIjMXANDl5ZxKZqsY2Tqts1hVHcnCNtvnvU25nBrYfS;20:20F2b8kAnyhBRzPf0Eqcg0BOvrS1DheqTC9XSVuMflLLOaGmSb3KvZA5B7+yBxtv/JQnp2+cqvI6YbAX/JyOxuWzcXpwWniLmGm7NIm5iaryRxfwRBNUL8U6Y2E/HvqGhbgV2iTQSeylrUpTdHeFdfWYR/H11UNUIoWFbDF2JDnZwq1wXQtmcrBqfil55fF+dpn97ZK+EEZKgKRYfce481U6S2PDB2EcBiqFykDCb6C3pUuJOYceJYLDuEAXHEs9fmROpE1gARloAXZupJ0d6gWXJocw3Y6NJNyp8cMg1cLV8TpILMOY/ZmHdT5yBbhetikC9W9mZ6adgRQqCBOMIQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39850400004)(189003)(199004)(377424004)(6916009)(107886003)(486006)(6436002)(8936002)(106356001)(6246003)(102836004)(3280700002)(86362001)(53936002)(105586002)(68736007)(66066001)(4326008)(446003)(11346002)(14454004)(26005)(3846002)(476003)(97736004)(55016002)(186003)(9686003)(6116002)(25786009)(74316002)(305945005)(229853002)(76176011)(478600001)(3660700001)(6506007)(7696005)(5660300001)(316002)(8676002)(59450400001)(54906003)(2906002)(99286004)(81156014)(7736002)(33656002)(81166006)(2900100001)(5250100002)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1361;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1361;
x-ms-traffictypediagnostic: HK2PR03MB1361:
x-microsoft-antispam-prvs: <HK2PR03MB13617D5CFCB192C621D560EB92870@HK2PR03MB1361.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR03MB1361;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1361;
x-forefront-prvs: 066153096A
x-microsoft-antispam-message-info: /OmCUcNkee/oll0ir25AMSzfgRA2F6oVvXSNk/wOst4vOW96fRAVjjpawK4AshFnYlHZGCgtPMVc+wCMX+mCWLan/8bLHUYRUT4fEiT5nRo4u/9/i12TwmjQk8ZXDkd38niYP0MbxWOhe2VJsczRNrNvZvXF4GPWYW7tkA/nr/XRpH3Tarq3Vj2JHTxFc2VN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6e04a920-cbbd-4bd9-dd04-08d5b0feed02
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e04a920-cbbd-4bd9-dd04-08d5b0feed02
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 14:05:28.5281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1361
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w43E6G5c023254

 > On Thu 03-05-18 11:44:58, Huaisheng Ye wrote:
> > Suggest using unsigned int instead of int for bit within gfp_zone.
> >
> > The value of bit comes from flags, which's type is gfp_t. And it
> > indicates the number of bits in the right shift for GFP_ZONE_TABLE.
> >
> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> 
> The patch looks OK but it misses the most important piece of
> information. Why this is worth changing. Does it lead to a better code?
> Silence a warning or...
> 
Yes, thank you and I will rewrite the commit log later.

Sincerely,
Huaisheng, Ye
> > ---
> >  include/linux/gfp.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 1a4582b..21551fc 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -401,7 +401,7 @@ static inline bool gfpflags_allow_blocking(const gfp_t
> gfp_flags)
> >  static inline enum zone_type gfp_zone(gfp_t flags)
> >  {
> >  	enum zone_type z;
> > -	int bit = (__force int) (flags & GFP_ZONEMASK);
> > +	unsigned int bit = (__force unsigned int) (flags & GFP_ZONEMASK);
> >
> >  	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> >  					 ((1 << GFP_ZONES_SHIFT) - 1);
> > --
> > 1.8.3.1
> >
> 
> --
> Michal Hocko
> SUSE Labs
