Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDXJ2j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:28:39 -0400
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:46080
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752789AbeDXJ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:28:36 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 00/10] Adds pcitest tool support for MSI-X
Thread-Topic: [RFC 00/10] Adds pcitest tool support for MSI-X
Thread-Index: AQHT0O90yDxqCBo79kmidlAQjKomXKQPjFiggAAkLICAAAnwIA==
Date: Tue, 24 Apr 2018 09:28:33 +0000
Message-ID: <SN6PR07MB4512656ED4FA817D3276665CD8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <SN6PR07MB45123840F0C9487F1CD119A9D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
 <767b50e3-8890-c241-bc97-1687bd0661c1@synopsys.com>
In-Reply-To: <767b50e3-8890-c241-bc97-1687bd0661c1@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kYzBkMWFjMi00N2ExLTExZTgtODZlNS1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcZGMwZDFhYzQtNDdhMS0xMWU4LTg2ZTUtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIzMzM3IiB0PSIxMzE2OTAzNTcxNTIxMzQxOTgiIGg9ImdyYTU5cFRaZ0dlRWJ0WFlHZWxvZ0kzcjI2dz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4654;7:xnuYudH8zSFE/BcwMc199KaQnUQCHDrg/URHB4YI5BRPVbLBn7ecVtead7R5pw8Ws1qsjJZznGgQemcnRH5pP9JXiYscmLkLEVUHfvVb268GMRFCBkCZOPWrVusVW600B+U8uB0p5vKf20wRvXO1/vOvezMYudglPxHT127xCQqzA2aiPpqVFeF1BjGvqW430MRc3/9kREp1ETln5oFVj1WvhGrfI842yCqFAesK74Ihx141A1u2zv2hBiix2QNr;20:+R7MiOc4/jCwerZZILSvJgw//POM2qROWZJM6Lu44ZrR4YPnPo+9toTdU7iKJDmBQ8NalXYNG4o3QOjUT5tK8gFeSJO6FCht7sPBeEmpHi2BmsBlT+fr/dSmMSSlIcqUQC3NGD8MKyy3zh8s6pufURTl88bVh1xZyqKTkFbRZm3MUgRD1KHcOZDSfGIvzGPNHOVMGvPu/CIUqjrfEr/NCrN0webX122KmGkTad4IXC+gGnndOfId675CWqqh6HtS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4654;
x-ms-traffictypediagnostic: SN6PR07MB4654:
x-microsoft-antispam-prvs: <SN6PR07MB4654D30692123E3CA38EC7E9D8880@SN6PR07MB4654.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231232)(944501410)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN6PR07MB4654;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4654;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(51444003)(36092001)(3280700002)(2501003)(102836004)(81156014)(59450400001)(6306002)(6506007)(6436002)(966005)(74316002)(53546011)(7416002)(26005)(55016002)(4326008)(316002)(99286004)(186003)(2906002)(5250100002)(6246003)(25786009)(14454004)(305945005)(33656002)(478600001)(7696005)(446003)(76176011)(106356001)(66066001)(68736007)(7736002)(2201001)(5660300001)(8676002)(9686003)(8936002)(105586002)(6116002)(229853002)(39060400002)(53936002)(2900100001)(81166006)(11346002)(3660700001)(476003)(110136005)(486006)(97736004)(54906003)(86362001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4654;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: LtmD+t/p6syTOU0BjhZFMbw6YOgF1fIkKpiYTiqaIduxNzM/LKMu9x2ZPPj8E0m6Xwwm2fmJhkGwbC2nF886PeayfTpmtbGoatUwPOVI7ldJrAb6AochZup/qJSPzDCCo9CrY3rIEpahr91AR/QdvkwnQfUKeHkUPBKkxVScncjnTQ9NlqG+KYkBWcewfLBW+Um9feD9+6bTxXFFivFj2A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 071df651-d61a-479f-7b0f-08d5a9c5bfeb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071df651-d61a-479f-7b0f-08d5a9c5bfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 09:28:33.5231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4654
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3O9SjVH020385

On 24 April 2018 09:50, Gustavo Pimentel wrote:
> Hi Alan,
> 
> On 24/04/2018 07:48, Alan Douglas wrote:
> > Hi Gustavo,
> >
> > On 10 April 2018 18:15 Gustavo Pimentel wrote:
> >>  https://lkml.org/lkml/2018/4/10/421
> >>  This series aims to add pcitest tool support for MSI-X.
> >> Includes new callbacks methods and handlers to trigger the MSI-X
> >> interruptions on the EP Designware IP driver.
> >>
> >> Provides new methods on pci_epf_test driver that allows to set/get EP
> >> maximum number of MSI-X entries (similar to set/get MSI methods).
> >>
> >> Reworks on MSI set/get and triggering methods on EP Designware IP
> >> driver to be more generic and flexible.
> >>
> >> Adds a new input parameter (msix) and replicates the whole MSI
> >> mechanism applied to the MSI-X feature on pcitest tool. Also updates
> >> the pcitest script with the new test set applied to this new feature.
> >>
> >> Gustavo Pimentel (10):
> >>   PCI: dwc: Add MSI-X callbacks handler
> >>   PCI: cadence: Update cdns_pcie_ep_raise_irq function signature
> >>   PCI: endpoint: Add MSI-X interfaces
> >>   PCI: dwc: MSI callbacks handler rework
> >>   PCI: dwc: Add legacy interrupt callback handler
> >>   misc: pci_endpoint_test: Add MSI-X support
> >>   misc: pci_endpoint_test: Replace lower into upper case characters
> >>   PCI: endpoint: functions/pci-epf-test: Add MSI-X support
> >>   PCI: endpoint: functions/pci-epf-test: Replace lower into upper case
> >>     characters
> >>   tools: PCI: Add MSI-X support
> >>
> >>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
> >>  drivers/misc/pci_endpoint_test.c                 | 120 ++++++++++----
> >>  drivers/pci/cadence/pcie-cadence-ep.c            |   2 +-
> >>  drivers/pci/dwc/pci-dra7xx.c                     |   2 +-
> >>  drivers/pci/dwc/pcie-artpec6.c                   |   2 +-
> >>  drivers/pci/dwc/pcie-designware-ep.c             | 201
> >> +++++++++++++++++++++--
> >>  drivers/pci/dwc/pcie-designware-plat.c           |   9 +-
> >>  drivers/pci/dwc/pcie-designware.h                |  40 +++--
> >>  drivers/pci/endpoint/functions/pci-epf-test.c    | 113 +++++++++----
> >>  drivers/pci/endpoint/pci-ep-cfs.c                |  24 +++
> >>  drivers/pci/endpoint/pci-epc-core.c              |  60 ++++++-
> >>  include/linux/pci-epc.h                          |  11 +-
> >>  include/linux/pci-epf.h                          |   1 +
> >>  include/uapi/linux/pcitest.h                     |   1 +
> >>  tools/pci/pcitest.c                              |  18 +-
> >>  tools/pci/pcitest.sh                             |  25 +++
> >>  16 files changed, 528 insertions(+), 104 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
> > Nice set of patches.  I have tested this with the Cadence EP driver after
> adding MSI-X support, and found a few changes required.
> > I will send you comments.
> 
> Ok, great news!
> 
> Maybe after this patch series submission we could start a new thread about
> new features that could be tested/verified using pcitest. I think this could be
> helpful for everybody.
> 
Great, I think that would definitely be of benefit.
> >
> > Thanks,
> > Alan
> >
> 
> Thanks,
> Gustavo
Thanks,
Alan
