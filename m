Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162718AbeCAWlK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:41:10 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34000 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162650AbeCAWlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:41:07 -0500
X-Google-Smtp-Source: AG47ELs9ansg1Mf6kIWpdg7tJUgIB+EWtIdELytZVsFuHTpPJ97LXAjxJCniBEmt8v1orI+wIAIA7Q==
Date: Thu, 1 Mar 2018 16:41:01 -0600
From: Rob Herring <robh@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        atull@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fpga: Consolidate bridge properties
Message-ID: <20180301224101.ob4bdmh7nne5zgvf@rob-hp-laptop>
References: <20180221173306.17265-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221173306.17265-1-mdf@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 09:33:06AM -0800, Moritz Fischer wrote:
> Consolidate bridge properties in a single file, instead of duplicating
> the same optional property over and over again.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Alan Tull <atull@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt |  5 +----
>  .../devicetree/bindings/fpga/altera-freeze-bridge.txt     |  5 +----
>  .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt   |  5 +----
>  Documentation/devicetree/bindings/fpga/fpga-bridge.txt    | 15 +++++++++++++++
>  .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt      |  8 ++------
>  5 files changed, 20 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt

Reviewed-by: Rob Herring <robh@kernel.org>
