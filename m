Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934297AbeCGWrR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:47:17 -0500
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:24478
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933533AbeCGWrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:47:15 -0500
From: Jolly Shah <JOLLYS@xilinx.com>
To: Rob Herring <robh@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
Thread-Topic: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
Thread-Index: AQHTsONzi5kT5xZmx0aJGWwSpBvQuKPCd+2AgALw7dA=
Date: Wed, 7 Mar 2018 22:47:08 +0000
Message-ID: <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com>
 <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
In-Reply-To: <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0201MB0782;7:yt218QlVbqaTHCCTgS1g0k/9BB4RVyfewUHdBVr2skOLURjUf0GIPhEInd48OXNN4e6hcvP0fdcjcxUmJq8YrXhVROjXce0wddS+UR9vG367loS0Avr33ybYpAv3vxlR63mVTT1Tj82x9CGJEi17y8HRxrxRWQiuhM9Z7s9s5NeFixUtn7PHNC98XWOlC6evUWfZ8Mn2gUCtw5ms83FgwgqkQ/UCzdjSFFA1N2H0QkfOS73aNvG9WlAxtaP7aupb
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(13464003)(199004)(189003)(102836004)(81156014)(74316002)(81166006)(3660700001)(68736007)(8676002)(26005)(105586002)(7696005)(8936002)(186003)(33656002)(14454004)(99286004)(7736002)(3846002)(76176011)(6116002)(106356001)(4326008)(59450400001)(5250100002)(2900100001)(86362001)(2906002)(25786009)(6246003)(53936002)(316002)(53546011)(54906003)(305945005)(6506007)(97736004)(3280700002)(478600001)(1720100001)(5660300001)(6916009)(229853002)(6436002)(55016002)(66066001)(966005)(72206003)(9686003)(6306002)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0201MB0782;H:DM2PR0201MB0767.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56f0ca87-90b6-4ae0-be05-08d5847d5bb4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR0201MB0782;
x-ms-traffictypediagnostic: DM2PR0201MB0782:
x-microsoft-antispam-prvs: <DM2PR0201MB0782FB462202AD9C818D9631B8D80@DM2PR0201MB0782.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR0201MB0782;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0201MB0782;
x-forefront-prvs: 0604AFA86B
x-microsoft-antispam-message-info: UwOZyCtXLHiCmVhifHLMpKzGvvIZWXgL0cKlvqmxaMvb0OL+ycm0jVXgZJdwBQ8AyFsfH0LamAGoMYAwL/XAiSb0ceJHI/mRNYwtMH4iL08UzHjfijmUzOcYS3/b8pSL/Hn1sEIyNMNp1CbRZHLoV6EQjLSTIWeS+R08c7/tMReztPj4f1yPVWExDOTpuzq1hyDx+0yvcDZ6j13S35xSUsdoXnDRNc50uH6T2OpnCpNz9IjtbL4wfC4vOnu8RtBawVDZdfEkCFWLA9GCNwr6mL2ssPKrIatxTlJV3QQqcEl/+q6Sdywf5+Rv+hcs32gZaF4VUUNGURffxsICwko3XA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f0ca87-90b6-4ae0-be05-08d5847d5bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 22:47:08.4174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0201MB0782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w27MlN3H006547

Hi Rob,


> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Monday, March 05, 2018 5:46 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: mturquette@baylibre.com; sboyd@codeaurora.org;
> michal.simek@xilinx.com; mark.rutland@arm.com; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; Shubhrajyoti Datta <shubhraj@xilinx.com>; linux-
> kernel@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
> driver
> 
> On Wed, Feb 28, 2018 at 02:27:40PM -0800, Jolly Shah wrote:
> > Add documentation to describe Xilinx ZynqMP clock driver bindings.
> >
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  | 163
> > +++++++++++++++++++++
> >  1 file changed, 163 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> > b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> > new file mode 100644
> > index 0000000..d590330
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
> > @@ -0,0 +1,163 @@
> > +Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC
> > +
> > +The Zynq Ultrascale+ MPSoC has several different clk providers, each
> > +with there own bindings.
> > +The purpose of this document is to document their usage.
> > +
> > +See clock_bindings.txt for more information on the generic clock bindings.
> > +
> > +== Clock Controller ==
> > +The clock controller is a logical abstraction of Zynq Ultrascale+
> > +MPSoC clock tree. It reads required input clock frequencies from the
> > +devicetree and acts as clock provider for all clock consumers of PS clocks.
> 
> Umm, the clock controller should correspond to a h/w block, not a "logical
> abstraction of the clock tree".
> 

Will correct description in next version.

