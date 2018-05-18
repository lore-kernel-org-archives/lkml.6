Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeERPMo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:12:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11625 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeERPMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:12:39 -0400
X-IronPort-AV: E=Sophos;i="5.49,415,1520870400";
   d="scan'208";a="78633351"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AA==
Date: Fri, 18 May 2018 15:12:27 +0000
Message-ID: <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
         <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
         <20180518090636.GA14738@kmo-pixel>
In-Reply-To: <20180518090636.GA14738@kmo-pixel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0429;7:zJzYUtZtBZPVZSxG+N8/Pzve/+50GAS2OelCdov/unXK0ZbTs4xW2XmUhATFayBinWHrusfonKE5SN+LVgonOcxVzKXY/d+6WR3MMtIx8rn1ph4ONkzXk0YjtZMbPtqyX57P8JumzW3VEitVWwBQRwz6ey4ehfmjzcNldWI35lwebKnss9mGSZGxL8Tt0LYbvWbja66eP1WB6qxy8od6CSIRSJREB7FUVEEH4WkNa5/1rWlu3codF0MapHwPNWSz;20:m1PP9fl9vFkPvOHiAc/hvead0wE3TIgzdE3P+jUJUvkG/KpjyAeHfFKU1i2xx6FRTThD7mr/FgwaFz83JV8yDT/arOwZi+VkH/4SUCnyc3SgA/xbj7xFh74ncd5YzqgpnqfQNd/1hOkvYdmdVGSnUgi3K+TC1GOJrS7OSyAlBsg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0429;
x-ms-traffictypediagnostic: DM5PR04MB0429:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB04296023E3E5ED1F93DB4DE898900@DM5PR04MB0429.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR04MB0429;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0429;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(377424004)(189003)(199004)(68736007)(5250100002)(6116002)(2906002)(1361003)(3660700001)(2351001)(2501003)(3846002)(305945005)(86362001)(2900100001)(102836004)(26005)(7736002)(54906003)(316002)(5660300001)(186003)(66066001)(3280700002)(97736004)(59450400001)(966005)(105586002)(5640700003)(106356001)(8936002)(99286004)(72206003)(476003)(229853002)(446003)(118296001)(486006)(11346002)(2616005)(478600001)(81166006)(6512007)(6506007)(76176011)(39060400002)(6306002)(6436002)(8676002)(6916009)(81156014)(14454004)(25786009)(53936002)(6486002)(36756003)(4326008)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0429;H:DM5PR04MB1196.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 11CVyfQBFTqPwQSzCHkSKaIsFWtnqZ81xMerqRRgsaJkJhCcqpRrkLD3WvroV6ukgNZfKqehvYWxFlELl/bagNUTOn8krSnSHOCjMd9b8Rl6IwTbeNWzQXNJDqDR8B2lVAwwiV737xxsx6ZbiUC4t69TnEXaMvN97Cm3x3qaKztWAnoXSKCCz8NypA3gliH6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C4296218527E847BF86FEDDA17E97C3@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ab4c6ba4-6250-4837-ed53-08d5bcd1c4e7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4c6ba4-6250-4837-ed53-08d5bcd1c4e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 15:12:27.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0429
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IFCnU3029413

On Fri, 2018-05-18 at 05:06 -0400, Kent Overstreet wrote:
> On Thu, May 17, 2018 at 08:54:57PM +0000, Bart Van Assche wrote:
> > With Jens' latest for-next branch I hit the kernel warning shown below. Can
> > you have a look?
> 
> Any hints on how to reproduce it?

Sure. This is how I triggered it:
* Clone https://github.com/bvanassche/srp-test.
* Follow the instructions in README.md.
* Run srp-test/run_tests -c -r 10

Thanks,

Bart.
