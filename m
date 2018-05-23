Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbeEWHfb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:35:31 -0400
Received: from mail-db5eur01on0081.outbound.protection.outlook.com ([104.47.2.81]:62892
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754304AbeEWHfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:35:30 -0400
From: Anson Huang <anson.huang@nxp.com>
To: Marc Zyngier <marc.zyngier@arm.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] irqchip: gpcv2: remove unnecessary functions
Thread-Topic: [PATCH] irqchip: gpcv2: remove unnecessary functions
Thread-Index: AQHT8l8Jic+BPQ1eOE6AUKndNnxu2aQ86PwAgAAAM7A=
Date: Wed, 23 May 2018 07:35:26 +0000
Message-ID: <AM3PR04MB1315B1C7C540A4E3054ACE9CF56B0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527056580-8791-1-git-send-email-Anson.Huang@nxp.com>
 <86fu2ibzu9.wl-marc.zyngier@arm.com>
In-Reply-To: <86fu2ibzu9.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB0774;7:Wy8IfzRM1JKAWTHx+jYPnZWf5nPjcDqLzqKSJDzBBg3kXe9i7zMP73za9diJEonAT8HlXk0tu4afodnHDdzDANj9Yk777h01HAsOcxe/4JqEneJhkTMGMLhnzc6p+Jg0h5B0kePNk5uAJjSxOg1gX9SP+sdsbHA7hgUxNTvVJlaL7O6skB3XPqnh35zwV9BgcM+xNTUjIdHrPnRhkISP5GCwxNYhZRscF2VdbxlYV9fwj7TYnB1IcevdzPMa6gO0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB0774;
x-ms-traffictypediagnostic: AM3PR04MB0774:
x-microsoft-antispam-prvs: <AM3PR04MB07742FBDB11B19339FE73F1FF56B0@AM3PR04MB0774.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB0774;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB0774;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(366004)(396003)(13464003)(199004)(189003)(3846002)(68736007)(8676002)(74316002)(11346002)(4326008)(476003)(486006)(9686003)(25786009)(7736002)(54906003)(305945005)(6436002)(446003)(229853002)(97736004)(8936002)(5250100002)(6246003)(316002)(81166006)(81156014)(55016002)(53936002)(2900100001)(478600001)(3280700002)(5660300001)(66066001)(26005)(3660700001)(33656002)(102836004)(14454004)(186003)(99286004)(53546011)(2906002)(44832011)(6916009)(106356001)(6506007)(59450400001)(76176011)(105586002)(6116002)(86362001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB0774;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: R4xzwLSr5kidwyCbL2eNmuyEnthewUqNlMfBEXE0vGxzsFl01TtDWExC/wIVIH/Y4/obK2H5Bq7TXBYE5thK+kew9CKa9PuVHP4e/RrlPlUF9TIks5kYkbwNg3NzmLVUc38pPr/n58RCJUV4qQ0bYZhtEaA04SDUrDUaXLoHKf3PKEyxlNnS6alPuVZJSfWU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ea7f8d04-c29e-4ac0-fe55-08d5c07fc046
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7f8d04-c29e-4ac0-fe55-08d5c07fc046
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 07:35:26.0709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4N7Zdwo007154

Hi, Marc

Anson Huang
Best Regards!


> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Wednesday, May 23, 2018 3:23 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: tglx@linutronix.de; jason@lakedaemon.net; dl-linux-imx
> <linux-imx@nxp.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] irqchip: gpcv2: remove unnecessary functions
> 
> On Wed, 23 May 2018 07:23:00 +0100,
> Anson Huang wrote:
> >
> > GPC is in always-on domain, it never lost its content during
> > suspend/resume, so no need to do save/restore for it during
> > suspend/resume.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/irqchip/irq-imx-gpcv2.c | 41
> > -----------------------------------------
> >  1 file changed, 41 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-imx-gpcv2.c
> > b/drivers/irqchip/irq-imx-gpcv2.c index 4760307..e6025d9 100644
> > --- a/drivers/irqchip/irq-imx-gpcv2.c
> > +++ b/drivers/irqchip/irq-imx-gpcv2.c
> > @@ -28,46 +28,6 @@ struct gpcv2_irqchip_data {
> >
> >  static struct gpcv2_irqchip_data *imx_gpcv2_instance;
> >
> > -static int gpcv2_wakeup_source_save(void) -{
> > -	struct gpcv2_irqchip_data *cd;
> > -	void __iomem *reg;
> > -	int i;
> > -
> > -	cd = imx_gpcv2_instance;
> > -	if (!cd)
> > -		return 0;
> > -
> > -	for (i = 0; i < IMR_NUM; i++) {
> > -		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
> > -		cd->saved_irq_mask[i] = readl_relaxed(reg);
> > -		writel_relaxed(cd->wakeup_sources[i], reg);
> > -	}
> 
> If you're removing that code, what's the purpose of keeping saved_irq_mask?
> 
> Also, who is now programming the wake-up_source? For good or bad reasons,
> this drivers uses the save/restore hooks to program the wake-up state.
> Removing this code seem to simply kill the feature.
> 
> What am I missing?
> 
> Thanks,

I made a mistake here, forgot to program the wakeup source into GPC IMR register
In imx_gpcv2_irq_set_wake function.
And I think we can remove the saved_irq_mask as well, will do it in V2.

The wake-up source is programmed by module driver calling "enable_irq_wake" if
device wakeup capability is enabled, and I miss to program into GPC IMR register. Will
fix it later. Thanks.

Anson.

> 
> 	M.
> 
> --
> Jazz is not dead, it just smell funny.
