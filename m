Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938590AbeE1MET (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:04:19 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:57824
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938439AbeE1MEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:04:14 -0400
From: Samarth Parikh <Samarth.Parikh@arm.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sudipto Paul" <Sudipto.Paul@arm.com>,
        Arvind Chauhan <Arvind.Chauhan@arm.com>,
        "Deepak Pandey" <Deepak.Pandey@arm.com>,
        "samarthp@ymail.com" <samarthp@ymail.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH v2] mailbox: arm_mhu: add support for mhuv2
Thread-Topic: [PATCH v2] mailbox: arm_mhu: add support for mhuv2
Thread-Index: AQHT7bWvwVNU2Rz5SEGVi9ahdctk6qRFeL+A
Date: Mon, 28 May 2018 12:04:10 +0000
Message-ID: <39CE13B0-70F3-4FEE-A593-B9E429DB0680@arm.com>
References: <1526544259-27891-1-git-send-email-samarth.parikh@arm.com>
In-Reply-To: <1526544259-27891-1-git-send-email-samarth.parikh@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Samarth.Parikh@arm.com;
x-originating-ip: [217.140.105.40]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0801MB1249;7:5cKQ8nlSFuf2ZbgOKqSr6MfRIR2BSBosh1NYOnlaU5YN/77cdy90e0w4NvY/v/waVAgwHjyP56fh/xDPWKLfJb8M1e1RuVwjTU9uGbTN91hdErprNhJtlNKmNQV63W8AeFPTSa3T5tMTd7DwLc9m7qsQkhCaI+X88ad+i8fWIDLu8ukrpPERsRbHtsHHcpd8RLXc6SxRWH6bX9D6OUk3Lm39GAJ/CKzAYWZ9j1bkVpfP1HYWafP0+8q3aew8Jb83
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1249;
x-ms-traffictypediagnostic: AM5PR0801MB1249:
x-microsoft-antispam-prvs: <AM5PR0801MB1249EB1BE23AEDA68CF55AEF9C6E0@AM5PR0801MB1249.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9584868988793);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1249;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1249;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(199004)(189003)(40434004)(25786009)(102836004)(186003)(76176011)(3846002)(6506007)(26005)(6246003)(446003)(11346002)(53936002)(4326008)(2906002)(6116002)(476003)(486006)(2616005)(66066001)(82746002)(1730700003)(54906003)(68736007)(5250100002)(5890100001)(81166006)(59450400001)(39060400002)(8936002)(8676002)(2501003)(2900100001)(81156014)(15650500001)(33656002)(7736002)(1361003)(1411001)(229853002)(478600001)(3280700002)(2351001)(97736004)(316002)(5640700003)(72206003)(3660700001)(83716003)(99286004)(36756003)(6436002)(105586002)(86362001)(6916009)(106356001)(575784001)(14454004)(305945005)(5660300001)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1249;H:AM5PR0801MB1250.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8/bsLTeYYPkKHifPY5TdpZuYGzFOScAOSq/G44KpuOuCto2q5HYMj0gxD5uw+9x8TdYwhLTtMnS2q3eJTOYNwyfeA2pW9i8qxVOWEmNy4IkaF51zesYZOZWElh9UgrKcghP/+c33FkY8Q091cD2KRr9AzExLfBmrKPoz+kt0GZJ7gzJKXol7PTGBc6h+VSyg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <693BD9BAA798E141851BED6FD51A813C@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b38bd104-d35c-4a24-4fe9-08d5c4931f7c
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38bd104-d35c-4a24-4fe9-08d5c4931f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 12:04:10.8707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1249
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4SC4Uhr022685

Hi Jassi,

In case you have missed my updated patch. Can you please go through it and let me know your thoughts on the same?

Regards,
Samarth

