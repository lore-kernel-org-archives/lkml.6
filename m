Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B41C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C568120875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C568120875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932431AbeFUAjf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:39:35 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:37038 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbeFUAjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:39:33 -0400
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.129])
        by lucky1.263xmail.com (Postfix) with ESMTP id 8B366967DB;
        Thu, 21 Jun 2018 08:39:28 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.8] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 4E6C5331;
        Thu, 21 Jun 2018 08:39:26 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <7aba6fb4d8ff262df4b0098ffbf36431>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.8] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 22848QO558A;
        Thu, 21 Jun 2018 08:39:28 +0800 (CST)
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        jesper.nilsson@axis.com, sboyd@codeaurora.org,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/11] PCI: Update xxx_pcie_ep_raise_irq() and
 pci_epc_raise_irq() signatures
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        adouglas@cadence.com
References: <cover.1529507416.git.gustavo.pimentel@synopsys.com>
 <180c7a9743a67120e77ab198889c1373e91643b9.1529507416.git.gustavo.pimentel@synopsys.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <8fda923d-b6c3-58aa-c534-f646b134a68b@rock-chips.com>
Date:   Thu, 21 Jun 2018 08:39:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <180c7a9743a67120e77ab198889c1373e91643b9.1529507416.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/21 0:28, Gustavo Pimentel wrote:

>   drivers/pci/controller/pcie-rockchip-ep.c         | 2 +-

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>


