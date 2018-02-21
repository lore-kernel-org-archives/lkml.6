Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965465AbeBUPA5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:00:57 -0500
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:14270
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938156AbeBUPAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:00:53 -0500
From: Manish Narani <MNARANI@xilinx.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
Thread-Topic: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
Thread-Index: AQHTmfZbHcgatUAMk0Kw/6gGGMV5dKOnKs4AgAdTQuCAAI+lgA==
Date: Wed, 21 Feb 2018 15:00:48 +0000
Message-ID: <SN1PR0201MB1791863A71475E3F0D896DD0C1CE0@SN1PR0201MB1791.namprd02.prod.outlook.com>
References: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
 <608309c3-fc4d-25a2-f0a9-21c0f3e2db46@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR0201MB1488;7:oCZcPqPeFmTP+oXdV+QjvTo16mGLHZSc2OVET6or0oMgAxnStFtd9lqsc/J+so+Yw0gf8tXpcPWlXVjeGQy4iuFneBeJhV7K0jnhwHaHhmma14KPHyV6K491qFohTxNSdi6EKKB9OE/9KNlrC9jm64Vv5OdlGcGC9rBOM69MP6UWZ+y+ZYeeKZbrVcULvkB3GIaKOd+Gy1oU9096Xh2AeLTWcR2R/Uc7JKRjHX7TAtdZkH77arhl6UtiFGrvONOw
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 222994b1-b380-4596-5f59-08d5793be44d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:SN1PR0201MB1488;
x-ms-traffictypediagnostic: SN1PR0201MB1488:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN1PR0201MB14881D2113D6DBD6798D2531C1CE0@SN1PR0201MB1488.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(228905959029699)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001068)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR0201MB1488;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1488;
x-forefront-prvs: 0590BBCCBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(396003)(346002)(39860400002)(13464003)(199004)(189003)(2906002)(2501003)(81166006)(5250100002)(81156014)(5890100001)(8676002)(3280700002)(2201001)(86362001)(4326008)(97736004)(8936002)(68736007)(25786009)(3846002)(6116002)(33656002)(14454004)(106356001)(105586002)(3660700001)(478600001)(72206003)(305945005)(53936002)(2900100001)(53946003)(53546011)(229853002)(59450400001)(102836004)(55236004)(6506007)(186003)(107886003)(26005)(74316002)(6436002)(99286004)(6246003)(316002)(76176011)(55016002)(7696005)(9686003)(54906003)(110136005)(5660300001)(66066001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1488;H:SN1PR0201MB1791.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: RTfUFAau6CCHxDAPny5qv6laMDngyA7ouElb2aiDamElRhz//OJVeEiy8SsC3FpjWrFNvPXTtv4NSaUMX6Bs3aschcOdiPXqbUPhxE6O9qxkE93sYuCqs4ae/eAR7JpF1w3SVyyuEjXbCqwQkTFOdGLQumLuzJMNxVlEpP7NZQU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222994b1-b380-4596-5f59-08d5793be44d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2018 15:00:48.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1488
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1LF1Ehl014254

Hi Adrian,

> -----Original Message-----
> From: Manish Narani
> Sent: Wednesday, February 21, 2018 11:39 AM
> To: Adrian Hunter <adrian.hunter@intel.com>; michal.simek@xilinx.com;
> ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org
> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> <sgoud@xilinx.com>
> Subject: RE: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
> ZynqMP Platform
> 
> Hi Adrian,
> 
> 
> > -----Original Message-----
> > From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> > Sent: Friday, February 16, 2018 7:37 PM
> > To: Manish Narani <MNARANI@xilinx.com>; michal.simek@xilinx.com;
> > ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
> > mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org
> > Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> > <sgoud@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
> > Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support
> > for ZynqMP Platform
> >
> > On 30/01/18 20:14, Manish Narani wrote:
> > > This patch adds support of SD auto tuning for ZynqMP platform. Auto
> > > tuning sequence sends tuning block to card when operating in UHS-1
> > > modes. This resets the DLL and sends CMD19/CMD21 as a part of the
> > > auto tuning process. Once the auto tuning process gets completed,
> > > reset the DLL to load the newly obtained SDHC tuned tap value.
> >
> > How is this different from:
> > 	1. reset the dll
> > 	2. call sdhci_execute_tuning
> > 	3. reset the dll
> >
Below is my take on your above comments:
- 'Reset the dll' is a platform specific call inside 'arasan_zynqmp_execute_tuning' which is implemented in sdhci-of-arasan.c 
- 'arasan_zynqmp_execute_tuning' is called from 'sdhci_execute_tuning' as a platform_execute_tuning routine
- So to keep 'DLL reset' routine called from sdhci-of-arasan.c, I have implemented the execute_tuning in sdhci-of-arasan.c

Alternative way (Please review):
- Define a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) in sdhci-of-arasan.c indicating DLL reset needed while tuning operation
- Call 'dll reset' routine before and after __sdhci_execute_tuning() in sdhci.c when a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) is set

