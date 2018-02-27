Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeB0NKn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:10:43 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:16192 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752867AbeB0NKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:10:41 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515423600";
   d="scan'208";a="272283174"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>
CC: Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>
Subject: RE: [PATCH 0/2] arm: Support for Renesas RZ/N1D (R9A06G032)
Thread-Topic: [PATCH 0/2] arm: Support for Renesas RZ/N1D (R9A06G032)
Thread-Index: AQHTrvxk7a3Lhb7hvUiYYFIpKimyqqO4N7gQ
Date: Tue, 27 Feb 2018 13:10:36 +0000
Message-ID: <HK2PR0601MB1393B2D7E0C96590482C3726F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR0601MB1427;7:N8omq6h9f9CMouOk0/8usBHZeWDGXyASc1ecD6YAm30F8uMM1Ni98l7jfSsFJB5FGReO6XBLKmfvnV8vXFwHJ1fUz2v8IRRBthrsqC1fAMuZVt/t3PG5i/kH/R9KDSntb7m1rfFhuJhxxq8QXlMohj65tQZJK9bGTCNlTPi25wHthhNW9UkiOLIT1dL9igSZkrM0Uvmpkfi19aSpO5iPHWLqBcEGEfbM5HTH3Kok+RvzXpv6cQ/NQx4I5LtQ0POc;20:RMM1x1OiEH5RtEhasqbqFDrcqDNUP1QeTP14zLvxEtzraQhqrS3K6vUVV63a4pLan5WIgluC0OsQcgzB+6zI7b0P8RTKR1gR9jluQXU1Fu/1tJA/xRN8/F59BbPev+TSduqEIZY6SBq/nidLcOUxKWUwOy2RXcRfdYEG+dyEtbE=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0a2cf22-c921-435a-ef3f-08d57de37e12
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:HK2PR0601MB1427;
x-ms-traffictypediagnostic: HK2PR0601MB1427:
x-microsoft-antispam-prvs: <HK2PR0601MB1427662F3CF8A4430BCF72ADF5C00@HK2PR0601MB1427.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HK2PR0601MB1427;BCL:0;PCL:0;RULEID:;SRVR:HK2PR0601MB1427;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(199004)(189003)(76176011)(55016002)(66066001)(2900100001)(316002)(5660300001)(7736002)(305945005)(229853002)(53936002)(6506007)(86362001)(74316002)(59450400001)(102836004)(9686003)(2501003)(26005)(186003)(14454004)(5250100002)(2950100002)(6436002)(8676002)(81166006)(6246003)(8936002)(478600001)(3846002)(81156014)(25786009)(7696005)(33656002)(2906002)(105586002)(3280700002)(107886003)(110136005)(68736007)(106356001)(97736004)(54906003)(3660700001)(99286004)(4326008)(39060400002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR0601MB1427;H:HK2PR0601MB1393.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Kixm1klYmbpb/ejl36U93zFq5OzZdmZNSSFwpHiAyAf/4sAi6bXKuiunSh2OeYU20i0/ai3EqBDniuaRMrq8UTsZSFnmc9ummGdXJOkG1j/xDJB8UXIMUm3/RrMRYmts+4nrCu468MhPVXa5l1AY3KMzhKS5MMHeb4YpgMkzDrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a2cf22-c921-435a-ef3f-08d57de37e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 13:10:36.6889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1427
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1RDAmp6025187

Hi Simon,

On 26 February 2018, Michel Pollet wrote:
> 
> This series adds the plain basic support for booting a bare
> kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
> minimum as a 'base', further patches that will add the
> rest of the support, pinctrl, clock architecture and quite
> a few others.
I spoke to Magnus about helping to get the RZ/N1 patches upstream.
We're trying to sort out making the device manual and board schematics
available, hopefully it won't take too long. We're also trying to sort out
access to a board... that might take a bit longer.

btw, what do you want to do about shmobile_defconfig? Should we add
any changes needed for RZ/N1 to it? Note that only one IP block is the
same as R-Car.

Thanks
Phil
