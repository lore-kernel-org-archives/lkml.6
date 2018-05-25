Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965432AbeEYJn2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:43:28 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.2]:31948 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965130AbeEYJnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:43:25 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wTZxjH+95d707k3FEgPBBxS7Mtk1Fi3RI
  vWdyI2ZIzCmH+sRhZNq9663VrC+nVrWxZVnUQV1AbcMVVdDBWLD8mWrEz+KPI6gaMxQSXTZHI
  AAeCZJvo1Kw6dtcTt/33fd7P931+vHleGjf4qRxa9LhFl1OwG8kUQro+hpm6h6nSFb7Qcq6hs
  4PkvjgrcfXbL1DczuZOkmttP49xjbEXuJqGHYgbmghT3MXuBpK72jGv506GzmLcjTstOHdg+x
  7EJe4p4G5XHVb4GH88nMdH2j4h+chcLcX37U8QfOxgB8XXXTqM+G/++JHgT132kvxgY5zij3/
  /AX/irxf5yruZ/K3IshJmk97mtJR5NuulqvFBvHw821Pnm8K8aC7Dh1JoA3sNQdO39ZgW9CKI
  z0T1akCwYRyC568gjezG4E/vFKkFowiqjk5SPrSIJtnl0D/7E67qDPZJ6NwzQqkmnO0hoXJyk
  lBBOlsCiXgloZlehdm+MKnpNXA7XKVXNcE+BYHAPkzVDPs6TPhbca3arwii9TuS1Raxz8Ph7p
  HkZcTmQmB8NHkBZ7PgYCCYTAQsC1+evoBrOhOmJ/5WzmnFvwF+63pDlcAaYXh6tebIhaHPq5N
  TAuvXw7FzA6QGzPBdawzXgI+EQ/enMA1EEZxrlTWdBx9X11KafgfO3HqAFs53xYMP/cugbfcY
  oSWK4HDUf/0hWArD+8YoPyoI/mcGTedD46k5UtPPQkvTDTyYfJg06P/sGtGIiDb0jCy63hVdp
  udWFFhcNqvkdgg2u8lsXlngEGVZsIp2wSIXbClzRJCynR/pdOgkSswX9aJsGjNmMv0hqtSwxF
  K2tUISZOlN1za7KPeipTRtBIZSttiQ5hKtouctm11Z8QUMdKoxg7l0WcGMXC44ZJtVQwPIRHd
  01dbgBsJZ5hRzspg7qolVTdI256MUCx9lCOXmpDNIp9MZUstFl8Pm/j+fQVk0MqYzMTVLqs3p
  flRpRmkCU5o40p5swi38i3K8KOXn+7/vH1k3tbNYLC5827Ipe1X/VyXvb5G9T5gv9rWsjV0xb
  Vi1/rUDPdWh8N6i9oG1FS8Fi2oqpCqsoTl/vunlUNS3xDr/4e0jq9eVrt9YsXVx2s1X7u0Nxg
  Kdxx40F26M/hA2DTx98yp/aE1iOrc4/rinp27268WDu0Z+GS3P//S9lXYjIUuCOQ93ycI/UQm
  eJyMEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-7.tower-168.messagelabs.com!1527241399!70494808!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        Ocean HY1 He <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [External]  Re: [RFC PATCH v2 00/12] get rid of
 GFP_ZONE_TABLE/BAD
Thread-Topic: [External]  Re: [RFC PATCH v2 00/12] get rid of
 GFP_ZONE_TABLE/BAD
Thread-Index: AQHT8fwDC41BG7Nw7kKYsFRFURgRZqQ9b40ggAFfPYCAAVqTEA==
Date: Fri, 25 May 2018 09:43:09 +0000
Message-ID: <HK2PR03MB1684ED6EC6859A88A196DC0C92690@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <20180522183728.GB20441@dhcp22.suse.cz>
 <HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180524121853.GG20441@dhcp22.suse.cz>
