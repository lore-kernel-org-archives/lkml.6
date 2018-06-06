Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGJjvqFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D73D360290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeFFPDf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:03:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40870 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbeFFPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:03:24 -0400
X-Google-Smtp-Source: ADUXVKI5eowgpWG/wVEXq45l7h8DOOD05RmQMJmIzD3R9xzDCaZXNJuhG7BNKcqaay/1ioxlqjySfQ==
From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 5/7] interconnect: qcom: Add msm8916 interconnect
 provider driver
To: Evan Green <evgreen@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        davidai@quicinc.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-6-georgi.djakov@linaro.org>
 <CAE=gft4LT_JSGytuiSx5uwzfeGc0DK140+D4c_J8FVUHioHdcg@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <21c5adcc-dc18-73a1-e07a-d84f2e6ae534@linaro.org>
Date: Wed, 6 Jun 2018 18:03:21 +0300
MIME-Version: 1.0
In-Reply-To: <CAE=gft4LT_JSGytuiSx5uwzfeGc0DK140+D4c_J8FVUHioHdcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 12.05.18 г. 0:29, Evan Green wrote:
> Hi Georgi,
> 
> On Fri, Mar 9, 2018 at 1:11 PM Georgi Djakov <georgi.djakov@linaro.org>
> wrote:
> 
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
> 
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>    drivers/interconnect/Kconfig        |   5 +
>>    drivers/interconnect/Makefile       |   1 +
>>    drivers/interconnect/qcom/Kconfig   |  11 +
>>    drivers/interconnect/qcom/Makefile  |   2 +
>>    drivers/interconnect/qcom/msm8916.c | 482
> ++++++++++++++++++++++++++++++++++++
>>    include/linux/interconnect/qcom.h   | 350 ++++++++++++++++++++++++++
>>    6 files changed, 851 insertions(+)
>>    create mode 100644 drivers/interconnect/qcom/Kconfig
>>    create mode 100644 drivers/interconnect/qcom/msm8916.c
>>    create mode 100644 include/linux/interconnect/qcom.h
> ...
>> diff --git a/drivers/interconnect/qcom/msm8916.c
> b/drivers/interconnect/qcom/msm8916.c
>> new file mode 100644
>> index 000000000000..d5b54f8261c8
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/msm8916.c
> ...
>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +       const struct qcom_icc_desc *desc;
>> +       struct qcom_icc_node **qnodes;
>> +       struct qcom_icc_provider *qp;
>> +       struct resource *res;
>> +       struct icc_provider *provider;
>> +       size_t num_nodes, i;
>> +       int ret;
>> +
>> +       /* wait for RPM */
>> +       if (!qcom_icc_rpm_smd_available())
>> +               return -EPROBE_DEFER;
>> +
>> +       desc = of_device_get_match_data(&pdev->dev);
>> +       if (!desc)
>> +               return -EINVAL;
>> +
>> +       qnodes = desc->nodes;
>> +       num_nodes = desc->num_nodes;
>> +
>> +       qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +       if (!qp)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       qp->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(qp->base))
>> +               return PTR_ERR(qp->base);
>> +
>> +       qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
>> +       if (IS_ERR(qp->bus_clk))
>> +               return PTR_ERR(qp->bus_clk);
>> +
>> +       qp->bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
>> +       if (IS_ERR(qp->bus_a_clk))
>> +               return PTR_ERR(qp->bus_a_clk);
>> +
>> +       provider = &qp->provider;
>> +       provider->dev = &pdev->dev;
>> +       provider->set = &qcom_icc_set;
>> +       INIT_LIST_HEAD(&provider->nodes);
>> +       provider->data = qp;
>> +
>> +       ret = icc_add_provider(provider);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "error adding interconnect
> provider\n");
>> +               return ret;
>> +       }
>> +
>> +       for (i = 0; i < num_nodes; i++) {
>> +               struct icc_node *node;
>> +               int ret;
>> +               size_t j;
>> +
>> +               node = icc_node_create(qnodes[i]->id);
>> +               if (IS_ERR(node)) {
>> +                       ret = PTR_ERR(node);
>> +                       goto err;
>> +               }
>> +
>> +               node->name = qnodes[i]->name;
>> +               node->data = qnodes[i];
>> +               icc_node_add(node, provider);
>> +
>> +               dev_dbg(&pdev->dev, "registered node %p %s %d\n", node,
>> +                       qnodes[i]->name, node->id);
>> +
>> +               /* populate links */
>> +               for (j = 0; j < qnodes[i]->num_links; j++)
>> +                       if (qnodes[i]->links[j])
>> +                               icc_link_create(node,
> qnodes[i]->links[j]);
>> +
>> +               ret = qcom_icc_init(node);
>> +               if (ret)
>> +                       dev_err(&pdev->dev, "%s init error (%d)\n",
> node->name,
>> +                               ret);
> 
> Don't you want to call qcom_icc_init before icc_link_create? As soon as
> icc_link_create is called, the node is connected to the graph, and
> qcom_icc_set can be called.
> 

I agree.

>> +       }
>> +
>> +       platform_set_drvdata(pdev, provider);
>> +
>> +       return ret;
>> +err:
>> +       icc_del_provider(provider);
>> +       return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +       struct icc_provider *provider = platform_get_drvdata(pdev);
>> +
>> +       icc_del_provider(provider);
> 
> Presumably in the framework nodes and links ought to get cleaned up
> somewhere too, right? As it is now, the devm code frees provider when this
> device is removed, even though provider is still very connected in the
> graph via the nodes and links.

