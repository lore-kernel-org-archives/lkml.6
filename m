Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933658AbeEIEWk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:22:40 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.201]:47097 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751217AbeEIEWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:22:38 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTb0wbZRz2vf9buO0oMH5rBtO6zIzIPzXx+KD
  i/LDLwpLF+KkS9crOa2Nbaq/MGsUwkYjQVjaXbutqthiM8m9NCk5WcTho0G6LBDbNIiiyYWYb
  KBugTHHoHVem3oc3z+/3PO/ze9437zG4IUgbGcnrkdxO0W6iNhJyYerh4tbXFsxl8e5SPhzpp
  viPzlv5Y4dGab4ruo+/EgtT/E/df5N84+EJmu//+DzGTwUq+abhcwR/8p00yc9NHlPRoQDiV+
  6EqcpNwvDsPC6c6+nEhN5Pi4TowhFa+Ob4CiG0nlwlhNu//EAIkb7vCOHy6Tgt9F56Q/jszye
  FpuU8YTFauJ81kzanpdb7EmmNhlYIV3CrN3bhbawBzUIL2sgYuJsIQuM+TC/iCP7ypymtIDgf
  DkvhPlpn/BgMJO9kZJMIBgc/UWUbGIrbBYnZ73GNyOX8CH691k5oBc75SVge68U0VQ4nQ9Oly
  7SGczkrxO42Ejp+BE6NvIdrmOB2QCo9oWKGYblqSPffr09rwOBMOLmm38A9Dd9e+31tMuIKIH
  h9as0f5/Lhw2CI1DBwHLQPjOI6zoPkjdVMfzu83+UndFwA46dakTYAuDYSfMk2TCfK4euOQVw
  nDlPQstpC6MVZBAO+mxnbIrg6nKC0qIh7FtJ9L+jtVyDxRZhclzTHQxnTQuj0T2d8OnCYS9yi
  dWIbJI9/TrWh0tB/ThFSbXH1XiOxTPsBONo6TWuY5bIhcWKGOI2ITvSQIrkPSu7iR0ssbpts9
  ThEm724vIwvcUiKIsqSXbQoJTW1jihS3+V96tePBld3D6GtDGbKY6tu3TYbNllqD7xuFRXri+
  46u6QMoW0MYwK27OCC2ZDtlmTJ+7LNrj7udRqYLFMuW6CoNKu4RIdik3XqIqpguvuO+HBm5Ep
  QXWe01UA4a52SMZ+lND9O22Ctc96zW/9dxlGBMYdFakBDlktyO2ye//MplM8gUw47oLlk2Zye
  e1NTaiBMDZT987wWyCP+SxkbUNf2nsndi17zV8byxNTjS00Ve1yRzTUe+/TOV5+r3lLV/O5Tr
  i/bq0d31kfKekoDNyZkLKfmwI+NZP3d5cVKeVfvXrIza8uZJUus45m6rusnPhidK94/s+ePi7
  /tmxl74s3HzPEH6+VAqvHs/POOirG9zYuBuc1Vrh0jF4aE4beO2qirJkKxiuVFuFsR/wEYNBI
  uKQQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-9.tower-218.messagelabs.com!1525839745!22878983!1
