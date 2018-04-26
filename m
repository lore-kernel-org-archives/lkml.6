Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757319AbeDZS1d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:27:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4191 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757146AbeDZS13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:27:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,331,1520870400";
   d="scan'208";a="76852414"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tarick@google.com" <tarick@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "gthelen@google.com" <gthelen@google.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 6/6] IB: make INFINIBAND_ADDR_TRANS configurable
Thread-Topic: [PATCH 6/6] IB: make INFINIBAND_ADDR_TRANS configurable
Thread-Index: AQHT3YtYNkzAw6pPGEabVMjvkb21yKQTXQ4A
Date: Thu, 26 Apr 2018 18:26:24 +0000
Message-ID: <cdbccbcb15ed155243149a6ec3ee540df523990c.camel@wdc.com>
References: <20180426181935.32977-1-gthelen@google.com>
         <20180426181935.32977-7-gthelen@google.com>
In-Reply-To: <20180426181935.32977-7-gthelen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0590;7:z3TnQIBpNYwMstW5Z0eQKN2DEBPYZSxG80pnptKfSyzsOPgyOyh19uHRI76f/rkEofKP+FAK1R271UbsSBnhoi3YyoCh85Xm8Kog9FgADn6mcXrWxWgINfrzeOUc1Y2llBZNSMMX+WXbKp9oGllafCKPAM+LyL94e1uUfMW5sOmLF6p6GKsBiZAHGshTWBfg3BIvdotOEDe8ZfiKW1W+jxCjRGYuiPDdEKRgL+H9B8YBmC+VSdHW+AkYrDgygo6c;20:W7HjyiEv6jb5AtJ0A8oAQsovy/ZGPoXi5q9276S4fEuIiFPeXuSsUpqagcxuSvW87aUuwR5NJonXV3XEYqGdch7MNOUUeIwJor9O4h4GIo/OQ5Wyw68YSMGEloDjTk/uFfdIHgxj1eArx+FiGx2U+wV7HJtMAgiobUCIGGqgz18=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0590;
x-ms-traffictypediagnostic: MWHPR04MB0590:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB05902B6227915C2077775489988E0@MWHPR04MB0590.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0590;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0590;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(346002)(39380400002)(377424004)(199004)(189003)(476003)(6506007)(14454004)(446003)(110136005)(316002)(102836004)(558084003)(186003)(3660700001)(99286004)(3280700002)(76176011)(118296001)(26005)(72206003)(5660300001)(36756003)(53936002)(7416002)(6246003)(8936002)(2900100001)(6436002)(6486002)(2501003)(229853002)(6512007)(68736007)(8676002)(6116002)(2906002)(3846002)(486006)(105586002)(106356001)(25786009)(305945005)(81166006)(81156014)(7736002)(2616005)(5250100002)(478600001)(66066001)(97736004)(11346002)(2201001)(86362001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0590;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: h0Jbu8nyFGadmB4DpLegCC40ubdABflTSgsJ/jFoPQav3DkAMogMsAtTRQmOuNC572BU8kZ45JVZs4Zl5b3Xbczhpof+oQHSuR3pUfZg4ZUiR4UQWFvPXQbKHdFFmQM7AKe8BHkI5PiwoNlFWfMLixZeJknxTu3K9lbvgeuPiEWI3DNxv7X3phmlcUXaFAs9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F63C1884A294C043B05A393659C45726@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d50d8084-5b98-42d9-1f48-08d5aba3379d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50d8084-5b98-42d9-1f48-08d5aba3379d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 18:26:24.2449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0590
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3QIRfaw023252

On Thu, 2018-04-26 at 11:19 -0700, Greg Thelen wrote:
> Allow INFINIBAND without INFINIBAND_ADDR_TRANS because fuzzing has been
> finding fair number of CM bugs.  So provide option to disable it.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
