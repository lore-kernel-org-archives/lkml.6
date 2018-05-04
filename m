Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbeEDRuT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:50:19 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.195]:43048 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751443AbeEDRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:50:17 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wTZxjH+96vHqbnziLpswZcrEtEtBWMf5z
  GEPeXN6Zx4w+daNCrnr3GtpBeVYwuSJSNMUUxW4UWFBaos9CaFFQQI6TWiKIyXLbMhWhU/AUo
  v4IaWbb1esi2/z7P8/2+z/N9L+/RuP4tZaTFIo/odgkOEzWLkJ4/xMwbaofzMh+WWLiac80U9
  +MViTtZ0qvlmiLruF8u1VDc/ea/Sa6t8QrGDb0O4Fzp1XaC8x9+RXL+kgrETb2toVbr+KvDIz
  jfHgpifMtPGXwk+C3FR8ZPaPnuqimCH3vyB8Hfqotp+Zae/fz5d9l86ZsUfiIy73NdHml3WQu
  KtpHSYNXXRGH4g6KX4X7qIGrTlaNZtJ4dQHD9yQhRjpLiRRRB6AGnCAR7BIfRhhCpuo5icK+j
  nFKLfgS1ZV2YcoRiF8GN4d9wheeyOXDreSWhmHC2nYB3k/XxgqaT2c3QdHuh6tkCp/yHkMorI
  faiTqtYCPZjmDi/UWkzcctAqR9Td/UheOZ9nPAnsavg2tPxRFTEpoH30YNEBpw1QK3XRyoMLA
  sNl3txlVPgxeO/SGU+YnPhVWu+2l4A3a2jmMppcPf0d0jl4yR0t32mchZcP9uJKxmA9VIQDrU
  QanEBQVPF1PSJDPg90Du9eBdEY9Uz/bKYb3pDNQ49nYUqp8LAxIXEhfWsFUJT9uPI7PvPFVRe
  AnUd45TKiyFQP4T7Et9lDtyoHiDqEBFE6bLo3iO6zVkrLFa33SZ5nILdYc7K5CxOUZYFm+gQr
  LJle4EzguKvsFijQW3I27Emij6kMVMKk5M/nKefbS3YsU8SZGmre7dDlKMolaZNwGTWxLU5bt
  EmFu20O+JP+b0MtM40l/lCkRm5UHDKdpsq3URmurn1xBFcT7gKXKLRwCxTTKxikna7Zka8/yH
  uojRjMoM0Go1eVyi6nXbP//VBZKCRKZnxKlN0dpdnZtNgPAQWD5E8MqSE8Aj/SsaDKPDpD5HU
  7GPO2qPtVfiflWtTfj2TfSAnMts5sfqj5WferIitPTwuhi17Ao6qZ4/CvrGlT9O/NKwpnjzUd
  6dzU1/9N8Hcr+obL0a/v//z/E8qpeim0b0V55a+7FqcsR5vsBEHsnsM/uI0jTWfGTMmTe6Las
  fK7i1L1QcvdzT6ush0bb+JkCUhKwN3y8I/KwFZRAsEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-16.tower-144.messagelabs.com!1525456214!24230843!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned int
 in gfp_zone
Thread-Topic: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned
 int in gfp_zone
Thread-Index: AQHT46zY0MF6WC61BUed7IoviL30RKQftP0AgAAg+tA=
Date: Fri, 4 May 2018 17:50:00 +0000
Message-ID: <HK2PR03MB1684D51A63D851A9BED42C3A92860@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
 <20180504133533.GR4535@dhcp22.suse.cz>
 <20180504154004.GB29829@bombadil.infradead.org>
