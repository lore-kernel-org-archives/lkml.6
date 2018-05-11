Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeEKDYv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 23:24:51 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.202]:48988 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750927AbeEKDYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 23:24:49 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSW0wTWRjHe2am06m2cCgQPgmY2IQEUYjow86
  DUbPRZPZl17jRh2rUKY5MYy84U1fUB0HdxChgA7t1raxUBAXEGEo1BryhJF4jiVx88FJLvYFI
  tERRa8BOB7y8/b7z/5/v+5+TjyFNj+hMRih1C5KTt5vpGZT4KkzkTxjeWxa8ezuPrT3bSrP1l
  0X2cHmPju3tqKXZJ62TWvZC42WCDVUtY4+WVyE29rGWXqbn2pvyuEC0Wsfd/C9GcWeD/RR319
  +t49rv7OLOfV7C/T2ezo0FZq/UW7Q2p9VVulEr9t19qS3pSC69N/mZLkPDhgNoBmPCzxCEmu/
  QanEdwZCnLl7oGQpXkHClYo0qeAh4E71JqMVjBKd6TlOKi8Zz4dbIAHkAMUwazoWR4ELFQ+I2
  Et537SUUTyreABPeYMKfhjdCXeU4Unkh/NNSTqjTcqCyvynhMeJ18LzxjE5hE94K4ZediUR6v
  BhOnIiRCiOcDd7BUOIuiTPgf69PqzBgDA0Xe0iV02EoMqFVsiG8CkaD69XjOfBitItSORvu1x
  1ESmbAHi1M7qvXqUIh3Gi+QqpCSAtf6gYJVTiPYE/H1IA8OOQfoFXeAuGRg8T0+f5u3xTPhpb
  KMKU2aibhwavjU6OzwN94iPSgAt8Pj1B5Pvg7o7TK8+Dk8dekL/ExKXDryDPKj6gWlCsL0l+C
  lL/olwKrZCsW3Q7eZs8vXMAWOARZ5osFO2+VC4pcjgCKb9pujQZdQB+6115DsxjCnG480he1m
  JKsrk07RF4WN0jb7IJ8DWUxjBmMTHwjTSmSUCyUbrbZ4+s6LQNjMKcZVyqyUS7hHbKtWJVuo3
  ymNVhdQZoop8spZGYY9YoJKyZxm/Nbi+mlv4+yM1ONSKPRmAwlguSwuX/Wh1EGg8ypxmyli8H
  mdH+bNBwPQcRDdPWPKSHc/HcpswwR92qSAr7zya01fQ9/693ZtGZ0O/PriqHoJ+vgQCS6P6dt
  x569Yv3TcGi15tL1lPay2JDd8m+kd6bzRsztrW07VlTROKCpqfo9t+Pwp4blKGl735/NUGTxv
  u1cGkiRknePBa7WeJ64x8VyeUvWEtcu//w/IumVfFek2n6pIUfuNlOyyBfmkZLMfwVUxBxp7w
  MAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-15.tower-37.messagelabs.com!1526009086!92257264!1
X-Originating-IP: [104.232.225.2]
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
Thread-Index: AQHT6HxSRcNgfj0RT02kxPWBEx8Dn6Qp2Qqg
Date: Fri, 11 May 2018 03:24:34 +0000
Message-ID: <HK2PR03MB16843E14AD56B3E546D9F52D929F0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525968625-40825-1-git-send-email-yehs1@lenovo.com>
 <20180510163023.GB30442@bombadil.infradead.org>
