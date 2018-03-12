Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeCLJzq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:55:46 -0400
Received: from foss.arm.com ([217.140.101.70]:51756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbeCLJzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:55:45 -0400
Subject: Re: [RFC PATCH 0/4] add support for CommonLPIAff field
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <3b6997c9-761f-3f5e-79ac-6b785a9a14d9@arm.com>
Date: Mon, 12 Mar 2018 09:55:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520837395-10288-1-git-send-email-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/18 06:49, Yang Yingliang wrote:
> This patch set adjust struct rdists to support CommonLPIAff field.
> This field is described in spec:
> 
> CommonLPIAff, bits [25:24]
> The affinity level at which Redistributors share a LPI Configuration table.
> 00 All Redistributors must share a LPI Configuration table.
> 01 All Redistributors with the same Aff3 value must share an LPI Configurationt table.
> 10 All Redistributors
> 11 All Redistributors with the same Aff3.Aff2.Aff1 value must share an LPI Configuration
> table.

What are you trying to achieve here? We already share the same
configuration table across all the redistributors, irrelevant the of
CommonLPIAff. Why would we need to do anything else?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
