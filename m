Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757249AbeDZS05 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:26:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64457 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757274AbeDZS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:26:45 -0400
X-IronPort-AV: E=Sophos;i="5.49,331,1520870400";
   d="scan'208";a="179888225"
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
Subject: Re: [PATCH 3/6] ib_srpt: depend on INFINIBAND_ADDR_TRANS
Thread-Topic: [PATCH 3/6] ib_srpt: depend on INFINIBAND_ADDR_TRANS
Thread-Index: AQHT3YtDYFhRYV5N1Uy1C1S6LSrJKKQTXNuA
Date: Thu, 26 Apr 2018 18:25:38 +0000
Message-ID: <ca7d760cb8b04853e94e63fadc82303a3972b289.camel@wdc.com>
References: <20180426181935.32977-1-gthelen@google.com>
         <20180426181935.32977-4-gthelen@google.com>
In-Reply-To: <20180426181935.32977-4-gthelen@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0992;7:BjPp9PMgJkYXxRl2d8ySKqDGjGnMJzXQYBY+fj+JOSSj5LhN8FM1xVbCrHTHYm8SkXkozWcndIsA/fgWcUAqmst7PxsqrkJzmh2yYtVNDOTP2J6IhLzLt+U6GLItFVUwkwsOwz0xpGJzkUl7y2f1KBmsdhLrqou1446zypnjP4ppJCn3Hry8Uz7bvWyAUrRFzSD3x6TZp+IbYfkvKFzLBjYUeetOAwlsT0/t89PO3wEHGB+OYSky5PlZnOX2P7iO;20:QkujodrGS+iQ45WRZ4DjmuKNWhhjijchmhxv9V4c4yXEkPquQCDW4i6eJIPSXeqW/u613AAVb9z9D5SMG05D7FYaSZcvh51FFVK0K+tgcCDqotvJUd7eTvLCboKc2XzDsY54fuwOo3XQxgWceibGSpH1zL8+S3mE9+Nf2zrSd6E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0992;
x-ms-traffictypediagnostic: MWHPR04MB0992:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0992EFFC8605789E1C576540988E0@MWHPR04MB0992.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0992;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0992;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(377424004)(189003)(199004)(97736004)(229853002)(7416002)(53936002)(2201001)(118296001)(86362001)(2906002)(99286004)(186003)(6512007)(5660300001)(106356001)(3280700002)(478600001)(110136005)(105586002)(6116002)(6486002)(14454004)(8676002)(3660700001)(102836004)(305945005)(76176011)(66066001)(476003)(6246003)(81156014)(486006)(11346002)(72206003)(3846002)(26005)(8936002)(2900100001)(68736007)(5250100002)(316002)(25786009)(81166006)(446003)(558084003)(7736002)(2501003)(6506007)(36756003)(2616005)(6436002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0992;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ZiEzzP8QBFQDzxBOVVKrtX7y1TMzImFzCrWefjdEjAx90JaZEvN74PoeQaeUx2wqKDWQlqsFGGfGqHfQJB6Dquacie+9ngZlVjosjllKHqGRbUzeyJ023s6S2eV/x14XISRlhZ7FaJYbb4whrAJDblBzjdcvUrd3UE9WEO3NmOJ/TciCo5+1bYsCNk/pJKz1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1C4C38A053D8E41B9D26980B4884D8C@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e65b60c4-8fa8-4f96-b377-08d5aba31c80
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65b60c4-8fa8-4f96-b377-08d5aba31c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 18:25:38.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0992
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3QIR96I023236

On Thu, 2018-04-26 at 11:19 -0700, Greg Thelen wrote:
> INFINIBAND_SRPT code depends on INFINIBAND_ADDR_TRANS provided symbols.
> So declare the kconfig dependency.  This is necessary to allow for
> enabling INFINIBAND without INFINIBAND_ADDR_TRANS.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