X-Originating-IP: [103.30.234.44]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "mhocko@suse.com" <mhocko@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "Ocean HY1 He" <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [External] [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM and
 fill into GFP_ZONE_TABLE
Thread-Topic: [External] [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM and
 fill into GFP_ZONE_TABLE
Thread-Index: AQHT5oc89K0fVKx8vE2XYGyeMTEHcaQmvz4w
Date: Wed, 9 May 2018 04:22:10 +0000
Message-ID: <HK2PR03MB16847B78265A033C7310DDCB92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-4-git-send-email-yehs1@lenovo.com>
 <HK2PR03MB1684653383FFEDAE9B41A548929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <ce3a6f37-3b13-0c35-6895-35156c7a290c@infradead.org>
In-Reply-To: <ce3a6f37-3b13-0c35-6895-35156c7a290c@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [57.197.58.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1458;7:leQFuFiLPJTuS239mvheao23ex2/WuLr3E5QqFZ0ySWHjkyyxyEdwYpnzwXAVVd0ngJYQnMOTmGsEGBhIohGFXRHPBANaUfKU73U5aoP+M9oVUqF9xVhtM8RaJsGTT67XfPMSezBQojChmOSTbOZY4f7r7m4LQ6np8VHzSGHF+S/U6RUvxD+qryXjJ4Yps28zsHnO3P0dXLr9j6vynIS3BUcdD5qj5x418EnmW/1M2OQlci6huf7u8vd6r4J89/R;20:8TxJey9gP3Fs47ghvr2VruXuV5V5CV/oarH5CGfIjos3sC5/d3VPRvoSJFzh03S5vJ9vQ5zY6FapTPHxZvFOgepqN3m2AT0Ia3riUsLfBezCqBvOJZThxIjjP/qvFqay9mQWRj4IERiWPanynFByNBJ0MZN2Ctefz6aznBzs8uCzY6T4XQ4YRmDUuGfjLTUCSZZqzjanLWxYGMgaTfhcUcIirZaFwSzVZ5/ooKlRRzTvMkma+hZLWbiEHvXkXl4tL7zVKGMhiGYUZEPzKmI0PPdKjFHJMdtJj5DgZKITYtwMQPBWyEFQxb5TvFZCUJopQ78havYTCHiFWHG25bt1iw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(39850400004)(39380400002)(189003)(199004)(81166006)(8936002)(5250100002)(446003)(3280700002)(105586002)(25786009)(81156014)(93886005)(8676002)(3660700001)(106356001)(11346002)(486006)(2906002)(110136005)(7736002)(478600001)(316002)(2501003)(6436002)(54906003)(97736004)(6506007)(53546011)(186003)(6246003)(2201001)(26005)(68736007)(9686003)(53936002)(229853002)(76176011)(14454004)(305945005)(4326008)(33656002)(476003)(99286004)(2900100001)(66066001)(3846002)(74316002)(7696005)(102836004)(7416002)(86362001)(55016002)(5660300001)(6116002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1458;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1458;
x-ms-traffictypediagnostic: HK2PR03MB1458:
x-microsoft-antispam-prvs: <HK2PR03MB14583F377E7B41DC0B288C6492990@HK2PR03MB1458.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR03MB1458;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1458;
x-forefront-prvs: 0667289FF8
x-microsoft-antispam-message-info: Ek1cqmM4nAtAXhgaLrzI8wxy0j/5bKWYwX3JSw2o1fBV0m1UTUg0yc2LWSmfiAS/DyEXDDK7BQ8N6bs/9dNnw5WVYgfwnw1cxUnuI6HJ3/SYPEA1jHIL7pPKDQyetL3LocY1Ww7VYOCN4VB6cBgaspR7P5aUZBWuXGcabNCNr35vj2pkVaE3yRRHG4lC8diQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e8306869-04b7-4983-157b-08d5b5646f58
X-MS-Exchange-CrossTenant-Network-Message-Id: e8306869-04b7-4983-157b-08d5b5646f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 04:22:10.9992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1458
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w494Mk4S006793


> On 05/07/2018 07:33 PM, Huaisheng HS1 Ye wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index c782e8f..5fe1f63 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -687,6 +687,22 @@ config ZONE_DEVICE
> >
> > +config ZONE_NVM
> > +	bool "Manage NVDIMM (pmem) by memory management (EXPERIMENTAL)"
> > +	depends on NUMA && X86_64
> 
> Hi,
> I'm curious why this depends on NUMA. Couldn't it be useful in non-NUMA
> (i.e., UMA) configs?
> 
I wrote these patches with two sockets testing platform, and there are two DDRs and two NVDIMMs have been installed to it.
So, for every socket it has one DDR and one NVDIMM with it. Here is memory region from memblock, you can get its distribution.

 435 [    0.000000] Zone ranges:
 436 [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
 437 [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
 438 [    0.000000]   Normal   [mem 0x0000000100000000-0x00000046bfffffff]
 439 [    0.000000]   NVM      [mem 0x0000000440000000-0x00000046bfffffff]
 440 [    0.000000]   Device   empty
 441 [    0.000000] Movable zone start for each node
 442 [    0.000000] Early memory node ranges
 443 [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
 444 [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000a69c2fff]
 445 [    0.000000]   node   0: [mem 0x00000000a7654000-0x00000000a85eefff]
 446 [    0.000000]   node   0: [mem 0x00000000ab399000-0x00000000af3f6fff]
 447 [    0.000000]   node   0: [mem 0x00000000af429000-0x00000000af7fffff]
 448 [    0.000000]   node   0: [mem 0x0000000100000000-0x000000043fffffff]	Normal 0
 449 [    0.000000]   node   0: [mem 0x0000000440000000-0x000000237fffffff]	NVDIMM 0
 450 [    0.000000]   node   1: [mem 0x0000002380000000-0x000000277fffffff]	Normal 1
 451 [    0.000000]   node   1: [mem 0x0000002780000000-0x00000046bfffffff]	NVDIMM 1

If we disable NUMA, there is a result as Normal an NVDIMM zones will be overlapping with each other.
Current mm treats all memory regions equally, it divides zones just by size, like 16M for DMA, 4G for DMA32, and others above for Normal.
The spanned range of all zones couldn't be overlapped.

If we enable NUMA, for every socket its DDR and NVDIMM are separated, you can find that NVDIMM region always behind Normal zone.

Sincerely,
Huaisheng Ye 