In-Reply-To: <20180510163023.GB30442@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.33.111.46]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0883;7:0y82vLp9Bq0/CucQDMqX8MmX3zXgtfMqOUBvE1gcNfOunarCh/MvSNegav/A+CYUMkVtHN/uQZO7OkRWktmzIP3acN1lNGvPwIMiQzK0MaIZgj9rxm9A1/UsNHV3SsGf41+SxoFLNydg4isXMb0cd3LwVmo7FDOGDIGxV4LcQrkIz0HuG61db+Y1qh4sftJQ6FoaMkpOKp1G9nsF5JYnWp0B/QcOrp4W6b8CxTyU3mxCvm8sHk+DzEHvIs+o7PTy;20:atn13V+JpYMxyYTqgleB4Hj2wbh6HnAtM1T00P0ggh+jHE6YrLsB4y5I8pnZnWtO6Y/907jR18sU7FxbpZAPatnjyhO8b3vgIAdo6KVAzK6okPkPLYVkVLqVODtaEQVKnwWsTS331goydrR34zNNVmfJsYSbixKm3p65Sv42zQSV1EtXXptrbxmB2Tm8MfGKvRXDLrzBMu0Hhw0Ny57QzZxgR2ffCZlcgEjfSaxLIq+ze/lfWqJaO6hafizb7CGXsoyGaxN0COtbwbB86amNGIoIhvfEyggl39Pg/oWLrwj/dyNiYzA5RSccjject2wpIYt8ZL7jF3dpq3x1+VaqDw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(376002)(39850400004)(199004)(189003)(7736002)(74316002)(186003)(3846002)(33656002)(9686003)(68736007)(106356001)(53936002)(8676002)(8936002)(6116002)(97736004)(25786009)(2906002)(446003)(86362001)(14454004)(81156014)(11346002)(81166006)(2900100001)(476003)(14066004)(4326008)(7696005)(486006)(6246003)(5660300001)(66066001)(229853002)(76176011)(3660700001)(316002)(6506007)(99286004)(5250100002)(3280700002)(305945005)(6916009)(55016002)(478600001)(54906003)(6436002)(102836004)(105586002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0883;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0883;
x-ms-traffictypediagnostic: HK2PR03MB0883:
x-microsoft-antispam-prvs: <HK2PR03MB0883320665B14F034A5C6931929F0@HK2PR03MB0883.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HK2PR03MB0883;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0883;
x-forefront-prvs: 06691A4183
x-microsoft-antispam-message-info: MfwriFbp5kjJwZZjl5FD9VXncWGFdNAnVgN0of+pgBG+uSplLPePHKK3CgFl8z2OR5F9e0/+MS1qlzjDa5a62NrbI1PWQ6Ai1p982liKOts//eFVHrXt6E+btilQcFTQbFOI7tz7QVILInTQ2ynAKacipZOQph+/B4mDVFWs15Q/odEoJo3NCuYKApItmh9w
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 926a3db4-35a2-44ca-1d18-08d5b6eeb83f
X-MS-Exchange-CrossTenant-Network-Message-Id: 926a3db4-35a2-44ca-1d18-08d5b6eeb83f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2018 03:24:34.9916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0883
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4B3Otro007504

> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of Matthew
> Wilcox
> On Fri, May 11, 2018 at 12:10:25AM +0800, Huaisheng Ye wrote:
> > -#define __GFP_DMA	((__force gfp_t)___GFP_DMA)
> > -#define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
> > -#define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
> > +#define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
> > +#define __GFP_HIGHMEM	((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL)
> > +#define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^ ZONE_NORMAL)
> 
> No, you've made gfp_zone even more complex than it already is.
> If you can't use OPT_ZONE_HIGHMEM here, then this is a waste of time.
> 
Dear Matthew,

The reason why I don't use OPT_ZONE_HIGHMEM for __GFP_HIGHMEM	 directly is that, for x86_64 platform there is no CONFIG_HIGHMEM, so OPT_ZONE_HIGHMEM shall always be equal to ZONE_NORMAL.

For gfp_zone it is impossible to distinguish the meaning of lowest 3 bits in flags. How can gfp_zone to understand it comes from OPT_ZONE_HIGHMEM or ZONE_NORMAL?
And the most pained thing is that, if __GFP_HIGHMEM with movable flag enabled, it means that ZONE_MOVABLE shall be returned.
That is different from ZONE_DMA, ZONE_DMA32 and ZONE_NORMAL.

I was thinking...
Whether it is possible to use other judgement condition to decide OPT_ZONE_HIGHMEM or ZONE_MOVABLE shall be returned from gfp_zone.

Sincerely,
Huaisheng Ye


> >  static inline enum zone_type gfp_zone(gfp_t flags)
> >  {
> >  	enum zone_type z;
> > -	int bit = (__force int) (flags & GFP_ZONEMASK);
> > +	z = ((__force unsigned int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> > +
> > +	if (z > OPT_ZONE_HIGHMEM)
> > +		z = OPT_ZONE_HIGHMEM +
> > +			!!((__force unsigned int)flags & ___GFP_MOVABLE);
> >
> > -	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> > -					 ((1 << GFP_ZONES_SHIFT) - 1);
> > -	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > +	VM_BUG_ON(z > ZONE_MOVABLE);
> >  	return z;
> >  }
