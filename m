Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeEaDzH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:55:07 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46655 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932672AbeEaDzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:55:04 -0400
X-Google-Smtp-Source: ADUXVKKOzKQICwULmo511m6qDpWSnQ+EgkAurmXdu81F2BuY+ZK2R75Zds7kGrdrjzqbpVVfuQd+PQ==
Date: Wed, 30 May 2018 22:55:01 -0500
From: Rob Herring <robh@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, coresight@lists.linaro.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com
Subject: Re: [PATCH v2 12/12] coresight: tmc: Add configuration support for
 trace buffer size
Message-ID: <20180531035501.GA15549@rob-hp-laptop>
References: <1527599737-28408-1-git-send-email-suzuki.poulose@arm.com>
 <1527599737-28408-13-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527599737-28408-13-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 02:15:37PM +0100, Suzuki K Poulose wrote:
> Now that we can dynamically switch between contiguous memory and
> SG table depending on the trace buffer size, provide the support
> for selecting an appropriate buffer size.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  8 ++++++
>  .../devicetree/bindings/arm/coresight.txt          |  3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/hwtracing/coresight/coresight-tmc.c        | 33 ++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