> > +
> > +Required properties:
> > + - #clock-cells : Must be 1
> > + - compatible : "xlnx,zynqmp-clk"
> > + - clocks : list of clock specifiers which are external input clocks to the
> > +	    given clock controller. Please refer the next section to find
> > +	    the input clocks for a given controller.
> > + - clock-names : list of names of clocks which are exteral input clocks to the
> > +		 given clock controller. Please refer to the clock bindings
> > +		 for more details
> > +
> > +Input clocks for zynqmp Ultrascale+ clock controller:
> > +The Zynq UltraScale+ MPSoC has one primary and four alternative
> > +reference clock inputs.
> > +These required clock inputs are the
> > + - pss_ref_clk (PS reference clock)
> > + - video_clk (reference clock for video system )
> > + - pss_alt_ref_clk (alternative PS reference clock)
> > + - aux_ref_clk
> > + - gt_crx_ref_clk (transceiver reference clock)
> > +
> > +The following strings are optional parameters to the 'clock-names'
> > +property in order to provide an optional (E)MIO clock source.
> > + - swdt0_ext_clk
> > + - swdt1_ext_clk
> > + - gem0_emio_clk
> > + - gem1_emio_clk
> > + - gem2_emio_clk
> > + - gem3_emio_clk
> > + - mio_clk_XX		# with XX = 00..77
> > + - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
> > +
> > +
> > +Output clocks for zynqmp Ultrascale+ clock controller:
> > +Output clocks are registered based on clock information received from
> firmware.
> > +Output clock indexes are mentioned below:
> > +
> > +Clock ID:	Output clock name:
> > +-------------------------------------
> 
> These go in header definition, not here.

Sure. Will move them.

> 
> > +0		iopll
> > +1		rpll
> > +2		apll
> > +3		dpll
> > +4		vpll
> > +5		iopll_to_fpd
> > +6		rpll_to_fpd
> > +7		apll_to_lpd
> > +8		dpll_to_lpd
> > +9		vpll_to_lpd
> > +10		acpu
> > +11		acpu_half
> > +12		dbf_fpd
> > +13		dbf_lpd
> > +14		dbg_trace
> > +15		dbg_tstmp
> > +16		dp_video_ref
> > +17		dp_audio_ref
> > +18		dp_stc_ref
> > +19		gdma_ref
> > +20		dpdma_ref
> > +21		ddr_ref
> > +22		sata_ref
> > +23		pcie_ref
> > +24		gpu_ref
> > +25		gpu_pp0_ref
> > +26		gpu_pp1_ref
> > +27		topsw_main
> > +28		topsw_lsbus
> > +29		gtgref0_ref
> > +30		lpd_switch
> > +31		lpd_lsbus
> > +32		usb0_bus_ref
> > +33		usb1_bus_ref
> > +34		usb3_dual_ref
> > +35		usb0
> > +36		usb1
> > +37		cpu_r5
> > +38		cpu_r5_core
> > +39		csu_spb
> > +40		csu_pll
> > +41		pcap
> > +42		iou_switch
> > +43		gem_tsu_ref
> > +44		gem_tsu
> > +45		gem0_ref
> > +46		gem1_ref
> > +47		gem2_ref
> > +48		gem3_ref
> > +49		gem0_tx
> > +50		gem1_tx
> > +51		gem2_tx
> > +52		gem3_tx
> > +53		qspi_ref
> > +54		sdio0_ref
> > +55		sdio1_ref
> > +56		uart0_ref
> > +57		uart1_ref
> > +58		spi0_ref
> > +59		spi1_ref
> > +60		nand_ref
> > +61		i2c0_ref
> > +62		i2c1_ref
> > +63		can0_ref
> > +64		can1_ref
> > +65		can0
> > +66		can1
> > +67		dll_ref
> > +68		adma_ref
> > +69		timestamp_ref
> > +70		ams_ref
> > +71		pl0_ref
> > +72		pl1_ref
> > +73		pl2_ref
> > +74		pl3_ref
> > +75		wdt
> > +76		iopll_int
> > +77		iopll_pre_src
> > +78		iopll_half
> > +79		iopll_int_mux
> > +80		iopll_post_src
> > +81		rpll_int
> > +82		rpll_pre_src
> > +83		rpll_half
> > +84		rpll_int_mux
> > +85		rpll_post_src
> > +86		apll_int
> > +87		apll_pre_src
> > +88		apll_half
> > +89		apll_int_mux
> > +90		apll_post_src
> > +91		dpll_int
> > +92		dpll_pre_src
> > +93		dpll_half
> > +94		dpll_int_mux
> > +95		dpll_post_src
> > +96		vpll_int
> > +97		vpll_pre_src
> > +98		vpll_half
> > +99		vpll_int_mux
> > +100		vpll_post_src
> > +101		can0_mio
> > +102		can1_mio
> > +
> > +Example:
> > +
> > +clk: clk {
> > +	#clock-cells = <1>;
> > +	compatible = "xlnx,zynqmp-clk";
> 
> How do you control the clocks?

Clocks are controlled by a dedicated platform management controller. Above clock ids are used to identify clocks between master and PMU.

> 
> > +	clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>,
> <&aux_ref_clk>, <&gt_crx_ref_clk>;
> > +	clock-names = "pss_ref_clk", "video_clk",
> "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk"
> > +};
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
