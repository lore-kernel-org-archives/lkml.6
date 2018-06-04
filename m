Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeFDPII (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:08:08 -0400
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:27456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751784AbeFDPIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:08:06 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/7] PCI: cadence: Update cdns_pcie_ep_raise_irq
 function signature
Thread-Topic: [PATCH v2 3/7] PCI: cadence: Update cdns_pcie_ep_raise_irq
 function signature
Thread-Index: AQHT7gHUWMmgp3Yy2UqjmD3C3fTJA6RJvoOAgAYk1wA=
Date: Mon, 4 Jun 2018 15:08:02 +0000
Message-ID: <SN6PR07MB4512F3B395D731FF14EBDB8ED8670@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <4994f263efbf6a2cb952d3d9839fb3b1737efde9.1526576613.git.gustavo.pimentel@synopsys.com>
 <aa86d9b7-d715-2a21-6a94-be927e55b51b@ti.com>
In-Reply-To: <aa86d9b7-d715-2a21-6a94-be927e55b51b@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xOGY5ZTJjNy02ODA5LTExZTgtODZlNi1hNDRjYzhlYzVlY2RcYW1lLXRlc3RcMThmOWUyYzgtNjgwOS0xMWU4LTg2ZTYtYTQ0Y2M4ZWM1ZWNkYm9keS50eHQiIHN6PSI3MzIiIHQ9IjEzMTcyNTk4NDkyODI0OTYzMCIgaD0ia0FwM0pOVnRneVVFdGdVcnpLYjgyZ1VVa25zPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4767;7:z4Oisq4dzOlMvSOgY0+v2/ah1+m5ro8sna6MZe1t9jKKaW305mMbqEyhrz47dXnSvWYZIc6gBzbJHFsYCr82VTZPb6siymC5oI01Uj/alfnG80InLU0rRyk10k/vq0yaTcx2NL5Wzza5jxCNl46idzuyuGc1i0k2GeZqLvnuodULlMKMMMLSilfaVdV4tzPltzZw0nKKrkSqV5QCNy7QlwZkwi5T1k9AYGwtsMRbL1TF4Zi/xP1eXP84vL+n+edt;20:49/JsYyA+Q5GKsoAKEHe3UsILJljE6Zt5E4/CQLN9BEDNmr+1QixXF5oU14EvwbSXHFcnI1aaUxBlNQJQLsoEB7XtC3bgCn5lYcDVOLS6aJwlLpVTDj8JMVY8PKzDYMxJHspI8lYWDAilAM+WTwPiyuuelxr22DB7wYzxo497nXQQr2K9sj613cgc+vsWtDEnWfVIiucnxS7nYNXjmRf434qkH7bKnZliJsSb7SY/9kpKVPusaSnclJCtsAtseZ1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4767;
x-ms-traffictypediagnostic: SN6PR07MB4767:
x-microsoft-antispam-prvs: <SN6PR07MB476727507F544F46B14D7EB0D8670@SN6PR07MB4767.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4767;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4767;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(39850400004)(376002)(346002)(36092001)(189003)(199004)(54906003)(4326008)(81156014)(81166006)(229853002)(2201001)(97736004)(25786009)(8936002)(478600001)(14454004)(2501003)(86362001)(7416002)(74316002)(5660300001)(105586002)(2906002)(53936002)(5250100002)(8676002)(53546011)(6506007)(76176011)(9686003)(26005)(486006)(2900100001)(68736007)(39060400002)(6116002)(3846002)(99286004)(305945005)(6436002)(7696005)(106356001)(33656002)(55016002)(446003)(11346002)(7736002)(476003)(110136005)(102836004)(316002)(3280700002)(186003)(66066001)(3660700001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4767;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Q6IHPC4XbUM/9L/gkiEbBn3DJcGzM4zibBjS2Go6Qy3kl/0lsFU1PYrC2Bw4LyQuDCevX6bOOnzEWNcWY2LvBeP1b9yYtAKPJYadr+zCPI2FGoZlbfYSsSGalFViQxeb+QFbJoivJqY6IWqZu/7+3ZuP20iI1LBAUoykZvI/5j+SGD/8LDiNaIxA4mTl3Z8iSwux2YfPSdDA2HC5GtVkiQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 780ab0d5-59a3-4093-3423-08d5ca2cf7f0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780ab0d5-59a3-4093-3423-08d5ca2cf7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 15:08:02.8941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4767
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54F8E3l023619

On 31 May 2018 11:51, Kishon Vijay Abraham I  wrote:
> Hi Alan,
> 
> On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
> > Change cdns_pcie_ep_raise_irq() signature, namely the interrupt_num
> > variable type from u8 to u16 to accommodate 2048 maximum MSI-X
> > interrupts.
> >
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Acked-by: Alan Douglas <adouglas@cadence.com>
> 
> Do you want to add MSI-X support to cadence PCIe?
> 
I do want to add MSI-X support, in fact I have done some tests with a
modified cadence driver with this set, so plan to submit a patch later.
