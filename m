Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033056AbeBPN5X (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 08:57:23 -0500
Received: from mail-db5eur01on0064.outbound.protection.outlook.com ([104.47.2.64]:24480
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032862AbeBPN5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 08:57:20 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: apply coding-style into ms5611_probe function
Thread-Topic: [PATCH] iio: apply coding-style into ms5611_probe function
Thread-Index: AQHTpyt7EwPHM4rRkk2lPnltJ6ZfHaOnDcWA
Date: Fri, 16 Feb 2018 13:57:17 +0000
Message-ID: <1518789437.9517.32.camel@nxp.com>
References: <20180216133841.3yt4ip3tbck7ihdm@smtp.gmail.com>
In-Reply-To: <20180216133841.3yt4ip3tbck7ihdm@smtp.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com;
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1265;7:WNjHyOQ+uFF6ZNRFqydakHMPg3N2nPWyR4llQbDhxc0lkISr3uPHomH/qXOG69I4yRracQf/jHHrzbbs/oTyFzItKkohFG0MzfkU56ttCeZq1yH1ky6yfYYEhXa9YhURdikHUMZo8A2wi9fjIhsjWrmvfqSkhh+0WzP0tL0jwd2tWUGAb7FJGbGQlyNbSHZoACMifSE6XOTJHarCxIV6k0sDl2KOpNH7Ja6CsddfIrlf79aQ3uygPxXIjMjN7YEI
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba524104-ad22-4277-c4d5-08d575453125
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:AM3PR04MB1265;
x-ms-traffictypediagnostic: AM3PR04MB1265:
x-microsoft-antispam-prvs: <AM3PR04MB12659D4472B01DC381C1BEFBF9CB0@AM3PR04MB1265.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM3PR04MB1265;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1265;
x-forefront-prvs: 0585417D7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(39380400002)(366004)(199004)(189003)(54534003)(377424004)(2201001)(6506007)(106356001)(53936002)(110136005)(36756003)(102836004)(5660300001)(316002)(59450400001)(25786009)(6246003)(86362001)(54906003)(2900100001)(3846002)(2906002)(66066001)(81156014)(8666007)(3660700001)(8676002)(8936002)(81166006)(68736007)(186003)(229853002)(6436002)(6116002)(105586002)(76176011)(7736002)(478600001)(103116003)(2501003)(2950100002)(5250100002)(6486002)(4326008)(39060400002)(6306002)(26005)(3280700002)(6512007)(97736004)(305945005)(14454004)(99286004)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1265;H:AM3PR04MB500.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Ow+gYWVFO9NptFqcQRsIxuhwHY7C3LtGREqYovo6eQtigtKF0XAknDMGZuZYkYXF9n7H9C/i2Km+gNo2E6jWWA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C9BAF018DF9884D872961B54ED92FC5@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba524104-ad22-4277-c4d5-08d575453125
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2018 13:57:17.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1265
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1GDvRW2020011

Hi Rodrigo,

Mostly looking good. Few comments.

Please read:

https://chris.beams.io/posts/git-commit/

1) Capitalize the first letter of commit
2) Use prefix tags to indicate the driver that is changed. Here iio:pressure:ms5611.

If not sure what prefix tags to use please use git log file.c and see the tags used by previous commits.
If not clear from previous commits be creative! :)

3) A better verb describing the change would be Fix instead of Apply.

So, the commit subject should be:

iio:pressure:ms5611: Fix coding style in probe function

4) Please correct all the occurences of the same coding style error (not sure if here is the case).

Other than that it looks good to me. Please send v2.

Do not forget to add under the scissor line of the new patch a small changelog documenting what
has changed since v1.



On Vi, 2018-02-16 at 11:38 -0200, rodrigosiqueira wrote:
> This patch fixes the checkpatch.pl warning and error:
> 
> iio/pressure/ms5611.h:66: ERROR: code indent should use tabs where possible
> iio/pressure/ms5611.h:66: WARNING: please, no spaces at the start of a line
> iio/pressure/ms5611.h:66: ERROR: "foo* bar" should be "foo *bar"
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
> 

^ this is the scissor line.

thanks,
Daniel.