﻿On 17/05/18, 1:34 PM, "Samarth Parikh" <samarth.parikh@arm.com> wrote:

    ARM has launched a next version of MHU i.e. MHUv2 with its latest
    subsystems. The main change is that the MHUv2 is now a distributed IP
    with different peripheral views (registers) for the sender and receiver.

    Another main difference is that MHUv1 duplex channels are now split into
    simplex/half duplex in MHUv2. MHUv2 has a configurable number of
    communication channels. There is a capability register (MSG_NO_CAP) to
    find out how many channels are available in a system.

    The register offsets have also changed for STAT, SET & CLEAR registers
    from 0x0, 0x8 & 0x10 in MHUv1 to 0x0, 0xC & 0x8 in MHUv2 respectively.

    0x0    0x4  0x8  0xC             0x1F
    ------------------------....-----
    | STAT |    |    | SET |    |   |
    ------------------------....-----
          Transmit Channel

    0x0    0x4  0x8   0xC            0x1F
    ------------------------....-----
    | STAT |    | CLR |    |    |   |
    ------------------------....-----
            Receive Channel

    The MHU controller can request the receiver to wake-up and once the
    request is removed, the receiver may go back to sleep, but the MHU
    itself does not actively puts a receiver to sleep.

    So, in order to wake-up the receiver when the sender wants to send data,
    the sender has to set ACCESS_REQUEST register first in order to wake-up
    receiver, state of which can be detected using ACCESS_READY register.
    ACCESS_REQUEST has an offset of 0xF88 & ACCESS_READY has an offset
    of 0xF8C and are accessible only on any sender channel.

    This patch adds necessary changes in a new file required to support the
    latest MHUv2 controller. This patch also need an update in DT binding for
    ARM MHUv2 as we need a second register base (tx base) which would be used
    as the send channel base.

    Signed-off-by: Samarth Parikh <samarth.parikh@arm.com>
    ---
     drivers/mailbox/Kconfig      |   9 ++
     drivers/mailbox/Makefile     |   2 +
     drivers/mailbox/arm_mhu_v2.c | 301 +++++++++++++++++++++++++++++++++++++++++++
     3 files changed, 312 insertions(+)
     create mode 100644 drivers/mailbox/arm_mhu_v2.c

    diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
    index a2bb274..416bc78 100644
    --- a/drivers/mailbox/Kconfig
    +++ b/drivers/mailbox/Kconfig
    @@ -15,6 +15,15 @@ config ARM_MHU
       The controller has 3 mailbox channels, the last of which can be
       used in Secure mode only.

    +config ARM_MHU_V2
    +tristate "ARM MHUv2 Mailbox"
    +depends on ARM_AMBA
    +help
    +  Say Y here if you want to build the ARM MHUv2 controller driver.
    +  The controller is a distributed IP with different peripheral
    +  views (registers) for the sender and receiver & has 3 mailbox
    +  channels, the last of which can be used in Secure mode only.
    +
     config PLATFORM_MHU
     tristate "Platform MHU Mailbox"
     depends on OF
    diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
    index cc23c3a..ae899a9 100644
    --- a/drivers/mailbox/Makefile
    +++ b/drivers/mailbox/Makefile
    @@ -7,6 +7,8 @@ obj-$(CONFIG_MAILBOX_TEST)+= mailbox-test.o

     obj-$(CONFIG_ARM_MHU)+= arm_mhu.o

    +obj-$(CONFIG_ARM_MHU_V2)+= arm_mhu_v2.o
    +
     obj-$(CONFIG_PLATFORM_MHU)+= platform_mhu.o

     obj-$(CONFIG_PL320_MBOX)+= pl320-ipc.o
    diff --git a/drivers/mailbox/arm_mhu_v2.c b/drivers/mailbox/arm_mhu_v2.c
    new file mode 100644
    index 0000000..c90725b
    --- /dev/null
    +++ b/drivers/mailbox/arm_mhu_v2.c
    @@ -0,0 +1,301 @@
    +// SPDX-License-Identifier: GPL-2.0
    +/*
    + * Copyright (C) 2018 ARM Ltd.
    + * Author: Samarth Parikh <samarth.parikh@arm.com>
    + *
    + */
    +
    +#include <linux/interrupt.h>
    +#include <linux/mutex.h>
    +#include <linux/slab.h>
    +#include <linux/err.h>
    +#include <linux/io.h>
    +#include <linux/module.h>
    +#include <linux/amba/bus.h>
    +#include <linux/mailbox_controller.h>
    +#include <linux/of_device.h>
    +#include <linux/of_address.h>
    +
    +#define MHU_V2_REG_STAT_OFS0x0
    +#define MHU_V2_REG_CLR_OFS0x8
    +#define MHU_V2_REG_SET_OFS0xC
    +#define MHU_V2_REG_MSG_NO_CAP_OFS0xF80
    +#define MHU_V2_REG_ACC_REQ_OFS0xF88
    +#define MHU_V2_REG_ACC_RDY_OFS0xF8C
    +
    +#define MHU_V2_LP_OFFSET0x20
    +#define MHU_V2_HP_OFFSET0x0
    +
    +#define MHU_V2_CHANS3
    +
    +#define mbox_to_mhuv2_drv_data(c) container_of(c, struct mhuv2_drv_data, mbox)
    +
    +enum mhuv2_regs {
    +MHU_V2_REG_STAT,
    +MHU_V2_REG_SET,
    +MHU_V2_REG_CLR,
    +MHU_V2_REG_END
    +};
    +
    +enum mhuv2_access_regs {
    +MHU_V2_REG_MSG_NO_CAP,
    +MHU_V2_REG_ACC_REQ,
    +MHU_V2_REG_ACC_RDY,
    +MHU_V2_REG_ACC_END
    +};
    +
    +enum mhuv2_channels {
    +MHU_V2_CHAN_LOW,
    +MHU_V2_CHAN_HIGH,
    +MHU_V2_CHAN_SEC,
    +MHU_V2_CHAN_END
    +};
    +
    +/**
    + * ARM MHUv2 Mailbox device specific data
    + *
    + * @regs: MHUv2 specific array of register offset for STAT, SET & CLEAR
    + *        registers.
    + * @chans: MHUv2 specific array of channel offset for Low
    + *         Priority, High Priority & Secure channels.
    + * @acc_regs: An array of access register offsets.
    + */
    +struct mhuv2_dev_data {
    +int regs[MHU_V2_REG_END]; /* STAT, SET, CLEAR */
    +int chans[MHU_V2_CHAN_END]; /* LP, HP, Sec */
    +int acc_regs[MHU_V2_REG_ACC_END];
    +};
    +
    +/**
    + * ARM MHUv2 link specific data
    + *
    + * @irq: MHUv2 receive channel IRQ number
    + * @tx_reg: Transmit channel register
    + * @rx_reg: Receive channel register
    + * @pchan: No. of physical channels
    + */
    +struct mhuv2_link {
    +unsigned int irq;
    +void __iomem *tx_reg;
    +void __iomem *rx_reg;
    +unsigned int pchan;
    +};
    +
    +/**
    + * ARM MHUv2 Mailbox driver specific data
    + *
    + * @mlink: MHUv2 link specific data
    + * @chan: Mbox specific data
    + * @mbox: Mbox controller specific data
    + * @drvdata: MHUv2 device specific data
    + */
    +struct mhuv2_drv_data {
    +struct mhuv2_link mlink[MHU_V2_CHANS];
    +struct mbox_chan chan[MHU_V2_CHANS];
    +struct mbox_controller mbox;
    +const struct mhuv2_dev_data *drvdata;
    +};
    +
    +static irqreturn_t mhuv2_rx_interrupt(int irq, void *p)
    +{
    +struct mbox_chan *chan = p;
    +struct mhuv2_link *mlink = chan->con_priv;
    +struct mhuv2_drv_data *mhu = mbox_to_mhuv2_drv_data(chan->mbox);
    +const struct mhuv2_dev_data *mdata = mhu->drvdata;
    +u32 val;
    +
    +val = readl_relaxed(mlink->rx_reg + mdata->regs[MHU_V2_REG_STAT]);
    +if (!val)
    +return IRQ_NONE;
    +
    +mbox_chan_received_data(chan, (void *)&val);
    +writel_relaxed(val, mlink->rx_reg + mdata->regs[MHU_V2_REG_CLR]);
    +return IRQ_HANDLED;
    +}
    +
    +static bool mhuv2_last_tx_done(struct mbox_chan *chan)
    +{
    +struct mhuv2_link *mlink = chan->con_priv;
    +struct mhuv2_drv_data *mhu = mbox_to_mhuv2_drv_data(chan->mbox);
    +const struct mhuv2_dev_data *mdata = mhu->drvdata;
    +u32 val = readl_relaxed(mlink->tx_reg + mdata->regs[MHU_V2_REG_STAT]);
    +
    +return (val == 0);
    +}
    +
    +static int mhuv2_send_data(struct mbox_chan *chan, void *data)
    +{
    +struct mhuv2_link *mlink = chan->con_priv;
    +struct mhuv2_drv_data *mhu = mbox_to_mhuv2_drv_data(chan->mbox);
    +const struct mhuv2_dev_data *mdata = mhu->drvdata;
    +u32 *arg = data;
    +
    +writel_relaxed(*arg, mlink->tx_reg + mdata->regs[MHU_V2_REG_SET]);
    +return 0;
    +}
    +
    +static int mhuv2_startup(struct mbox_chan *chan)
    +{
    +struct mhuv2_link *mlink = chan->con_priv;
    +struct mhuv2_drv_data *mhu = mbox_to_mhuv2_drv_data(chan->mbox);
    +const struct mhuv2_dev_data *mdata = mhu->drvdata;
    +u32 val;
    +int ret;
    +
    +writel_relaxed(0x1, mlink->tx_reg
    ++ (mdata->acc_regs[MHU_V2_REG_ACC_REQ]
    +- (mdata->chans[mlink->pchan])));
    +
    +val = readl_relaxed(mlink->tx_reg + mdata->regs[MHU_V2_REG_STAT]);
    +writel_relaxed(val, mlink->tx_reg + mdata->regs[MHU_V2_REG_CLR]);
    +ret = request_irq(mlink->irq, mhuv2_rx_interrupt,
    +  IRQF_SHARED, "mhuv2_link", chan);
    +if (ret) {
    +dev_err(chan->mbox->dev,
    +"unable to acquire IRQ %d\n", mlink->irq);
    +return ret;
    +}
    +return 0;
    +}
    +
    +static void mhuv2_shutdown(struct mbox_chan *chan)
    +{
    +struct mhuv2_link *mlink = chan->con_priv;
    +struct mhuv2_drv_data *mhu = mbox_to_mhuv2_drv_data(chan->mbox);
    +const struct mhuv2_dev_data *mdata = mhu->drvdata;
    +
    +writel_relaxed(0x0, mlink->tx_reg
    ++ (mdata->acc_regs[MHU_V2_REG_ACC_REQ]
    +- (mdata->chans[mlink->pchan])));
    +
    +free_irq(mlink->irq, chan);
    +}
    +
    +static const struct mbox_chan_ops mhuv2_ops = {
    +.send_data = mhuv2_send_data,
    +.startup = mhuv2_startup,
    +.shutdown = mhuv2_shutdown,
    +.last_tx_done = mhuv2_last_tx_done,
    +};
    +
    +static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
    +{
    +int i, err, irq;
    +struct mhuv2_drv_data *mhu;
    +struct device *dev = &adev->dev;
    +void __iomem *rx_base;
    +void __iomem *tx_base;
    +const struct device_node *np = dev->of_node;
    +const struct mhuv2_dev_data *mdata = id->data;
    +unsigned int pchans;
    +
    +if (!mdata) {
    +dev_err(dev, "device data not found\n");
    +return -EINVAL;
    +}
    +
    +/* Allocate memory for device */
    +mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
    +if (!mhu)
    +return -ENOMEM;
    +
    +rx_base = of_iomap((struct device_node *)np, 0);
    +if (!rx_base) {
    +dev_err(dev, "failed to map rx registers\n");
    +return -ENOMEM;
    +}
    +
    +tx_base = of_iomap((struct device_node *)np, 1);
    +if (!tx_base) {
    +dev_err(dev, "failed to map tx registers\n");
    +return -ENOMEM;
    +}
    +
    +pchans = readl_relaxed(tx_base
    ++ mdata->acc_regs[MHU_V2_REG_MSG_NO_CAP]);
    +if (pchans == 0 || pchans > MHU_V2_CHANS) {
    +dev_err(dev, "invalid number of channels %d\n", pchans);
    +iounmap(tx_base);
    +return -EINVAL;
    +}
    +
    +for (i = 0; i < pchans; i++) {
    +mhu->chan[i].con_priv = &mhu->mlink[i];
    +mhu->mlink[i].pchan = i;
    +irq = mhu->mlink[i].irq = adev->irq[i];
    +
    +if (irq <= 0) {
    +dev_err(dev, "no IRQ found for channel %d\n", i);
    +iounmap(tx_base);
    +return -EINVAL;
    +}
    +
    +mhu->mlink[i].rx_reg = rx_base + mdata->chans[i];
    +mhu->mlink[i].tx_reg = tx_base + mdata->chans[i];
    +}
    +
    +mhu->mbox.dev = dev;
    +mhu->mbox.chans = &mhu->chan[0];
    +mhu->mbox.num_chans = pchans;
    +mhu->mbox.ops = &mhuv2_ops;
    +mhu->mbox.txdone_irq = false;
    +mhu->mbox.txdone_poll = true;
    +mhu->mbox.txpoll_period = 1;
    +mhu->drvdata = mdata;
    +
    +amba_set_drvdata(adev, mhu);
    +
    +err = mbox_controller_register(&mhu->mbox);
    +if (err) {
    +dev_err(dev, "failed to register mailboxes %d\n", err);
    +iounmap(tx_base);
    +return err;
    +}
    +
    +dev_info(dev, "ARM MHUv2 Mailbox driver registered\n");
    +return 0;
    +}
    +
    +static int mhuv2_remove(struct amba_device *adev)
    +{
    +struct mhuv2_drv_data *mhu = amba_get_drvdata(adev);
    +
    +mbox_controller_unregister(&mhu->mbox);
    +return 0;
    +}
    +
    +static struct mhuv2_dev_data arm_mhuv2_data = {
    +.regs = { MHU_V2_REG_STAT_OFS, MHU_V2_REG_SET_OFS, MHU_V2_REG_CLR_OFS },
    +.chans = { MHU_V2_LP_OFFSET, MHU_V2_HP_OFFSET },
    +.acc_regs = { MHU_V2_REG_MSG_NO_CAP_OFS, MHU_V2_REG_ACC_REQ_OFS,
    +MHU_V2_REG_ACC_RDY_OFS },
    +};
    +
    +static struct amba_id mhuv2_ids[] = {
    +{
    +.id     = 0x4b0d1,
    +.mask   = 0xfffff,
    +.data= (void *)&arm_mhuv2_data,
    +},
    +{
    +.id     = 0xbb0d1,
    +.mask   = 0xfffff,
    +.data= (void *)&arm_mhuv2_data,
    +},
    +{ 0, 0 },
    +};
    +MODULE_DEVICE_TABLE(amba, mhuv2_ids);
    +
    +static struct amba_driver arm_mhuv2_driver = {
    +.drv = {
    +.name= "mhuv2",
    +},
    +.id_table= mhuv2_ids,
    +.probe= mhuv2_probe,
    +.remove= mhuv2_remove,
    +};
    +module_amba_driver(arm_mhuv2_driver);
    +
    +MODULE_LICENSE("GPL v2");
    +MODULE_DESCRIPTION("ARM MHUv2 Driver");
    +MODULE_AUTHOR("Samarth Parikh <samarthp@ymail.com>");
    --
    2.7.4



IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