Sorry, this part is incomplete. Will implement the rest of the cleanup code.

>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id qnoc_of_match[] = {
>> +       { .compatible = "qcom,msm8916-pnoc", .data = &msm8916_pnoc },
>> +       { .compatible = "qcom,msm8916-snoc", .data = &msm8916_snoc },
>> +       { .compatible = "qcom,msm8916-bimc", .data = &msm8916_bimc },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>> +
>> +static struct platform_driver qnoc_driver = {
>> +       .probe = qnoc_probe,
>> +       .remove = qnoc_remove,
>> +       .driver = {
>> +               .name = "qnoc-msm8916",
>> +               .of_match_table = qnoc_of_match,
>> +       },
>> +};
>> +module_platform_driver(qnoc_driver);
>> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
>> +MODULE_DESCRIPTION("Qualcomm msm8916 NoC driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/interconnect/qcom.h
> b/include/linux/interconnect/qcom.h
>> new file mode 100644
>> index 000000000000..2cd378d2f575
>> --- /dev/null
>> +++ b/include/linux/interconnect/qcom.h
>> @@ -0,0 +1,350 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Qualcomm interconnect IDs
>> + *
>> + * Copyright (c) 2018, Linaro Ltd.
>> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
>> + */
>> +
>> +#ifndef __QCOM_INTERCONNECT_IDS_H
>> +#define __QCOM_INTERCONNECT_IDS_H
>> +
>> +#define FAB_BIMC 0
>> +#define FAB_SYS_NOC 1024
>> +#define FAB_MMSS_NOC 2048
>> +#define FAB_OCMEM_NOC 3072
>> +#define FAB_PERIPH_NOC 4096
>> +#define FAB_CONFIG_NOC 5120
>> +#define FAB_OCMEM_VNOC 6144
> 
> Looks like you're still following that downstream convention of NoCs being
> divisible by 1024, masters in 1-512, and slaves in 512-1023, then I don't
> know about the 10000s. This was documented somewhere downstream, can you
> add that documentation somewhere in here?

Yes, i am currently following the existing IDs. The 10000s are the nodes
used for the interconnects between the NoCs. I don't think it's worth
documenting this, as the plan is to switch to arbitrary numbers.

Thanks,
Georgi
