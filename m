Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeCGSiG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:38:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25638 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:38:04 -0500
X-IronPort-AV: E=Sophos;i="5.47,436,1515427200";
   d="scan'208";a="73662514"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>
CC: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 0/6] lib/scatterlist: Small SGL tidy
Thread-Topic: [PATCH 0/6] lib/scatterlist: Small SGL tidy
Thread-Index: AQHTthKFy9l8vkD6UUavP10r8eSYM6PFGrEA
Date: Wed, 7 Mar 2018 18:38:01 +0000
Message-ID: <1520447880.2890.43.camel@wdc.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
In-Reply-To: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0561;7:nJKh9xVAKcnUcxeWo/VYKjkj14uf4YwoRL0BEE7Fj20j5vmY7c17PrrftuBjDcLXs4A6pFpbNGiYmj5xQZ6tMOKMYTTKSBY0iks2l2f/FogAvTI9PxJna3tfCD2CmxUunOCuhp8Nrxib8i0sIcXJ9XJL1RmZFT1W8WFz4Vy3JYwbjO5tK1C2p/xiI1KQXgLyePofkxehAne9C5wAn0n5SQc2BwVzRKYCTuZq4XHKfWRzMnLkk/rHK3y9C0aFaZ5r;20:k5xS96aKf4QSFHc9vI9jwM9fb/NM2+SyNst7/6NMnEJO2InkH8gicVNV8nV6rn3l5wwp/p/9Nrp+fuRa+tJ15oatdy6NP/KyqhFc2xa+6aYgvSVPTpeMCQuz44hwDY/3xUXmjKuLgWxTEAm4Os3UlEJH7xfSn1xSjMaXUaKLgrU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 579f15c0-2487-49d9-2290-08d5845a8ebe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0561;
x-ms-traffictypediagnostic: MWHPR04MB0561:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB056187128A62131BC60065B498D80@MWHPR04MB0561.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0561;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0561;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(189003)(199004)(377424004)(6436002)(186003)(6486002)(2501003)(14454004)(6512007)(76176011)(2900100001)(86362001)(26005)(25786009)(8676002)(3280700002)(3660700001)(99286004)(229853002)(53936002)(4326008)(6246003)(5660300001)(2950100002)(2906002)(3846002)(316002)(105586002)(6116002)(97736004)(102836004)(6506007)(81166006)(81156014)(36756003)(110136005)(54906003)(8936002)(103116003)(66066001)(68736007)(72206003)(478600001)(7736002)(5250100002)(106356001)(305945005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0561;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 65gIUvTiBaDfhTX0Py9BL4JYh4QrAe9qW7jQwhStu5xCTUnqSRes7bHKKu8FZgV9aIpo0odOwq0rf4vV1zlgdaZ1Gk6yd5GsJ3n4xnCMJDh6HXO/MXdIAgtLtd/f0etiVaeApezamnyI0eHEFnB6YwbdKDJ1RSOZAbtaA7lcMtActxYm/dZicnc1wLNnAOtJv9hoeifUpolF9Kyf9yG1MskGKJPdJHQ84Glui5t0uIm2AQtASyloFcdzddxLDY9VJKn9G4FW588bXK0XAnGRFkGPId305t5T4APGD1K0/L/EZvKTGskyNCavVUfrj8nQLmxBOQ/kslArLG+hI72hmg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F815E04576E534FA80D0DD234E492EC@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579f15c0-2487-49d9-2290-08d5845a8ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 18:38:01.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0561
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27IcE6b003521

On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
> I spotted a few small issues in the recent added SGL code so am sending some
> patches to tidy this.

Can you send the fixes as a separate series and keep the rework / behavior changes
for later such that Jens can queue the fixes for kernel v4.16?

Thanks,

Bart.
