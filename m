Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbeDIVaQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:30:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54344 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeDIVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:30:13 -0400
X-IronPort-AV: E=Sophos;i="5.48,429,1517846400";
   d="scan'208";a="178618167"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "wakko@animx.eu.org" <wakko@animx.eu.org>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqICAAIUdgIAAU3eAgAAfGYCAAw0ygIADtuOAgAAFnoCAAAO2AIAChmAAgAAEUYCAAX/aAIAB6+aA
Date: Mon, 9 Apr 2018 21:30:11 +0000
Message-ID: <f9467e78ce05446e7a89f06713c36fb638d1b6ad.camel@wdc.com>
References: <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
         <20180401113721.GA8471@animx.eu.org> <20180401163604.GB25011@animx.eu.org>
         <20180401182723.GA31755@animx.eu.org>
         <595a10cfb387e6b2ab4d2053b84fed9b3da9e079.camel@wdc.com>
         <20180406014644.GA16112@animx.eu.org> <20180406020651.GB16112@animx.eu.org>
         <fb0640c203409a84ab1bfbbc41078a5416138ad2.camel@wdc.com>
         <20180407165335.GA2515@animx.eu.org>
         <1ff8d234cc565ba9701ce31899fca5faa597e050.camel@wdc.com>
         <20180408160254.GA22869@animx.eu.org>
In-Reply-To: <20180408160254.GA22869@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [184.169.45.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0704;7:P/jXO8gUwBtId6oCDoM1Ijme/mGVHFVix2NDdYr6mmmVhkR2vh23CcV2BnDnQMEOfh3RV0P327mAKoyj5Y1WkntpE6Hfo3LHLUyxy6yKgKo5upGX3d0havEFoo8xlvgUuaBWLzW9pyeWsfJN7yK5sCpa25rDxQ3wVHxASef9L+C7QrUam/azYE5KLdeiKjJ9QMncHdUSz6U71+X+XOZJYUPdSJamN4BT12P8UHM9mtHPbfyRhS/Ldbwci9KBmy22;20:8/HDcUUv9iN7Oryup8vWEtfXCid5qPtDgbhlOa00ZhUQvksXBA3FxcMRuO2mobgTkry3xXDHTEMqRdrHBqxyIGWLpYVelOxLkZ3KrYqL3dQ/4up0OMJSYEr6efP/s0SbXMh5mWJsakLy20LmLpNEzge5bgaYBjOFukiAD//G3uA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: eb05e965-3f38-4934-0762-08d59e611342
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0704;
x-ms-traffictypediagnostic: MWHPR04MB0704:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0704FD8BF422800F7C7C194A98BF0@MWHPR04MB0704.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(788757137089)(67672495146484)(278021516957215)(15185016700835);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0704;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0704;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(376002)(396003)(346002)(199004)(189003)(377424004)(6506007)(486006)(446003)(6486002)(575784001)(229853002)(86362001)(99286004)(118296001)(5640700003)(476003)(5660300001)(106356001)(316002)(8936002)(105586002)(76176011)(7736002)(2501003)(5250100002)(11346002)(97736004)(93886005)(2616005)(3660700001)(6306002)(6512007)(66066001)(81156014)(39060400002)(53936002)(6916009)(2351001)(59450400001)(2906002)(102836004)(25786009)(8676002)(81166006)(3280700002)(6246003)(68736007)(305945005)(26005)(6436002)(6116002)(72206003)(478600001)(966005)(54906003)(3846002)(4326008)(2900100001)(14454004)(36756003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0704;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: L42KG6duqCmY4SLbGpgsnhCZL9s9/YP2xNIJLQWcENEG76EUYcbtC8nLXBF9PMKWrwJNtZ0wDFZ0DF291nqtMEk7tC+5jywLvc81E7hgwzeB0Yj3t46HCIhmPfv6FtPweyVqtmoanyBT75aTOtVwYMoCpW6SEQALIbebSaR2GoHSFIqSn2uCy5wi5JRHh0miKwOL9NbP8YMY2Gf7Ke8Lyx0Nap7CvCg7NOelKWCjT3lceaoUPPopKrOmMkxMKZ5ExRCnoKl4KRTGuq2PQKHvl4BY/14PRRzFGNfKSxFCdkSDmg/RxiCbO3bnsqHlgZ36eFhtjWKNqjpocwHvl0ZgzZB9YoaH2oMzx0S/Ytm6heqIlmW8lY5j9DARS+nIg2uMX9wtYfn1px51sYGxas7ofa5cnrF4F3AGUQoVNiVzWtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C98B9809A64A8347B903667442CD7287@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb05e965-3f38-4934-0762-08d59e611342
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 21:30:11.2872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0704
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w39LUN3k009726

On Sun, 2018-04-08 at 12:02 -0400, Wakko Warner wrote:
> I finished with git bisect.  Here's the output:
> 84c8590646d5b35804bac60eb58b145839b5893e is the first bad commit
> commit 84c8590646d5b35804bac60eb58b145839b5893e
> Author: Ming Lei <tom.leiming@gmail.com>
> Date:   Fri Nov 11 20:05:32 2016 +0800
> 
>     target: avoid accessing .bi_vcnt directly
>     
>     When the bio is full, bio_add_pc_page() will return zero,
>     so use this information tell when the bio is full.
>     
>     Also replace access to .bi_vcnt for pr_debug() with bio_segments().
>     
>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>     Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>     Signed-off-by: Jens Axboe <axboe@fb.com>
> 
> :040000 040000 a3ebbb71c52ee4eb8c3be4d033b81179211bf704 de39a328dbd1b18519946b3ad46d9302886e0dd0 M      drivers
> 
> I did a diff between HEAD^ and HEAD and manually patched the file from
> 4.15.14.  It's not an exact revert.  I'm running it now and it's working.
> I'll do a better test later on.  Here's the patch:
> 
> --- a/drivers/target/target_core_pscsi.c	2018-02-04 14:31:31.077316617 -0500
> +++ b/drivers/target/target_core_pscsi.c	2018-04-08 11:43:49.588641374 -0400
> @@ -915,7 +915,9 @@
>  					bio, page, bytes, off);
>  			pr_debug("PSCSI: bio->bi_vcnt: %d nr_vecs: %d\n",
>  				bio_segments(bio), nr_vecs);
> -			if (rc != bytes) {
> +			if (rc != bytes)
> +				goto fail;
> +			if (bio->bi_vcnt > nr_vecs) {
>  				pr_debug("PSCSI: Reached bio->bi_vcnt max:"
>  					" %d i: %d bio: %p, allocating another"
>  					" bio\n", bio->bi_vcnt, i, bio);

Hello Ming,

Can you have a look at this? The start of this e-mail thread is available at
https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg72574.html.

Thanks,

Bart.
