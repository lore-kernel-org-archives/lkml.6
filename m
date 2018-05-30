Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeE3NtZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:49:25 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:29134 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753275AbeE3NtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:49:16 -0400
X-IronPort-AV: E=Sophos;i="5.49,460,1520866800";
   d="scan'208";a="282530693"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: M P <buserror@gmail.com>, Michel Pollet <michel.pollet@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        "Magnus Damm" <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
Thread-Topic: [PATCH v6 2/6] dt-bindings: Add the rzn1-clocks.h file
Thread-Index: AQHT8bSf7l9gIe2dJUyhEMYFJjQsPaQ8Fl+AgADJTwCAAAulAIAADmCAgAMz5wCACCJRAIAAAysAgAABoNA=
Date: Wed, 30 May 2018 13:49:09 +0000
Message-ID: <TY1PR01MB1769BE183DE5BC2CAC719663F56C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdW-HUBRF4rLdfzixcyMUBg7+4XU+-3zayePoyeQiBZ8ZA@mail.gmail.com>
 <CAMMfpEyTORirKiE417AQzCLzxDTKmy83bwivpfJaHQsKUKMc_w@mail.gmail.com>
 <CAMuHMdWAU9wZkA+Z0BNAGrLV1WrCO3PgCTo2p=q3Mq9Tm6JBGA@mail.gmail.com>
 <CAMMfpEwKa90XHu_igCxRQLy_CSVHTkN8eD8f7o=wgtttSn=FqA@mail.gmail.com>
 <CAMuHMdWVde-DfbLVbvZT4rQfsVz1z7AMyQVgbO2DXrQKsEdVcw@mail.gmail.com>
 <TY1PR01MB1769DFD4CD9803D10CE1CA4BF56C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdV8Hey=L6jv7HFyTUbeKdcC8ygn7PFjW2akETHe44MjeQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV8Hey=L6jv7HFyTUbeKdcC8ygn7PFjW2akETHe44MjeQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1593;7:GzwfGPXxcR9CaAw36ADn7jkgJ2qJJ0jBiA13iieS+5oGDcYe78uaJLf0LQ5kruehEHTzUAIi8OVIMhoP0W6P1FDevrQSvyfhFD9CbLLwPYlvjXyRQDh30AYFIkVgHVSBnbtmzbxmUR/T6EWL7t1MS8buAWACT6YkzhrhQ4EadgX3sTicx1XvHvzKCg7F9nKJMoCetCtirAn79CLm9I0efVNgjoDVomlaBzoypQKczU/q92Fro047S0zHAFj5GyxV;20:+GJPhAjdmECGrSblLEcrsd8LX4Z0WmszluZ6JQeqRqBSYF9kVOHCixiKICc6umGdAoEsneuwvqPbhsXCn082iPpG9o2RcvAYZSxnuE5lzvIicctJ4HBn/R7hP1YCIDQot5k/O7jB8MtKhDOY8SC5zlR7u9jkb7FIebDwjAamCzc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1593;
x-ms-traffictypediagnostic: TY1PR01MB1593:
x-microsoft-antispam-prvs: <TY1PR01MB1593575CECB33EBAAEF9AC36F56C0@TY1PR01MB1593.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB1593;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1593;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(14454004)(186003)(105586002)(53936002)(6506007)(9686003)(5660300001)(53546011)(7696005)(6916009)(6246003)(3846002)(106356001)(76176011)(102836004)(97736004)(446003)(8936002)(478600001)(39060400002)(4326008)(44832011)(6116002)(26005)(486006)(476003)(11346002)(86362001)(3660700001)(74316002)(305945005)(316002)(55016002)(93886005)(54906003)(3280700002)(81156014)(8676002)(81166006)(68736007)(2900100001)(25786009)(99286004)(5250100002)(2906002)(7736002)(229853002)(7416002)(6436002)(33656002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1593;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hOa3emCJmeUE4XR9MNdqySKRI+ikNY1eZ8WiWEOLO5dG4YYBzuHDmP5iI5+AtLI66ZeZGukqPs54sjFLT98Bf5zQJlrd+O+6uLYh7nA+lJfdWn/SXxV5L/PC3ApbGfGXPY25ivS34GZmgpxixbmyDFWGh+DkR73ytzMQ3QxZoDa75ESYtL6gpgpAaw0KDNeQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 22538b60-54a8-4f05-fb63-08d5c6341ebf
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22538b60-54a8-4f05-fb63-08d5c6341ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 13:49:09.7415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1593
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4UDne9B023532

Hi Geert,

On 30 May 2018 14:37 Geert Uytterhoeven wrote:
> On Wed, May 30, 2018 at 3:30 PM, Phil Edworthy wrote:
> > On 25 May 2018 10:13 Geert Uytterhoeven wrote:
> >  [snip]
> >
> >> Now, given the clock definitions for RZ/N1[DSL] are the same
> >> (although some don't exist on some variants), you could keep on using
> >> RZN1_CLK_FOO for the names of the defines, and store them in a
> common
> >> file, included by the soc-specific file. But please make clear the
> >> common file cannot be included directly, so the filename does not
> >> become part of the DT ABI, and you are shielded from future marketing
> >> silliness (e.g. next quarter's RZ/N1X being totally different).
> > How does an include filename become part of the DT ABI?
> > I thought the dtb is the ABI, not the dts. Am I wrong?
> 
> You're right. In se the DT ABI applies to the DTB, not to the DTS.
> 
> The definitions inside the include file are part of the DT bindings, and thus
> cannot be changed.  Your DTS files get these definitions by including the
> header file, so the header filename is also part of the bindings, and thus can't
> be changed that easily.
That seems a bit onerous... 
It makes sense that bindings that affect the dtb can only be added to, so that
an old dtb still works. However, I would have thought it's the value of the
constant that is the ABI, not the symbol name used to specify it.

Thanks for you feedback!
Phil