Thanks,
Manish

> Thanks for your comments. I am looking into this. I will check and let you
> know on the same.
> 
> Thanks,
> - Manish
> 
> > >
> > > Signed-off-by: Manish Narani <mnarani@xilinx.com>
> > > ---
> > >  .../devicetree/bindings/mmc/arasan,sdhci.txt       |   1 +
> > >  drivers/mmc/host/sdhci-of-arasan.c                 | 219
> > ++++++++++++++++++++-
> > >  2 files changed, 219 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > index 60481bf..7d29751 100644
> > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > @@ -14,6 +14,7 @@ Required Properties:
> > >      - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
> > >      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
> > >      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC
> > > PHY
> > > +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP 8.9a PHY
> > >        For this device it is strongly suggested to include arasan,soc-ctl-
> syscon.
> > >    - reg: From mmc bindings: Register location and length.
> > >    - clocks: From clock bindings: Handles to clock inputs.
> > > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > > b/drivers/mmc/host/sdhci-of-arasan.c
> > > index 0720ea7..7673db4 100644
> > > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > > @@ -24,15 +24,18 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/phy/phy.h>
> > > +#include <linux/mmc/mmc.h>
> > >  #include <linux/regmap.h>
> > >  #include "sdhci-pltfm.h"
> > >  #include <linux/of.h>
> > > +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> > >
> > >  #define SDHCI_ARASAN_VENDOR_REGISTER   0x78
> > >
> > >  #define VENDOR_ENHANCED_STROBE         BIT(0)
> > >
> > >  #define PHY_CLK_TOO_SLOW_HZ            400000
> > > +#define MAX_TUNING_LOOP                        40
> > >
> > >  /*
> > >   * On some SoCs the syscon area has a feature where the upper
> > > 16-bits of @@ -88,6 +91,7 @@ struct sdhci_arasan_data {
> > >         struct sdhci_host *host;
> > >         struct clk      *clk_ahb;
> > >         struct phy      *phy;
> > > +       u32             device_id;
> > >         bool            is_phy_on;
> > >
> > >         struct clk_hw   sdcardclk_hw;
> > > @@ -157,6 +161,213 @@ static int sdhci_arasan_syscon_write(struct
> > sdhci_host *host,
> > >         return ret;
> > >  }
> > >
> > > +/**
> > > + * arasan_zynqmp_dll_reset - Issue the DLL reset.
> > > + * @deviceid:          Unique Id of device
> > > + */
> > > +void zynqmp_dll_reset(u8 deviceid)
> > > +{
> > > +       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> > > +
> > > +       if (!eemi_ops || !eemi_ops->ioctl)
> > > +               return;
> > > +
> > > +       /* Issue DLL Reset */
> > > +       if (deviceid == 0)
> > > +               eemi_ops->ioctl(NODE_SD_0, IOCTL_SD_DLL_RESET,
> > > +                               PM_DLL_RESET_PULSE, 0, NULL);
> > > +       else
> > > +               eemi_ops->ioctl(NODE_SD_1, IOCTL_SD_DLL_RESET,
> > > +                               PM_DLL_RESET_PULSE, 0, NULL); }
> > > +
> > > +static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u8
> > > +deviceid) {
> > > +       u16 clk;
> > > +       unsigned long timeout;
> > > +
> > > +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > +       clk &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
> > > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > +
> > > +       /* Issue DLL Reset */
> > > +       zynqmp_dll_reset(deviceid);
> > > +
> > > +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > +       clk |= SDHCI_CLOCK_INT_EN;
> > > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > +
> > > +       /* Wait max 20 ms */
> > > +       timeout = 20;
> > > +       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> > > +                               & SDHCI_CLOCK_INT_STABLE)) {
> > > +               if (timeout == 0) {
> > > +                       dev_err(mmc_dev(host->mmc),
> > > +                               ": Internal clock never stabilised.\n");
> > > +                       return;
> > > +               }
> > > +               timeout--;
> > > +               mdelay(1);
> > > +       }
> > > +
> > > +       clk |= SDHCI_CLOCK_CARD_EN;
> > > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL); }
> > > +
> > > +static int arasan_zynqmp_execute_tuning(struct sdhci_host *host,
> > > +u32
> > > +opcode) {
> > > +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > +       struct sdhci_arasan_data *sdhci_arasan =
> > sdhci_pltfm_priv(pltfm_host);
> > > +       struct mmc_host *mmc = host->mmc;
> > > +       u16 ctrl;
> > > +       int tuning_loop_counter = MAX_TUNING_LOOP;
> > > +       int err = 0;
> > > +       unsigned long flags;
> > > +       unsigned int tuning_count = 0;
> > > +
> > > +       spin_lock_irqsave(&host->lock, flags);
> > > +
> > > +       if (host->tuning_mode == SDHCI_TUNING_MODE_1)
> > > +               tuning_count = host->tuning_count;
> > > +
> > > +       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +       ctrl |= SDHCI_CTRL_EXEC_TUNING;
> > > +       if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
> > > +               ctrl |= SDHCI_CTRL_TUNED_CLK;
> > > +       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > > +
> > > +       mdelay(1);
> > > +
> > > +       arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
> > > +
> > > +       /*
> > > +        * As per the Host Controller spec v3.00, tuning command
> > > +        * generates Buffer Read Ready interrupt, so enable that.
> > > +        *
> > > +        * Note: The spec clearly says that when tuning sequence
> > > +        * is being performed, the controller does not generate
> > > +        * interrupts other than Buffer Read Ready interrupt. But
> > > +        * to make sure we don't hit a controller bug, we _only_
> > > +        * enable Buffer Read Ready interrupt here.
> > > +        */
> > > +       sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
> > > +       sdhci_writel(host, SDHCI_INT_DATA_AVAIL,
> > > + SDHCI_SIGNAL_ENABLE);
> > > +
> > > +       /*
> > > +        * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the
> number
> > > +        * of loops reaches 40 times or a timeout of 150ms occurs.
> > > +        */
> > > +       do {
> > > +               struct mmc_command cmd = {0};
> > > +               struct mmc_request mrq = {NULL};
> > > +
> > > +               cmd.opcode = opcode;
> > > +               cmd.arg = 0;
> > > +               cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> > > +               cmd.retries = 0;
> > > +               cmd.data = NULL;
> > > +               cmd.mrq = &mrq;
> > > +               cmd.error = 0;
> > > +
> > > +               if (tuning_loop_counter-- == 0)
> > > +                       break;
> > > +
> > > +               mrq.cmd = &cmd;
> > > +
> > > +               /*
> > > +                * In response to CMD19, the card sends 64 bytes of tuning
> > > +                * block to the Host Controller. So we set the block size
> > > +                * to 64 here.
> > > +                */
> > > +               if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
> > > +                       if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> > > +                               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
> > > +                                            SDHCI_BLOCK_SIZE);
> > > +                       } else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
> > > +                               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> > > +                                            SDHCI_BLOCK_SIZE);
> > > +                       }
> > > +               } else {
> > > +                       sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> > > +                                    SDHCI_BLOCK_SIZE);
> > > +               }
> > > +
> > > +               /*
> > > +                * The tuning block is sent by the card to the host controller.
> > > +                * So we set the TRNS_READ bit in the Transfer Mode register.
> > > +                * This also takes care of setting DMA Enable and Multi Block
> > > +                * Select in the same register to 0.
> > > +                */
> > > +               sdhci_writew(host, SDHCI_TRNS_READ,
> > > + SDHCI_TRANSFER_MODE);
> > > +
> > > +               sdhci_send_command(host, &cmd);
> > > +
> > > +               host->cmd = NULL;
> > > +
> > > +               spin_unlock_irqrestore(&host->lock, flags);
> > > +               /* Wait for Buffer Read Ready interrupt */
> > > +               wait_event_interruptible_timeout(host->buf_ready_int,
> > > +                                       (host->tuning_done == 1),
> > > +                                       msecs_to_jiffies(50));
> > > +               spin_lock_irqsave(&host->lock, flags);
> > > +
> > > +               if (!host->tuning_done) {
> > > +                       dev_warn(mmc_dev(host->mmc),
> > > +                                ": Timeout for Buffer Read Ready
> > > + interrupt, back to fixed
> > sampling clock\n");
> > > +                       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +                       ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> > > +                       ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
> > > +                       sdhci_writew(host, ctrl,
> > > + SDHCI_HOST_CONTROL2);
> > > +
> > > +                       err = -EIO;
> > > +                       goto out;
> > > +               }
> > > +
> > > +               host->tuning_done = 0;
> > > +
> > > +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +
> > > +               /* eMMC spec does not require a delay between tuning cycles
> */
> > > +               if (opcode == MMC_SEND_TUNING_BLOCK)
> > > +                       mdelay(1);
> > > +       } while (ctrl & SDHCI_CTRL_EXEC_TUNING);
> > > +
> > > +       /*
> > > +        * The Host Driver has exhausted the maximum number of loops
> > allowed,
> > > +        * so use fixed sampling frequency.
> > > +        */
> > > +       if (tuning_loop_counter < 0) {
> > > +               ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> > > +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > > +       }
> > > +       if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
> > > +               dev_warn(mmc_dev(host->mmc),
> > > +                        ": Tuning failed, back to fixed sampling clock\n");
> > > +               err = -EIO;
> > > +       } else {
> > > +               arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
> > > +       }
> > > +
> > > +out:
> > > +       /*
> > > +        * In case tuning fails, host controllers which support
> > > +        * re-tuning can try tuning again at a later time, when the
> > > +        * re-tuning timer expires.  So for these controllers, we
> > > +        * return 0. Since there might be other controllers who do not
> > > +        * have this capability, we return error for them.
> > > +        */
> > > +       if (tuning_count)
> > > +               err = 0;
> > > +
> > > +       host->mmc->retune_period = err ? 0 : tuning_count;
> > > +
> > > +       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > > +       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > > +       spin_unlock_irqrestore(&host->lock, flags);
> > > +
> > > +       return err;
> > > +}
> > > +
> > >  static void sdhci_arasan_set_clock(struct sdhci_host *host,
> > > unsigned int clock)  {
> > >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host); @@
> > > -262,7 +473,7 @@ static int sdhci_arasan_voltage_switch(struct
> > > mmc_host
> > *mmc,
> > >         return -EINVAL;
> > >  }
> > >
> > > -static const struct sdhci_ops sdhci_arasan_ops = {
> > > +static struct sdhci_ops sdhci_arasan_ops = {
> > >         .set_clock = sdhci_arasan_set_clock,
> > >         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > >         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock, @@
> > > -371,6
> > > +582,7 @@ static const struct of_device_id sdhci_arasan_of_match[] =
> > > +{
> > >         { .compatible = "arasan,sdhci-8.9a" },
> > >         { .compatible = "arasan,sdhci-5.1" },
> > >         { .compatible = "arasan,sdhci-4.9a" },
> > > +       { .compatible = "xlnx,zynqmp-8.9a" },
> > >
> > >         { /* sentinel */ }
> > >  };
> > > @@ -642,6 +854,11 @@ static int sdhci_arasan_probe(struct
> > platform_device *pdev)
> > >                 goto unreg_clk;
> > >         }
> > >
> > > +       if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-
> > 8.9a")) {
> > > +               sdhci_arasan_ops.platform_execute_tuning =
> > > +                       arasan_zynqmp_execute_tuning;
> > > +       }
> > > +
> > >         sdhci_arasan->phy = ERR_PTR(-ENODEV);
> > >         if (of_device_is_compatible(pdev->dev.of_node,
> > >                                     "arasan,sdhci-5.1")) {
> > > --
> > > 2.7.4
> > >
> > > This email and any attachments are intended for the sole use of the
> > > named
> > recipient(s) and contain(s) confidential information that may be
> > proprietary, privileged or copyrighted under applicable law. If you
> > are not the intended recipient, do not read, copy, or forward this
> > email message or any attachments. Delete this email message and any
> attachments immediately.
> > >
