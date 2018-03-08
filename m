Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935205AbeCHCnQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:43:16 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42857 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934807AbeCHCe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:34:59 -0500
X-Google-Smtp-Source: AG47ELsxkkwX/hbRbci+KzUj+3b1v2Api8NbWmgMm4XYcvVWkcngtbywajIVAt+MTXzWNJqSLvuWwA==
Date: Wed, 7 Mar 2018 20:34:56 -0600
From: Rob Herring <robh@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        mark.rutland@arm.com, hare@suse.de, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH v4 01/10] dt-bindings: scsi: hisi_sas: add an property of
 signal attenuation
Message-ID: <20180308023456.zhisinte6rjgdvid@rob-hp-laptop>
References: <1520425514-205565-1-git-send-email-john.garry@huawei.com>
 <1520425514-205565-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520425514-205565-2-git-send-email-john.garry@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 08:25:05PM +0800, John Garry wrote:
> From: Xiaofei Tan <tanxiaofei@huawei.com>
> 
> For some new boards with hip07 chipset we are required to
> set PHY config registers differently. The hw property which
> determines how to set these registers is in the PHY signal
> attenuation readings.
> 
> This patch add an devicetree property, "hisilicon,signal-attenuation",
> which is used to describe the signal attenuation of an board.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  Documentation/devicetree/bindings/scsi/hisilicon-sas.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
