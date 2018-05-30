Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeE3Nag (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:30:36 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:40746 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753532AbeE3Na1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:30:27 -0400
X-IronPort-AV: E=Sophos;i="5.49,460,1520866800";
   d="scan'208";a="282529723"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, M P <buserror@gmail.com>
CC: Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
Thread-Topic: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
Thread-Index: AQHT8bSf7l9gIe2dJUyhEMYFJjQsPaQ8Fl+AgADJTwCAAAulAIAADmCAgAMz5wCACCJRAA==
Date: Wed, 30 May 2018 13:30:20 +0000
Message-ID: <TY1PR01MB1769DFD4CD9803D10CE1CA4BF56C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdW-HUBRF4rLdfzixcyMUBg7+4XU+-3zayePoyeQiBZ8ZA@mail.gmail.com>
 <CAMMfpEyTORirKiE417AQzCLzxDTKmy83bwivpfJaHQsKUKMc_w@mail.gmail.com>
 <CAMuHMdWAU9wZkA+Z0BNAGrLV1WrCO3PgCTo2p=q3Mq9Tm6JBGA@mail.gmail.com>
 <CAMMfpEwKa90XHu_igCxRQLy_CSVHTkN8eD8f7o=wgtttSn=FqA@mail.gmail.com>
 <CAMuHMdWVde-DfbLVbvZT4rQfsVz1z7AMyQVgbO2DXrQKsEdVcw@mail.gmail.com>
In-Reply-To: <CAMuHMdWVde-DfbLVbvZT4rQfsVz1z7AMyQVgbO2DXrQKsEdVcw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1038;7:2Yu1aJ+J0nAS1IAnkfkqNASk4YNWDzJ+6H9jOZFDYrLKemL6mfsQfsSQdiO/ieb59xjo3/ZWIJN4rP8YrBSnBp25zuSKgd57S02ErFcg3le4MvXlh3ANCEvWfbbCnjH6E1/ME/HJdKxbT4QwZ/E34Fw7ZGBYtZ/Fcc+cgip9hgaA3euWswnx+vSCdMwKxYhIz2I4mnHPV2fnaKqHMHdQFVAKoikO1xqClzDgfw37f+IPZfdCzeNC8T3MI9orZiql;20:MQbtddKtnnnvsyx7BWN+7YMADG6hjJvu2ekrwGvHhVTXIydDu4yI8YygF3wmXGX0cQXz3zTgwRKI/MjIYUqGVsUn9QS6hGssoXVa4NOwvVYbeTHVhSABfO/eULOxuRKkXbj6BOGIvksl1hzVDl07I1g8EmnGkcJkUMW1bfoo9yM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1038;
x-ms-traffictypediagnostic: TY1PR01MB1038:
x-microsoft-antispam-prvs: <TY1PR01MB1038CF6BDC31E371FC0D8F6DF56C0@TY1PR01MB1038.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1038;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1038;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(3846002)(3660700001)(5660300001)(14454004)(2906002)(316002)(4326008)(26005)(55016002)(33656002)(3280700002)(81166006)(9686003)(99286004)(86362001)(53936002)(97736004)(74316002)(305945005)(478600001)(93886005)(7736002)(229853002)(25786009)(66066001)(6436002)(446003)(6506007)(53546011)(486006)(76176011)(11346002)(7416002)(102836004)(44832011)(6246003)(186003)(8936002)(8676002)(68736007)(110136005)(39060400002)(2900100001)(7696005)(54906003)(476003)(6116002)(105586002)(106356001)(81156014)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1038;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: m9K/kYF15d4vNNlFF+yePFGcC4h524wrsPSnDnuO2oPq1i27ohJRsgQB+jMMIllQKEwwlS2PZ+Do8sk8lZvOznhAcf87SvDtM58laa0osoLMyasukqdxzB9qyACELC72tUiepL0vpWd3lbQLBNJAUfmc02bR+W9Yb+L6N2FAvg/647XQpGAqGlkufEWJPulI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6306361d-5643-498b-7a24-08d5c6317dfe
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6306361d-5643-498b-7a24-08d5c6317dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 13:30:20.9194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1038
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4UDVMsN020042

Hi Geert,

On 25 May 2018 10:13 Geert Uytterhoeven wrote:
 [snip]

> Now, given the clock definitions for RZ/N1[DSL] are the same (although some
> don't exist on some variants), you could keep on using RZN1_CLK_FOO for
> the names of the defines, and store them in a common file, included by the
> soc-specific file. But please make clear the common file cannot be included
> directly, so the filename does not become part of the DT ABI, and you are
> shielded from future marketing silliness (e.g. next quarter's RZ/N1X being
> totally different).
How does an include filename become part of the DT ABI?
I thought the dtb is the ABI, not the dts. Am I wrong?

Thanks
Phil
