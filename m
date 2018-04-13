Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeDMQFf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:05:35 -0400
Received: from mail-sn1nam02on0068.outbound.protection.outlook.com ([104.47.36.68]:46544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751335AbeDMQFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:05:32 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 02/10] PCI: cadence: Update cdns_pcie_ep_raise_irq function
 signature
Thread-Topic: [RFC 02/10] PCI: cadence: Update cdns_pcie_ep_raise_irq function
 signature
Thread-Index: AQHT0O90NeM9td2lmk6k/FEA2LR2iqP+3xKg
Date: Fri, 13 Apr 2018 16:05:31 +0000
Message-ID: <SN6PR07MB4512CAD75BB34CA72D10713AD8B30@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <52314006c63f8d21907dfaa03207b39e36bb8171.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <52314006c63f8d21907dfaa03207b39e36bb8171.1523379766.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03YzliMmY4ZC0zZjM0LTExZTgtODZlNS1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcN2M5YjJmOGUtM2YzNC0xMWU4LTg2ZTUtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIxMjE1IiB0PSIxMzE2ODEwOTEzMDY1ODIzNDYiIGg9IjFyTFkxNnp5U1dIWGp0MTFqUnh3NGtLOFl2OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4670;7:6RQl61tmLnIetsfTjOlGo9ui97aZoikdFt7Vvwmt8hbFG6/StRaOD4NkN5ax5i3G+vOYrjgw66/ignCfBdQ3LtNFu46wX1LN5mx5snVR6n9dM/UJiaaG2Cxtczjvk2gOwfDBCIqxZM+tmw/9wuF1ntJ8mei14LdGHC8oRfNytlugDu0SYBJimvMw0dhFxBTWwPGThOTDwOua6HvIHUoziGRD3ppqNx/Q85QOyQY2H1oecLhIDd/LT34fY8i4rRaO;20:0R64L/sPnNV6crbcBZyVuCw7j3redc1MHHf0sMZt9XrCzY4CHnDGcoN1aZOmwBrh+6yWuX2BGg6gbAZWAtM5o6XVenD4TjDXzcl6ZCG6Cbq4pmgVjZa9svhsvPkNm3ZGQTXIWsuKE3m0Lhcpn26piWh3JNnN5FRYIw1lHOHADB1E1EfPROPJ5sRToOlKCUle46uPkYMgLP1Ukpe+eCs4se4LPaLvjuBqyB1P02Aez93dN2cF4IwYsLr2HYCrvnjj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4670;
x-ms-traffictypediagnostic: SN6PR07MB4670:
x-microsoft-antispam-prvs: <SN6PR07MB4670D34E8813409782889EA6D8B30@SN6PR07MB4670.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4670;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4670;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39380400002)(39860400002)(346002)(366004)(396003)(376002)(36092001)(189003)(199004)(55016002)(59450400001)(68736007)(186003)(106356001)(3660700001)(105586002)(2906002)(6436002)(2900100001)(86362001)(26005)(6506007)(3280700002)(7696005)(102836004)(486006)(99286004)(476003)(11346002)(2201001)(97736004)(446003)(76176011)(39060400002)(7736002)(305945005)(14454004)(66066001)(229853002)(8676002)(3846002)(81156014)(5660300001)(6116002)(81166006)(9686003)(6246003)(74316002)(5250100002)(7416002)(2501003)(478600001)(54906003)(53936002)(8936002)(110136005)(316002)(25786009)(33656002)(4326008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4670;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2BtaOCWfgxLbSZZX+fkkB2XIqKyjS8g+cTQrvFYReqBSf02rHRTn+rbuEr4Bu4DKKWy8OwcHe0xaQWk05yowzxTe3jfwV5iTkgjukQ6pZ2jIahz0ED7CXqq+GK0S4FjdBu6Ne/QEn7kX5Tm25uPgsvyD+64Zj7OooZi0WKbv2+gH715RKGk5XxLKE0tLfkxlWf+QVEPw+/3cql4Pc4lcCg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c32220a8-bfad-49c6-8535-08d5a15861cb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32220a8-bfad-49c6-8535-08d5a15861cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 16:05:31.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4670
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3DG9Mr1012480

On Tue, Apr 10 at 18.15, Gustavo Pimentel wrote:
> From: Gustavo Pimentel [mailto:gustavo.pimentel@synopsys.com]
> Changes the cdns_pcie_ep_raise_irq function signature, namely the
> interrupt_num variable type from u8 to u16 to accommodate the MSI-X
> maximum interrupts of 2048.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c
> b/drivers/pci/cadence/pcie-cadence-ep.c
> index 3d8283e..6d6322c 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -363,7 +363,7 @@ static int cdns_pcie_ep_send_msi_irq(struct
> cdns_pcie_ep *ep, u8 fn,  }
> 
>  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
> -				  enum pci_epc_irq_type type, u8
> interrupt_num)
> +				  enum pci_epc_irq_type type, u16
> interrupt_num)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> 
> --
> 2.7.4
> 
Acked-by: Alan Douglas <adouglas@cadence.com>
