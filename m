Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDUABi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 20:01:38 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2724 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeDUABe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 20:01:34 -0400
X-IronPort-AV: E=Sophos;i="5.48,469,1517846400";
   d="scan'208";a="173077241"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "mguzik@redhat.com" <mguzik@redhat.com>, "jack@suse.cz" <jack@suse.cz>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] fs: move documentation for thaw_super() where
 appropriate
Thread-Topic: [PATCH 1/3] fs: move documentation for thaw_super() where
 appropriate
Thread-Index: AQHT2QOWd++toRLqEUGI9KZ8oCyMJ6QKVcUA
Date: Sat, 21 Apr 2018 00:01:31 +0000
Message-ID: <0e6973564f4b2c503f343f63ca1209687f53b312.camel@wdc.com>
References: <20180420235904.27496-1-mcgrof@kernel.org>
         <20180420235904.27496-2-mcgrof@kernel.org>
In-Reply-To: <20180420235904.27496-2-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1167;7:naa4eWHeXyeDmNYQ4qzYE1NbUzLs9OchOZZj99TUnq+Ll4IAQ0t6iQQ01YESoxxWDtv3AJCqfYl7GjDVKveSdTd9qCHv88Vnx5HuZB7o7fLM7rvN6e6IzikcZJPiaBVeTPg/3CMac5BqoihLIAfNb4qUPVD7QFCg4PmQPP/AAJl7UHn221VxdFGAuW1EdDirkSIJp6DKuuU1KoXOR/ITck+2W+LL7qcLg3U1iGDEPl9DzVejruXROfb0toptW7Sd;20:Na4+NEjMMIzbsKVYY91ledOoRGY9OAwlccffiZMhMRTOsJ7wf333F1BImMfnhijjnGF/4dxTdvNjw162GA839yOeJRryxQnJ7M1pNOjVQyQdRbrhh32mCK8Oiq/a3KHUXbB77I8kC1CObPMByI/ZxsuJqtX3eJztHaB+9BZLXu8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1167;
x-ms-traffictypediagnostic: MWHPR04MB1167:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB11674758F27B0E48BD8718AA988B0@MWHPR04MB1167.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB1167;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1167;
x-forefront-prvs: 064903DDDC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39380400002)(346002)(366004)(376002)(39860400002)(377424004)(54906003)(3846002)(14454004)(5660300001)(305945005)(86362001)(81166006)(5250100002)(99286004)(7736002)(2201001)(66066001)(110136005)(316002)(76176011)(26005)(7416002)(102836004)(2501003)(6506007)(72206003)(8936002)(186003)(229853002)(2906002)(478600001)(2616005)(8676002)(36756003)(25786009)(6116002)(2900100001)(118296001)(446003)(6486002)(6436002)(53936002)(6246003)(4326008)(3660700001)(6512007)(476003)(3280700002)(11346002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1167;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: an1urhexjfnWNCMsTjsY4nOwI83Y1zjgZzLo2rQMlTsUZcQnC3UJatQk/jvxu33/aNtqrG8vf3AUAaeOv8iRvW/B/VyNBIEXG1xJXsZDB97afne5HR+6lF6lTIUJjlXvM2H/mDRSKS+rb1Q1Dm1e/WjG+S925afYvz+1QOBh+Jgz+YxzxNJxTRWZamKmrLmB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C980649F5A3A2047A229F315F36D8B47@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ccef416e-e575-431f-c83c-08d5a71b0a09
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccef416e-e575-431f-c83c-08d5a71b0a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2018 00:01:31.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3L01iUu000926

On Fri, 2018-04-20 at 16:59 -0700, Luis R. Rodriguez wrote:
> +/**
> + * thaw_super -- unlock filesystem
> + * @sb: the super to thaw
> + *
> + * Unlocks the filesystem and marks it writeable again after freeze_super().
> + */

Have you verified the output generated by scripts/kernel-doc? Last
time I checked the output for headers containing a double dash looked
weird.

Bart.
