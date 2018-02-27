Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeB0QKC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:10:02 -0500
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:6020
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751004AbeB0QKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:10:01 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <jg@lightnvm.io>
CC: "mb@lightnvm.io" <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: simplify geometry structure.
Thread-Topic: [PATCH] lightnvm: simplify geometry structure.
Thread-Index: AQHTr+O4TLRIu8wXYUyKRbyBMvBmjKO4aw1f
Date: Tue, 27 Feb 2018 16:09:59 +0000
Message-ID: <A1101358-5262-4AE5-B486-83344B99A7AD@cnexlabs.com>
References: <1519747032-25704-1-git-send-email-javier@cnexlabs.com>,<1519747032-25704-2-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1519747032-25704-2-git-send-email-javier@cnexlabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3505;6:WiE3hVYSyS1uWm628TZrpxeau7S+lwucio6WgIv/22QQuVeBSqagCxQE+r9mSzZhCmh+EaHt0XuJXQcKiD9tnZ3RIgCNaiSjNypCHoyN3YYOQ2a9gqjU/C+dXqtxKRvzcJPYU7yJpnqtpVHGgXSekEVEhq2lxrqpApsHEC2Y2HI4sur1blFYs2ngpU8o5HM/xVLmkdPM7wKGHO6eogdAn5WcS7fu6qoHyevc4CKueZm8xq4jsZGqGan5QoHiiHYOhDLnAwHHD3e7llqAKmHHGtcJLi+1CIMyT9N7JvMPRA1+lCA0cdGZdxVFS71fEEMzGVHSJW/vO4nAa2Z/bS5HhwFAMxH43Fxb+ghxwQ3IASud2DDjWLoTNxGAEgZ9kNd0;5:G/G9FDYuLb71r54WbBX7/znYrmLNUGRTCmAf1VhkTqnQ0c+tHi8q5itb/1gcc7ersVKqawNCsVmyLKcqWfGdJt5fXDwYcY7p1dn+UwBbiah7Emw1DB0SHQBQ0P+Gx4CH9QtFHE6iQL5DJOpsuLr/SmRaFOlsH+m6GowwLR6c3JE=;24:b+mLdLWqDgR5+O6wmpZSSOlepwrgsJ9PMahAFUiPNF6KxkyXacvDglej/+gA+XO0a40gzYs41EeR4dmCw9foE4b0yeld7VX0rSUekVFtsyc=;7:0IZAxqbjRRx/bkQYUM64HsJ0LCEFQFrpQKLEnc3Clkr9P2O/9zS6Jh6pricWYf3W39xI0nwSHtNhTpF8yePRsn2E+jEeJEbt7JUfSK0XeTKZAUorvbWXSmiFiCgaPgPOeBraML7F/EfNTy2/cq2ekZOx4CoDEv1Vyzvy5cy/b1855gJZH2RcNssNUNFEll5JaY4TbhjK2fV6qGn2d80z84NIaW2X8X4OEj3QmflpCgHQoRp7pOxWo0SNaT09mhFO
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 72b05afb-4901-44ce-033a-08d57dfc8cf9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BN6PR06MB3505;
x-ms-traffictypediagnostic: BN6PR06MB3505:
x-microsoft-antispam-prvs: <BN6PR06MB3505A263F9A65478E186824BBAC00@BN6PR06MB3505.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501198)(93006095)(93001095)(3002001)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR06MB3505;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3505;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39840400004)(366004)(346002)(39380400002)(396003)(199004)(189003)(26005)(77096007)(186003)(6346003)(97736004)(102836004)(86362001)(66066001)(6506007)(105586002)(83716003)(82746002)(33656002)(2950100002)(2900100001)(6916009)(106356001)(6512007)(6246003)(7736002)(305945005)(5660300001)(229853002)(2906002)(3280700002)(6486002)(6116002)(25786009)(3660700001)(4326008)(81166006)(3846002)(36756003)(8676002)(478600001)(316002)(6436002)(54906003)(68736007)(81156014)(8936002)(14454004)(76176011)(99286004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3505;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-microsoft-antispam-message-info: dk1fw5XhXtxnzcwN4JlilCf51+yUE6DXjanWfqskwuzGj7B+Hy0JLQsU+gluG/WYzbd+UaZGaaspATmX8O/snHEI5m+tEC8NNBzXhvES2Fe+d21/j4GjM3RtdRxjIXsI1rssigwxi6Bl9yXf3ibBnWfFbI8uYV2+DYJqsHXCdUA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b05afb-4901-44ce-033a-08d57dfc8cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 16:09:59.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3505
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RGA9i6031392


> On 27 Feb 2018, at 16.57, Javier González <jg@lightnvm.io> wrote:
> 
> Currently, the device geometry is stored redundantly in the nvm_id and
> nvm_geo structures at a device level. Moreover, when instantiating
> targets on a specific number of LUNs, these structures are replicated
> and manually modified to fit the instance channel and LUN partitioning.
> 
> Instead, create a generic geometry around nvm_geo, which can be used by
> (i) the underlying device to describe the geometry of the whole device,
> and (ii) instances to describe their geometry independently.
> 
> Since these share a big part of the geometry, create a nvm_common_geo
> structure that keeps the static geoometry values that are shared across
> instances.
> 
> As we introduce support for 2.0, these structures allow to abstract
> spec. specific values and present a common geometry to targets.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
> 

Please ignore this commit message for now. It’s not updated...

Javier
