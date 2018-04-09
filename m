Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeDILoe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:44:34 -0400
Received: from mail-eopbgr10103.outbound.protection.outlook.com ([40.107.1.103]:61948
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751774AbeDILoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:44:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 0/5] Add tda998x (HDMI) support to atmel-hlcdc
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180409105918.20792-1-peda@axentia.se>
 <20180409111733.GP16141@n2100.armlinux.org.uk>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bbc7a992-5f17-c108-2b6a-01a585e6e315@axentia.se>
Date: Mon, 9 Apr 2018 13:44:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180409111733.GP16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14)
 To VI1PR0202MB2782.eurprd02.prod.outlook.com (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a643e412-080e-459f-eb1f-08d59e0f3f90
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:1W5t70TtrDedeYQEtUQL2v1gfvK01GwOCj94G15xYB/VPuuT565F5YeYRVGwT30RFxW/SQQflvxCh6tMrxZiCgpnBLRcV8oxMkYxsSS2i4Oaijwat4OgnIe8iEVQi9j6hEBgTLtxoaTN1dGNTpBdKW9r4HxsRC0/e4f0xuQOxjIYvY5uKNIlAqbhE0Cki1l5Fgow5XU1ranTiMbWLFw5CZyODU7CnU5BNulZ0lF8rqIew0zs98eoYdDLisQMO8Cj;25:Ip0sPkzbRaLtOEA4K51+qrtqJIaAUhqB8c8bWhz70efRPfUI5EmwXcJSkdDV4jIMnsoi7Xwrv3jSiO6Ccll53/4GuSmmKNAS2vp1EfMGzEnKbBgM6x4pexSzWO50Bv4/PGyrtPUxRg1QEheM5WcUNhZToysGsP6CvQQQn4Odjn2SPAvG47KnBONzDZf5WTLj+furUNypw7M5UENZ8IyMWjR2OmajG4ysmAzptcdaq4Raxyb/s4jb54WJowoXYy4DdzMpvuPZCp1ySk1ggB0R35667EDpKljRPILRyNMs3eQfUfgcL1vVB5Y2EPF9AllrrVzsw4xzFVkcIQbUtKst5g==;31:IWAlz15kH+rzSN/78IEE47Salr3jprtUIwHVj/hepih7sqnGV4SHwGJRLclx3PjFBdY+YueZx7LnEt7BfmOTbwSnSrNAXoT+Q/pebYG2BxNEVbAQag+exfKN7vOX/QdwUUk+CfnfgEibIXtX68JbvMcMTKkbJjUV7E0PEDIsrh8P04Re/vDc8rbDWAd9cVRcU9Rniu9RQnZNiZoTXhXlyzqE99yN9wFUWJJs+rN7cfQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782E7BF880CA359D3C64046BCBF0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:0ZdfhqCA3vhWkizPsEb7jPklImk1TyU9i+hhvZu46BC1ZamDIlLgAVgETtpDFLQNeDSzPNlMDVSpFniFfzfst/u5ffMPcJj6WbfMCNABWahPkLjXyWVTs04BZNS5h3L214vB5UAmjbdSIvGHTO//JDvINQ7iSYQ1kYxX5y0T/tpSG3tooia6/5YQIa05GhlnyN+YtfOGM0dkOEgmRxYDtqr/hAU3CdYj6klrefTkP06k3aDQyueELt8Q/BhabHXeM4nv6UGL3AVZmJqw3R6ayw==
X-Forefront-PRVS: 0637FCE711
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(396003)(376002)(39830400003)(39380400002)(199004)(189003)(377424004)(58126008)(16576012)(54906003)(8676002)(5660300001)(81156014)(8936002)(74482002)(81166006)(65826007)(6666003)(6916009)(52146003)(23676004)(59450400001)(6246003)(2486003)(50466002)(31696002)(6486002)(86362001)(229853002)(52116002)(76176011)(305945005)(316002)(7736002)(36916002)(64126003)(36756003)(53936002)(7416002)(53546011)(65806001)(66066001)(31686004)(65956001)(2906002)(4326008)(97736004)(77096007)(68736007)(26005)(25786009)(186003)(386003)(47776003)(230700001)(478600001)(3260700006)(16526019)(106356001)(3846002)(6116002)(105586002)(117156002)(476003)(956004)(446003)(11346002)(486006)(2616005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODI7MjM6NVBRbVRHeFBmVVZPWmJ4b0NvM1lET2I1?=
 =?utf-8?B?VXM2UEJEZE5sMHhnUXdLMGNRdEhPeHlTZUszeGpZM1hYSnVhVUhYTGxMSzNJ?=
 =?utf-8?B?dkdvTUJYS280cnZnU1RTaFNoV3RnRUNvaEVHUXN1MUl6cUF2dHpoTWdkcFpn?=
 =?utf-8?B?MVdhcmZJNm9zZGtyZ3h4M2hVVHRTbno4VTlBeVRoNEl1b1hMZDcyR29OOUFU?=
 =?utf-8?B?VWNWQlhGemRFQ1NyRVJHZlVEM3RzVFJpVnVlS2RWN0gvMkxwU1dQNWl2NlBR?=
 =?utf-8?B?YzdQRkJScXhDZ1ZlZ3pQNUZWT25UbndtcWJkMTBadmQzWDBjQWRBN2J2a3Qr?=
 =?utf-8?B?VlZtN2orSnpXRGNmVzc3Y2gvejAzSlkwZnNBZjJqNDZvc3NzMzEvNEs4QStC?=
 =?utf-8?B?YksxbnpJSmVZTlFwN01yTHpSYnVpSDZ1SlFackJHTEMzdjJmQ1FOaFhVQVpB?=
 =?utf-8?B?VTNlcWVVR2I1V2tIaWk4emNDWkRTRElDczR5Qi9CNmdIUkl3RWpHRTBBbm5m?=
 =?utf-8?B?UG1oQlY0RDI2Y244anlJc2dZMU9xd1hQUU9BMW9leWRwZk5wVWRJS3lmYSta?=
 =?utf-8?B?WkI4WDEvemxOYXZ4ZUl5a1dhakhreXJsbHpFSC8rbkFhd25DUSt1NkRIMzhQ?=
 =?utf-8?B?azZwbzJnWThUZTdmTnR3QjBzbWhtTWZia1Vrb21VQ3U2Rzl3Tjc0STBVcGY2?=
 =?utf-8?B?Ymp4VnJuWDNXUm85bUdWNGY4dXBFOGw1NGMyNnRYRm13OTVReUVyRnkwaHRZ?=
 =?utf-8?B?bUFUeGEwaUVwK1N6SXo3Nm9XUjFVNnR3TjlqUnFLSzVxWXh5bHBBWWNEYjdr?=
 =?utf-8?B?T3JjOHBiZ3BBL3JjMGFDVUVsMVArYndjSzlBazYxRjVkUk5EaXZ1MkxMeDBr?=
 =?utf-8?B?bm9YNHIzZERKaFVSZHJUNE5BSThlem0wZlZVMk9tRFgzUE5UcFFOYlU1OGRs?=
 =?utf-8?B?SmlJam42L21zUXBmV0M2ZTVPNENMa0pPakJLMERIYitqanRoUnRSaGpuQnFM?=
 =?utf-8?B?Qnh5UTY2SnZXMHc0cnlUOEV6dnBXTmNjS2xiSFR3ejV0ZllHWVNJZ242T0NX?=
 =?utf-8?B?bmZFaXpYWHFwd1puTXYzandJUzVCNkRoYlJkTHk3Zk1obGNQZzNmS1RPY1Vj?=
 =?utf-8?B?T3A2dWRJTjlleGg5RmNyNUl5cmJhMVhxWjBnSGZTVVZYQVdyL0ZTMCtaQVdY?=
 =?utf-8?B?RG5wQ2F0TTJPVVIzdVI3bkRFK05TTW9nRW9PcGE5YlRCYXNmdFF2Q2V0U2tw?=
 =?utf-8?B?dkpXWC91c3FIRG9Mcm5MQklrTkhMSTB3VFpCTjlZcGRJc1dWWHRNdC9FaHNK?=
 =?utf-8?B?ODhZZjloKzRnZGJORHZRZ0RhamtHVjVnV1FvVHRlRHdTcjJ0Yk85QjRRS0l6?=
 =?utf-8?B?ci8vSE40dDJsRnRjQVhyamczazhlOXE2dGgraG5ESkV0QnliVXZVVHZINGlx?=
 =?utf-8?B?L0RqUm1VcmJLYjFCdjhoZTRtY0VDRHBHbTFjTFBpME92blpYNzNvT0RaOWs5?=
 =?utf-8?B?NFlpSlU3c2hVOG84VTRVUFFUaTMyeHVKbi9WMXBHbGU5cjdUUkVkWGM3cE1p?=
 =?utf-8?B?TklJSjd1RHN4a1VhVWdQMEdMOFU4NmZZYXpXc0JTQUU4cXZubW9CNXRpNEc4?=
 =?utf-8?B?Y0c0WkpMNFNONytUZ0w1bXNOSXpSMzE5V2llNU4va1JUaWNCTEU5MUJlUWJ6?=
 =?utf-8?B?RGN5NW5kWjMwRi9CeS9PaW9NY256V042QXllRFJHSW9qQ3hjTTZaTzJCa0ZX?=
 =?utf-8?B?ay9JS0g2VG9hUFl4QTBLMmpvaXBqQkJ6bjh4T3NwbHZrWDJJYTRuSXlrK2lx?=
 =?utf-8?B?WkJMVTZQVm9NY21ocjdpUjZOU3QvY0dnRldPc3RON0lBNm1LVUYyWm9aN2p3?=
 =?utf-8?B?bGxjRXpyNjRTaEU4OUxvK0lNa3lEK0hhdlBpNGtrVTZsRXEvM3REM0ZDc01C?=
 =?utf-8?B?RlBmVUFNeWEybEROdzFTdWhMQy9YMUFVSWN2VGpmUjJtbCtBS1hPQ3BzWGJt?=
 =?utf-8?B?K0QvY0w2bGVOZHEzZE0wQUl4UVUvTE5JYThUK0c0ajRNby9Cc0RMMFREdXhC?=
 =?utf-8?B?RXpMTHJjTlNKOFV1eXhUUm5IcEN5bk9iUS90aXhLSngwQVVQdHdaOThSMzFX?=
 =?utf-8?B?UlRLb1lkMzBjelk0Uk9oeXVMc1lNNkxqTUhZSHV1WVdYOCtxTWVXMTB5bUI5?=
 =?utf-8?B?L2ZkOWJ1Z0hReE5vY3hzT2IrUXdaOEE9PQ==?=
X-Microsoft-Antispam-Message-Info: rx4r+MxDEboIJjUGvTRzucc7su6FzMf0488FFxar52AYDhbQu9Jy6ZaSqDE00SWCGZtSdAFVsBGtGep+33cTgeC95KbLROxJ15JMzXJbg6bgB4ZAsLm2P1tQFxMLzUz84yw8PqB1VESlUgXSiHrhcS4RIbBamhQ/UXtSfMbAlgGjNTLMuOOqVy/InCX+hvyT
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:3wnOtugP8bY8bkW+j/5PvRBdKgF6asg8psiB4OBDfvrdzPggXxFjSB2E/Xx2fTecnNMTP4+FXs189C8ZggIUCMymn9tim11uXflZvNmP1XxSS8BYi2Pd8jl/PiqVWCZLWxE5AmGt8dU7BWU9+0sdl4H5BD6c0HuGBBLw1pYnifwBTLTP5BpYFPe86wI8rI0c0EmGQuSL4urXdBYrDDi7c0gH9a3J93olwEoaWKXRflhC6KQjwiXBdiGd0D6VmiMvxAysnKyBeoxQO+enCBwi6pjQwfIT2vE3V51sXGS6MRD/cohVw9qV23D5mlH3Am1Ayexr5ZPrJSkL3pxkfrwRdybmDnxl1RolsVwSBQSvcSBZ4PQnhsm7y3ABMkDWUUd5lBa1oOV5hWVplB8PsmbCzSiWrZ2sBlKNnjKXTzwYwfF6gzLP2iI7+zkl1zEhuKHkjzzESO1C0oFt8xSBUKtfOw==;5:4In25FL53RycBYBPpVkUfuUTO8JfZzaANETv0wkOhcDQ+TN9ByqtLvUmxuGZsGKz/QWAUf88OI/gNpUX0raZAFGtp3+0o1Fv5aXOlsBZJE6ihlUvl0liszPT9gxQXwFfFGT3OlUUviJEC0ICo6AdW480fF1/nPoBmwu2uIr+iKg=;24:QnsEJhV1h2dKwlKzzewVhU3HmlhRJTLkQntAPYXCbfcknlhM8a1EjAqNAZwXAxn/ZFgd5tRHhdVddUf7rpCsnfoQC/mLKa+L3045xzSYQ7g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:h63/BYGEdukfgmeyRoSZQVjUZMGu1gKSJqrpEhiD719Z4vaCTNofpMjRjQqtxSVlNjBmjEfxBbwBj/+7HqtV66kZZbskSUEv2Hihg+vg5C/1Waa4gfbNzqUOOxxrhfbx8Dnvr6jQ0aU1texN2tMUxc3cItJ/3snYmDOSSE4oEU5iOTt9on8etnO8ybGl6WDTNY869Qn31rTFSPCVqSAvWkddotoUaNdbAlx2oUYYjuFSD7+gIOOWbaJle8Jg3hUz
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2018 11:44:26.0015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a643e412-080e-459f-eb1f-08d59e0f3f90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-09 13:17, Russell King - ARM Linux wrote:
> On Mon, Apr 09, 2018 at 12:59:13PM +0200, Peter Rosin wrote:
>> During this, I found that the tda998x driver never sets the format in
>> the connector display_info. Thus, the atmel-hlcdc driver fails to select
>> output format. Since I had similar problems with ds90c185 lvds encoder
>> I added patches to override the atmel-hlcdc output format via a DT
>> property and things start to play together.
> 
> That sounds like a hack.  The tda998x driver doesn't set the format
> because it pre-dates the addition of this information in the display
> info structure, and none of its current users require that information.
> 
> As you're the first to require it, rather than working around the
> driver by adding stuff to DT, it would be much better to improve the
> driver by adding this information.
> 
> Thanks.

Even if I improved the tda998x driver, it would not be correct.

The background is that while the atmel-hlcdc driver supports rgb888,
our PCB is only wired for rgb565. And the tda19988 has rgb888 input
(we have the lsb bits tied to ground on our PCB). So, the tda998x
driver can request rgb888 and the atmel-hlcdc driver can say ok,
but it still would not be correct. So, where exactly do you suggest
that I model the narrowing of the display format?

Cheers,
Peter