In-Reply-To: <20180504154004.GB29829@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.108.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1700;7:X/Gj7oaLkxg5BF5Ua9zXvxQWj0dv1gP6YDVVb9kaxmCoKycIdXQUxwZe+wyu22APP5pU9HLzDS0g19+YMkHsiMgZgw1WWkJtIOcEJ6xxihFWdVEpiIg9+6ZvnIWyFu6+K1EGa0d4hZtG6hWPp+tNhpXjqIAH3+xCwaQHakDKpJxTuzN09Zxa06HhOp0AvyVfjAKW+SQe7xFDdBAfC67AkHBKmqupEsU1ba2xUQ8HIrsGQ2nL8tLQ31e2uFt6HgzH;20:8/HjGxoZiguCDCzBggu1vIx0oAVozttg5bPLauXb0oAqlv5cpMB51hlVT0OnzUqD6uJTgm+sLIS/ybC7yr3qzehbw57meDNrq58FmvLWzxh4tSh616Adx80XRw5cKpFUIr0yRfc7j3ooa99XAR87FLRS0SwpjY2pHRcLyrF2CzcLgIXIEDHaLatX9O12p9onWfDEcuhdkrLAe0nwIkimHD5v9StlSrgqexZYnS49T1iUQ/9vjtJdOQ/D5VsZIIgpiXamrb9IgzwG9jxwGKW6PEn6g5JYXmheYaVy+ANmaYWtdxhjWsMka4s5RZVhP4gvaAkqGeWnlgZdS5HZhp+i9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39380400002)(396003)(39850400004)(377424004)(189003)(199004)(106356001)(68736007)(486006)(478600001)(229853002)(476003)(2900100001)(2906002)(7416002)(3280700002)(3846002)(3660700001)(5250100002)(55016002)(25786009)(53936002)(575784001)(6116002)(5660300001)(33656002)(9686003)(305945005)(86362001)(14454004)(99286004)(6246003)(81156014)(74316002)(97736004)(4326008)(81166006)(6506007)(8676002)(186003)(7736002)(26005)(102836004)(6436002)(8936002)(59450400001)(105586002)(7696005)(110136005)(76176011)(446003)(316002)(93886005)(66066001)(54906003)(11346002)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1700;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1700;
x-ms-traffictypediagnostic: HK2PR03MB1700:
x-microsoft-antispam-prvs: <HK2PR03MB1700F4523616C64978DA0A2492860@HK2PR03MB1700.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HK2PR03MB1700;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1700;
x-forefront-prvs: 06628F7CA4
x-microsoft-antispam-message-info: ZYG/E2Winiaz1Ja6zfXTwKYEwNecUUKJ3wiCfuktXwVul1nyJwrey796/MLDrCSKb8RdjbXlHT46YuGtDudXDK1dRkOLnoItMN643vj7NEtnWzc2qC0BSxq/lSib+rtok8n3BZRGQ8oBVdC184v7c1qDDBjZxkdmvsC4vkVPqg4SJY6um4l8tOHkORb7nDm7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8277aa20-fbd8-4259-ceda-08d5b1e77582
X-MS-Exchange-CrossTenant-Network-Message-Id: 8277aa20-fbd8-4259-ceda-08d5b1e77582
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 17:50:00.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44HoPvs026691

> On Fri, May 04, 2018 at 03:35:33PM +0200, Michal Hocko wrote:
> > On Fri 04-05-18 14:52:08, Huaisheng Ye wrote:
> > > Suggest using unsigned int instead of int for bit within gfp_zone.
> > > @@ -401,7 +401,7 @@ static inline bool gfpflags_allow_blocking(const
> gfp_t gfp_flags)
> > >  static inline enum zone_type gfp_zone(gfp_t flags)
> > >  {
> > >  	enum zone_type z;
> > > -	int bit = (__force int) (flags & GFP_ZONEMASK);
> > > +	unsigned int bit = (__force unsigned int) (flags & GFP_ZONEMASK);
> > >
> > >  	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> > >  					 ((1 << GFP_ZONES_SHIFT) - 1);
> 
> That reminds me.  I wanted to talk about getting rid of GFP_ZONE_TABLE.
> Instead, we should encode the zone number in the bottom three bits of
> the gfp mask, while preserving the rules that ZONE_NORMAL gets encoded
> as zero (so GFP_KERNEL | GFP_HIGHMEM continues to work) and also leaving
> __GFP_MOVABLE in bit 3 so that it can continue to be used as a flag.
> 
> So I was thinking ...
> 
> -#define ___GFP_DMA             0x01u
> -#define ___GFP_HIGHMEM         0x02u
> -#define ___GFP_DMA32           0x04u
> +#define ___GFP_ZONE_MASK	0x07u
> 
> #define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
> #define __GFP_HIGHMEM	((__force gfp_t)OPT_ZONE_HIGHMEM ^
> ZONE_NORMAL)
> #define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^
> ZONE_NORMAL)
> #define __GFP_MOVABLE	((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL | \
> 			 ___GFP_MOVABLE)
> #define GFP_ZONEMASK	((__force gfp_t)___GFP_ZONE_MASK |
> ___GFP_MOVABLE)
> 
> Then we can delete GFP_ZONE_TABLE and GFP_ZONE_BAD.
> gfp_zone simply becomes:
> 
> static inline enum zone_type gfp_zone(gfp_t flags)
> {
> 	return ((__force int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> }
> 
> Huaisheng Ye, would you have time to investigate this idea?

OK, it is a great pleasure for me, let me think about how it works in detail.

Sincerely,
Huaisheng, Ye
OS Team | Lenovo
