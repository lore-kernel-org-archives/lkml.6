Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbeEGG6B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:58:01 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com ([104.47.33.40]:52447
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750716AbeEGG6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:58:00 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
Subject: RE: NVMe Poll CQ on timeout
Thread-Topic: NVMe Poll CQ on timeout
Thread-Index: AdPdbaKnll1ikIRyRXyNIhFzf8HT4wIYrQ9g
Date: Mon, 7 May 2018 06:57:54 +0000
Message-ID: <BLUPR0201MB1505FC0425F87A1A8E6E50DAA59B0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
In-Reply-To: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0201MB1586;7:1x4a0LRfHh1GLbChb+1WNJE3XaaGLjwMpDfMVml5bSWf5yPNjh7KszM+f/AqAf9MZ1topc23xatTFSZpKSM1v2S8mbPqM+kALycQC2tLVrOKHkz6nPwLRrIWNMZz8jXpc2AbriKfAbcMrbT56P4YBbedFwFUL7SAdcu1QWVykeKzEO1SHYTIph/EiMUttCu5PvNNFf8LplUYSioCDR0bSerN30SdOb8HeuiLJgGEqdzxgwZIWQkj8bdUSgiRUi5L
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR0201MB1586;
x-ms-traffictypediagnostic: BLUPR0201MB1586:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BLUPR0201MB15869C38841E87665ED27E21A59B0@BLUPR0201MB1586.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150025)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BLUPR0201MB1586;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1586;
x-forefront-prvs: 066517B35B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(39380400002)(189003)(199004)(3846002)(316002)(6116002)(97736004)(25786009)(110136005)(54906003)(3660700001)(106356001)(486006)(3280700002)(2906002)(446003)(476003)(11346002)(66066001)(186003)(105586002)(478600001)(6506007)(55236004)(7696005)(76176011)(86362001)(6436002)(102836004)(26005)(99286004)(55016002)(8936002)(5660300001)(7736002)(9686003)(8676002)(81156014)(81166006)(53936002)(305945005)(4326008)(14454004)(5250100002)(2501003)(74316002)(2900100001)(6246003)(33656002)(68736007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1586;H:BLUPR0201MB1505.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: d4ZiIzCmpXXPV91e5ETuOaGsyE2FOQHEpuMJyJ0LmJ59V5w5KGlwEknwPkCDpdBG2BZHaAq+bU8D2duOeK0oWsloqNfJZPbKIdRRi6g6lC4cQ4uja+8duyoaQN3PF9GK6qeYg43rQ+bmRd37lSf0WdFxcHfqBEoA7VaJHYp0UxE6sWGcDvVUI5wDrZucEZ51
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f69d9673-c1f0-4d29-ff8a-08d5b3e7dbc2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69d9673-c1f0-4d29-ff8a-08d5b3e7dbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2018 06:57:54.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1586
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w476w74a001476

Hi,

Does anyone have any inputs ?

Regards,
Bharat

> Hi,
> 
> We are testing NVMe cards on ARM64 platform, the card uses legacy
> interrupts.
> Intermittently we are hitting following case in drivers/nvme/host/pci.c
>        /*
>          * Did we miss an interrupt?
>          */
>         if (__nvme_poll(nvmeq, req->tag)) {
>                 dev_warn(dev->ctrl.device,
>                          "I/O %d QID %d timeout, completion polled\n",
>                          req->tag, nvmeq->qid);
>                 return BLK_EH_HANDLED;
>         }
> 
> Can anyone tell when does nvme_timeout gets invoked ?
> What does "Did we miss an interrupt mean" ? Does it mean host missing to
> service a interrupt raised by EP card ?
> 
> Regards,
> Bharat
> 
