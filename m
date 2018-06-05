Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeFESlc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:41:32 -0400
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:39104
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751786AbeFESla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:41:30 -0400
From: Anurag Kumar Vulisha <anuragku@xilinx.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Topic: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
Thread-Index: AQHT/OD63PyU9kIWfE6vMX/XM+YDdqRRyRYAgAAzNrA=
Date: Tue, 5 Jun 2018 18:41:26 +0000
Message-ID: <MWHPR02MB2816106466BD2AF8F7FB7BF8A7660@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1528212056-28390-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <20180605152524.GA23280@kroah.com>
In-Reply-To: <20180605152524.GA23280@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com;
x-originating-ip: [182.18.177.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2462;7:OzemsFLc4Q8s4gzc7xYMOmuOoK+Yof362tfTfXshWOAQBbi7xT2C46MP7CeSM+zztjHEuyaaITDuka8zC8z3hZwh1fKD5MSOZwVl4OIgMBvHf8o8ZErWaZ2XBzCinc+cbmvGuP+I7+C3k/yJqx6njEmX4dmLBvUtblhTIdENEtBneQeoUT4nj2PT26YHvYjiBhz70owjYDJlKNrD8zcpfjPw3ExhpZIMoGg8BpA1XsM/BCEvYn2yqF/R9kdfMXdi
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2462;
x-ms-traffictypediagnostic: MWHPR02MB2462:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB2462F4E2428220014FA51DFFA7660@MWHPR02MB2462.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192813158149592)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2462;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2462;
x-forefront-prvs: 0694C54398
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39840400004)(39380400002)(366004)(199004)(189003)(13464003)(5250100002)(25786009)(11346002)(105586002)(5660300001)(86362001)(186003)(478600001)(2900100001)(106356001)(68736007)(14454004)(3846002)(316002)(446003)(4326008)(6116002)(476003)(3280700002)(9686003)(486006)(66066001)(3660700001)(54906003)(6246003)(53936002)(102836004)(97736004)(55016002)(229853002)(2906002)(74316002)(7736002)(76176011)(8676002)(81166006)(33656002)(6506007)(8936002)(99286004)(81156014)(7696005)(6916009)(26005)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2462;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wjAD4gH3dXj9aQqT4kPzrn6uOP2HUwgF45yDxiz6u7MUalMuIQtiLOw+DGXoc41g3z/XzQK8c7rMkNGwWWiKj4vLQGHPh91XNT7ns7k2zTMToxPW+XZ4AlON2xrvaYRFlio2Etc20qlcZMZl1JYQzltNjNv8hDQEFc2CIiAbKih8LiPxn4aXQXEH6FBS5ZGI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 16416084-f3f0-4b46-4e82-08d5cb13f1c3
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16416084-f3f0-4b46-4e82-08d5cb13f1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 18:41:26.2781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2462
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55IfZKc000802

Hi Greg,

>-----Original Message-----
>From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
>Sent: Tuesday, June 05, 2018 8:55 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>
>Cc: Mathias Nyman <mathias.nyman@intel.com>; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] usb: host: xhci-plat: Iterate over parent nodes for finding quirks
>
>On Tue, Jun 05, 2018 at 08:50:56PM +0530, Anurag Kumar Vulisha wrote:
>> In xhci_plat_probe() both sysdev and pdev->dev are being used for
>> finding quirks. There are some drivers(like dwc3 host.c) which adds
>> quirks(like usb3-lpm-capable) into pdev and the logic present in
>> xhci_plat_probe() checks for quirks in either sysdev or pdev for
>> finding the quirks. Because of this logic, some of the quirks are
>> getting missed(usb3-lpm-capable quirk added by dwc3 host.c driver is
>> getting missed).This patch fixes this by iterating over all the
>> available parents for finding the quirks. In this way all the quirks
>> which are present in child or parent are correctly updated.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>
>So this is a bugfix?  If so, how far back in the kernel releases should it go to?
>
I feel this is as a bugfix. This problem started with this patch
"usb: xhci: use bus->sysdev for DMA configuration (4c39d4b949d36faf)"
where pdev->dev is replaced with sysdev. If I am not wrong this bug is
present since 4.12 kernel release.

Thanks,
Anurag kumar Vulisha

>thanks,
>
>greg k-h
