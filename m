Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934436AbeCGWzR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:55:17 -0500
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com ([104.47.36.50]:4524
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933533AbeCGWzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:55:14 -0500
From: Jolly Shah <JOLLYS@xilinx.com>
To: Rob Herring <robh@kernel.org>
CC: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: soc: Add ZynqMP PM bindings
Thread-Topic: [PATCH 1/2] dt-bindings: soc: Add ZynqMP PM bindings
Thread-Index: AQHTsCI8L23j8papPEG0/vWJfytizaPCQ7EAgAMqP6A=
Date: Wed, 7 Mar 2018 22:55:09 +0000
Message-ID: <DM2PR0201MB0767A880059E70642B3EB431B8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519773866-18196-1-git-send-email-jollys@xilinx.com>
 <1519773866-18196-2-git-send-email-jollys@xilinx.com>
 <20180305223328.la462hdwwsymvusk@rob-hp-laptop>
In-Reply-To: <20180305223328.la462hdwwsymvusk@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0847;6:LLtpCDVvXPz1sVW2BYHbdEdtH9laLcnUy5bz8zOHVLf0kKCfQOHoyPHtMLZPX7BSsd88hsrFOSA4VBmZTef8M96KoOIW2f5WbxCIYEOfCwTCpwB99smyYFi6XmcGUOUuq7R0WDRJEeiagQ6aG4v/6ikAeNWOMqrrgfsyKNmk1514wE/nPjf/ycWpwaDKnCAvZiQBis6M3A0tte+sD6HOWFCls1pNu7Bj638paVxaHV27PrGuOVENvlQ4apvR/BkhRSQWtFWQMMyCg3lHH+MJLZzepc5U4lHcTxrSub0uDJLkTyTbV1u1OJ/CWNJ7n0U0V7yD4Y7twnF8udxjDUO8klnp73GZUMeunN0BIA24F03YsfTfLvG56rHqxOCmWG/O;5:1L57kzo6fqGi4Dyq4UZaHYW1o3KviukBUZbuchpV0F9wxBC97g7+XbjuoUS1OLR4f7y+kedeElJ8NxSu7bvMm6/iNe3zjOOi32mjsfqzRKmAM3bUYD+XCOvXp73kiDm8MPzFDIU1PmJsbNj+8m3bd6cLx01IImj75O/4Pl6spX4=;24:81z3jTzI+t8bwI7oDWcVI9XsiHQC5XK4ehLyVeCRWgvTffGKyif42WMC84LXav4Mpdc1dWbOG71mcd+JDBY6L54RNPlRxjRMuh9wnD2eg/k=;7:nl7IibzKkPuknNaHX6cw4icRSm12thyM5LCAY4YrOU47ojXq+3tSZNLNurdA5sFlGjM74iGxLm/3BsWGprG5ebr5usZ5/+7UP0zpvMAxqITtmATbstEjs+Ca+L5817GaUjLkzXmMEExcnCT7r9ptuoI2/7SVlSDixar6Xt87ev0VjLJ+Sib0ONb2+jfYuFpu8eHWEUp7sU1xyxpvzyhqurJVBV0D4EDNzer3JGVILgA/gCzQ5HvKpXAeVKOvn9EO
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(39380400002)(39860400002)(396003)(346002)(199004)(189003)(51914003)(13464003)(7696005)(76176011)(2900100001)(106356001)(8936002)(8676002)(97736004)(39060400002)(81166006)(81156014)(5250100002)(74316002)(6916009)(7736002)(305945005)(68736007)(53546011)(6436002)(14454004)(2950100002)(478600001)(33656002)(102836004)(6116002)(3660700001)(7416002)(5660300001)(72206003)(99286004)(54906003)(316002)(53936002)(26005)(25786009)(4326008)(186003)(3280700002)(3846002)(9686003)(2906002)(66066001)(86362001)(6506007)(6246003)(59450400001)(229853002)(55016002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0847;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec46c170-5d18-4dbd-f71c-08d5847e7a84
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0847;
x-ms-traffictypediagnostic: DM2PR0201MB0847:
x-microsoft-antispam-prvs: <DM2PR0201MB0847D811F9840EFF7E01610DB8D80@DM2PR0201MB0847.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR0201MB0847;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0847;
x-forefront-prvs: 0604AFA86B
x-microsoft-antispam-message-info: HrxGbG3qFh1zEvh6aRzFhsj/RMjkHLL/HAx0ZBCByKSn8CeCTZ2J/7sIAiDaYFrU14qg/VeJHhN+CT7PCVAaZ3KPHqOEUR8lacYorQhb+FTXvcS5qSKjOMD04lKmx/z+TY5rcQLb6ro6PxLsYkuYSP/iXLFL3AWx8aYct0YLJtDR3SQgF2/1XJg6sC6QlS9br9xWrkwPYqq8XJY5/WeSd1ZtgzpHwvsJkySOyegWZ1p/fWfdkCU4hvyyvbc0ulV94ZOJrz1e01i4WpyV2O6gX4Si2pPHDOq3/UJ7DXooXoVMppD5hvhlAcCQfY42lob2sbmiA6brcyeecBe3zxNIzw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec46c170-5d18-4dbd-f71c-08d5847e7a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 22:55:09.7042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0847
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w27MtMtG007689

Hi Rob,

Thanks for the review,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Monday, March 05, 2018 2:33 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com;
> michal.simek@xilinx.com; mark.rutland@arm.com; Rajan Vaja
> <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: Re: [PATCH 1/2] dt-bindings: soc: Add ZynqMP PM bindings
> 
> On Tue, Feb 27, 2018 at 03:24:25PM -0800, Jolly Shah wrote:
> > Add documentation to describe Xilinx ZynqMP power management bindings.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > ---
> >  .../bindings/soc/xilinx/xlnx,zynqmp-power.txt      | 28
> ++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
> > b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.txt
> > new file mode 100644
> > index 0000000..5b7d963
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-power.t
> > +++ xt
> > @@ -0,0 +1,28 @@
> > +Xilinx Zynq MPSoC Power Management Device Tree Bindings
> > +
> > +The zynqmp-power node describes the power management configurations.
> 
> That really tells me nothing. What aspect of power management does this
> interface control?
> 

It controls remote suspend/shutdown interfaces. Will add details in next version.

> > +
> > +Required properties:
> > + - compatible	: Must contain:  "xlnx,zynqmp-power"
> > + - mbox-names	: Name given to channels seen in the 'mboxes' property.
> > +		  "rx" - Mailbox corresponding to receive path
> > +		  "tx" - Mailbox corresponding to transmit path
> > + - mboxes	: Standard property to specify a Mailbox. Each value of
> > +		  the mboxes property should contain a phandle to the
> > +		  mailbox controller device node and an args specifier
> > +		  that will be the phandle to the intended sub-mailbox
> > +		  child node to be used for communication. See
> > +		  Documentation/devicetree/bindings/mailbox/mailbox.txt
> > +		  for more details about the generic mailbox controller
> > +		  and client driver bindings. Also see
> > +		  Documentation/devicetree/bindings/mailbox/ \
> > +		  xlnx,zynqmp-ipi-mailbox.txt for typical controller that
> > +		  is used to communicate with this System controllers.
> 
> No need to define a standard property here. Just need to say how many entries
> and refer to the common binding.
> 

Ok. Will update same in next version.

> > +
> > +Examples:
> > +	zynqmp_power: zynqmp-power {
> > +		compatible = "xlnx,zynqmp-power";
> > +		mboxes = <&ipi_mailbox_pmu0 0>,
> > +			 <&ipi_mailbox_pmu0 1>;
> > +		mbox-names = "tx", "rx";
> > +	};
> > --
> > 2.7.4
> >
