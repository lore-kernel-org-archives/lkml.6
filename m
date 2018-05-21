Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751079AbeEUTgo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:36:44 -0400
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:19000
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750837AbeEUTgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:36:41 -0400
From: Liming Sun <lsun@mellanox.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 3/3] arm64: defconfig: Enable dw_mmc-bluefield driver
Thread-Topic: [PATCH v7 3/3] arm64: defconfig: Enable dw_mmc-bluefield driver
Thread-Index: AQHT5v2dGOFK8WM2ZkGAfh1/XsvNE6Q6IeaAgACDk6A=
Date: Mon, 21 May 2018 19:35:36 +0000
Message-ID: <AM2PR05MB0753E5385AB2C7672E4541B7A1950@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525805210-15246-1-git-send-email-lsun@mellanox.com>
 <1525805210-15246-3-git-send-email-lsun@mellanox.com>
 <CAPDyKFqBqTjjjFSkRBLKECmdn-b01hv51LOtqSSSTseWYL=Ykw@mail.gmail.com>
In-Reply-To: <CAPDyKFqBqTjjjFSkRBLKECmdn-b01hv51LOtqSSSTseWYL=Ykw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM2PR05MB1202;7:bLNB7+WA7sHZ4SVmXOtF6ua60lJ+xS1iAyGwlHCSMsqxyNhA8dFZGIBJgAMLAtClL0cs9XYkQ+Ac2kgeKCIFeEi3tOxvdy+GXhqOvZs17M6mhci/wpg9BVr7xAo4FpBwW7t/LtXblHIgCWX+aH6c+IfNZIRTsRWOEEWmlJtxF76HBplPk6D49dJDY3qwBZrDzkS4faP6ZXpwSFAI9P7pgFJ8tC8g0gGVcE9mlwwLqUMzHLYS1A8tM/DPdpCLoOBf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB1202;
x-ms-traffictypediagnostic: AM2PR05MB1202:
x-microsoft-antispam-prvs: <AM2PR05MB12021FD0FB2FBFE643A6FDEDA1950@AM2PR05MB1202.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM2PR05MB1202;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB1202;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(199004)(189003)(13464003)(446003)(105586002)(305945005)(33656002)(3846002)(186003)(76176011)(6246003)(11346002)(2900100001)(53936002)(6116002)(476003)(4326008)(7736002)(106356001)(102836004)(25786009)(6506007)(9686003)(8936002)(55016002)(229853002)(53546011)(26005)(2906002)(97736004)(14454004)(68736007)(478600001)(6916009)(66066001)(486006)(99286004)(316002)(7696005)(3280700002)(3660700001)(54906003)(81156014)(81166006)(6436002)(8676002)(5660300001)(74316002)(93886005)(5250100002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB1202;H:AM2PR05MB0753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: g5R0tZhQiweMUFGy+qM+23AoLpI9oI0yg8G1f0WCugSw147df/8HV2u0WFlwkdQA8Hv7edFKj+xCbPNXiR0RZNaMFRjzttyQVhH/P67iDT+kpQf/GbJyYqrWF1OM27t0qT0+SQ6Apvx8N0E7a7I7G5mcwp8A+nS8NOKtL6H63ZMAISaDA4PQ4TRLIJ150dQZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 68aa69ad-1a60-4044-33d7-08d5bf5206ce
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68aa69ad-1a60-4044-33d7-08d5bf5206ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 19:35:36.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB1202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LJaqxt031338

Thanks! I'll try to send this one to arm soc.

Best regards,
Liming

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Monday, May 21, 2018 7:36 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH v7 3/3] arm64: defconfig: Enable dw_mmc-bluefield
> driver
> 
> On 8 May 2018 at 20:46, Liming Sun <lsun@mellanox.com> wrote:
> > This patch updates arm64 defconfig to enable dw_mmc-bluefield,
> > which is a driver extension of Synopsys Designware MMC for the
> > Mellanox BlueField Soc.
> >
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> 
> I have applied the other parts in the series, but not this one as it's
> probably better it goes via arm soc.
> 
> I can take it, but then I need an ack from arm64 folkz...
> 
> Kind regards
> Uffe
> 
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index ecf6137..43464ab 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -487,6 +487,7 @@ CONFIG_MMC_DW=y
> >  CONFIG_MMC_DW_EXYNOS=y
> >  CONFIG_MMC_DW_K3=y
> >  CONFIG_MMC_DW_ROCKCHIP=y
> > +CONFIG_MMC_DW_BLUEFIELD=y
> >  CONFIG_MMC_SUNXI=y
> >  CONFIG_MMC_BCM2835=y
> >  CONFIG_MMC_SDHCI_XENON=y
> > --
> > 1.8.3.1
> >