In-Reply-To: <20180524121853.GG20441@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.253.18.226]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1362;7:35iKEqCoI/SWozhr6NnUfJUPFd4+0Qi8zsVe4PgT6KO0/ThlssgFW+jGWH8/wHTr/b3232uJNFg7dfe0zD5H+ItRzGs2LPm0vCFdJJHfV6sfoeEIHWIKfre/z4I/C7heW9Evq4kIEZpnQFRhG19nKJXmxU6RpU1FAi8V+He3yRC8ukY+DAOmZuUGrDwkGZeCq44AXoE09fnfCwLrvec+DR+xr819J+K/g3JZlln2wGNscU+9Aj7rp8AWSU2dl4fY;20:ZrEiUD/muCY0Egc54FzJ/2Kx4NwqYm7qXMYvaxAVTYK7ByDxNBf3zu4IQNNrjZjfG3fRnvXrM45R81sOVvz4UORw4sonmtZ90ELBzEam3nhf6+XTzbB9Oqzt/6vFA5reeotR5wFUC8b9UBAwYnMVacsk97uYWWqS5MVnRsD9Jbqnq7iZWvidkeDC4HtG1ieNWxlLpN+zGvxFsl0Gd09yK6ERzNli3UaGPP+BvD+C/lUIsVUd7+C8/UgS0EiAvaiiV0rMAWiCZZfMjmC79Wbk1t/qZxCwlvD90dm4O/m8S3pfMufNT+f1GK/dP5qHph2RemKNwlHYSsLvLPGvmOR+9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(76176011)(59450400001)(9686003)(6506007)(102836004)(6116002)(3846002)(229853002)(186003)(6436002)(26005)(25786009)(5250100002)(5660300001)(486006)(6916009)(86362001)(3280700002)(8936002)(97736004)(7416002)(478600001)(3660700001)(14454004)(81166006)(81156014)(55016002)(446003)(11346002)(74316002)(33656002)(305945005)(476003)(8676002)(7736002)(93886005)(68736007)(316002)(54906003)(4326008)(99286004)(66066001)(7696005)(6246003)(2906002)(2900100001)(53936002)(106356001)(105586002)(26583001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1362;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1362;
x-ms-traffictypediagnostic: HK2PR03MB1362:
x-microsoft-antispam-prvs: <HK2PR03MB1362E575C6D56EFA1DBA5E3492690@HK2PR03MB1362.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB1362;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1362;
x-forefront-prvs: 06833C6A67
x-microsoft-antispam-message-info: 3RRMXl47Dqq/bKKO+0kCmCt7OmTcFsNwwi1jljLEhFZP7BXsi2dq8I55Q7ryS64gKAYr9RE5G+m5Sh2jC6MsyUVHgnDVAM76zCqy3FjTjbmCjrrpP3YFjjIsh9v5W7EP0HHF1h/rCtQzEMDsizxA5DBTcgfZU9kvJSMfj5rkIOZVad/tcKOy6nGhi9cIfXHW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b956728e-65b3-44f6-a97d-08d5c223ed21
X-MS-Exchange-CrossTenant-Network-Message-Id: b956728e-65b3-44f6-a97d-08d5c223ed21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 09:43:10.0332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1362
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4P9hYXd007073

From: Michal Hocko [mailto:mhocko@kernel.org]
Sent: Thursday, May 24, 2018 8:19 PM> 
> > Let me try to reply your questions.
> > Exactly, GFP_ZONE_TABLE is too complicated. I think there are two advantages
> > from the series of patches.
> >
> > 1. XOR operation is simple and efficient, GFP_ZONE_TABLE/BAD need to do twice
> > shift operations, the first is for getting a zone_type and the second is for
> > checking the to be returned type is a correct or not. But with these patch XOR
> > operation just needs to use once. Because the bottom 3 bits of GFP bitmask have
> > been used to represent the encoded zone number, we can say there is no bad zone
> > number if all callers could use it without buggy way. Of course, the returned
> > zone type in gfp_zone needs to be no more than ZONE_MOVABLE.
> 
> But you are losing the ability to check for wrong usage. And it seems
> that the sad reality is that the existing code do screw up.

In my opinion, originally there shouldn't be such many wrong combinations of these bottom 3 bits. For any user, whether or driver and fs, they should make a decision that which zone is they preferred. Matthew's idea is great, because with it the user must offer an unambiguous flag to gfp zone bits.

Ideally, before any user wants to modify the address zone modifier, they should clear it firstly, then ORing the GFP zone flag which comes from the zone they prefer.
With these patches, we can loudly announce that, the bottom 3 bits of zone mask couldn't accept internal ORing operations.
The operations like __GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM is illegal. The current GFP_ZONE_TABLE is precisely the root of this problem, that is __GFP_DMA, __GFP_DMA32 and __GFP_HIGHMEM are formatted as 0x1, 0x2 and 0x4.

> 
> > 2. GFP_ZONE_TABLE has limit with the amount of zone types. Current GFP_ZONE_TABLE
> > is 32 bits, in general, there are 4 zone types for most ofX86_64 platform, they
> > are ZONE_DMA, ZONE_DMA32, ZONE_NORMAL and ZONE_MOVABLE. If we want to expand the
> > amount of zone types to larger than 4, the zone shift should be 3.
> 
> But we do not want to expand the number of zones IMHO. The existing zoo
> is quite a maint. pain.
> 
> That being said. I am not saying that I am in love with GFP_ZONE_TABLE.
> It always makes my head explode when I look there but it seems to work
> with the current code and it is optimized for it. If you want to change
> this then you should make sure you describe reasons _why_ this is an
> improvement. And I would argue that "we can have more zones" is a
> relevant one.

Yes, GFP_ZONE_TABLE is too complicated. The patches have 4 advantages as below.

* The address zone modifiers have new operation method, that is, user should decide which zone is preferred at first, then give the encoded zone number to bottom 3 bits in GFP mask. That is much direct and clear than before.

* No bad zone combination, because user should choose just one address zone modifier always.
* Better performance and efficiency, current gfp_zone has to take shifting operation twice for GFP_ZONE_TABLE and GFP_ZONE_BAD. With these patches, gfp_zone() just needs one XOR.
* Up to 8 zones can be used. At least it isn't a disadvantage, right?

Sincerely,
Huaisheng Ye
