Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755745AbeDWPmg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:42:36 -0400
Received: from mail-he1eur01on0125.outbound.protection.outlook.com ([104.47.0.125]:21374
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755047AbeDWPmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:42:33 -0400
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "marvin24@gmx.de" <marvin24@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Thread-Topic: [PATCH] ARM: tegra: fix ulpi regression on tegra20
Thread-Index: AQHTqZQpuMUJhpgZG02Zgpan0LEyW6QJtogAgAUpqwA=
Date: Mon, 23 Apr 2018 15:42:28 +0000
Message-ID: <1524498146.4493.35.camel@toradex.com>
References: <20180219151252.29289-1-marcel@ziswiler.com>
         <6600596.BijQW1iq1K@ax5200p>
In-Reply-To: <6600596.BijQW1iq1K@ax5200p>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com;
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0501MB2474;7:mYW/P2bevFxlWt/4V76Pqj5DNSccZIrZ3kDrqdR3xv7G9uE0CKLMzM8ZraCNPIqJTdYAJvt5htCTmIkdVHAK+H36WsP/QHZdRfsp5olAGSMWy51u/JTfDEpqCNOoGiaPaGhjRHevn5nVli+Uzk/kCjrdrDYsJvACDUW+8TLUlpWdovEwPzaCIMwxTWvCdiqLHqNHxJtPye7CRA4/FGQIW6Xg8ssXAl1z0HqQgDZt6NlXCxV9cU83+n50QG9kSEiy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2474;
x-ms-traffictypediagnostic: HE1PR0501MB2474:
x-microsoft-antispam-prvs: <HE1PR0501MB2474AE3AC0514DCFBD1AF56FFB890@HE1PR0501MB2474.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0501MB2474;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2474;
x-forefront-prvs: 06515DA04B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39840400004)(346002)(366004)(376002)(396003)(377424004)(85664002)(6506007)(6246003)(8676002)(103116003)(3280700002)(7736002)(2351001)(3660700001)(66066001)(76176011)(2906002)(3846002)(6116002)(305945005)(14454004)(7416002)(478600001)(99286004)(6436002)(2900100001)(81166006)(5640700003)(25786009)(446003)(6486002)(229853002)(36756003)(316002)(54906003)(11346002)(8666007)(4326008)(8936002)(6916009)(5660300001)(39060400002)(2501003)(53936002)(5250100002)(476003)(6512007)(26005)(86362001)(102836004)(186003)(2616005)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0501MB2474;H:HE1PR0501MB2330.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: dzlv1anb5QLZ3z7rFq3id3f/I4t2ntUYWYwt77HzMNTdVLRYN/jqNXAEbdt/bIWrQqd076JxU0kZsjcUJLf6o/i3jrY6VJxoOIk7YIFkNHbID0nqFmjxFh++ltDqDYry22X53HxkQ+oEe/Wzj9Y/7qY+yHPXL4VarqhcjTqRbSFhOn3EvZpILzG5n+deQ4x+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9BFBBB465BFAF41BD8A445F94E1A68A@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f7d1147d-b8c2-4c03-0855-08d5a930d1e6
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d1147d-b8c2-4c03-0855-08d5a930d1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2018 15:42:28.6424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2474
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3NFgeUI017113

Hi Marc

On Fri, 2018-04-20 at 10:52 +0200, Marc Dietrich wrote:
> 
> ...
> I booted 4.17-rc1 (which includes this fix) on an AC100 (T20 paz00
> board) and 
> the error above is still there. Surprisingly the error vanishes when
> I revert 
> your patch. So this patch actually *causes* the problem above on my
> board.

That's really strange.

I believe I do have one of them paz00 boards laying around somewhere as
well. Just need to dig it out again and will give it a try. Looking at
their schematics at least reveals the exact same circuit as found on
all other T20 based boards using DAP_MCLK2 as REFCLK to the USB3315C
which BTW is 24 MHz and not 26 MHz as CDEV2 claims!

> Could it be, that we need all four clocks? Dimitry mentioned on IRC
> that it 
> could also be a problem in the clock init table. I don't have the
> technical 
> background myself to fix it, but I still wonder what could be so
> different 
> between TrimSlice and AC100.

I am wondering the same. However I still suspect that something is
completely wrong in that area as that CDEV2 clock is completely bogus.
It really does not exist!

> Marc

Cheers

Marcel
