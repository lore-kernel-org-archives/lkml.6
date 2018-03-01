Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162392AbeCAV4g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:56:36 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40214 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162136AbeCAV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:56:33 -0500
X-Google-Smtp-Source: AG47ELv4SpxwWL9sdLbl/XG6kOjmuk1vUEEPAbZKk23i4WAtgYNkGlI5kxevM3uXiga0u0bVFqFknQ==
Date: Thu, 1 Mar 2018 15:56:31 -0600
From: Rob Herring <robh@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/15] dt-bindings: memory: tegra: Add hot resets
 definitions
Message-ID: <20180301215631.6wm3e4rtrqsbqn72@rob-hp-laptop>
References: <cover.1519141896.git.digetx@gmail.com>
 <8b54af80e13406fc873dcc5932223f5d1c196172.1519141896.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b54af80e13406fc873dcc5932223f5d1c196172.1519141896.git.digetx@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 07:25:17PM +0300, Dmitry Osipenko wrote:
> Add definitions for the Tegra20+ memory controller hot resets.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra114-mc.h | 19 +++++++++++++++++++
>  include/dt-bindings/memory/tegra124-mc.h | 25 +++++++++++++++++++++++++
>  include/dt-bindings/memory/tegra20-mc.h  | 21 +++++++++++++++++++++
>  include/dt-bindings/memory/tegra210-mc.h | 31 +++++++++++++++++++++++++++++++
>  include/dt-bindings/memory/tegra30-mc.h  | 19 +++++++++++++++++++
>  5 files changed, 115 insertions(+)
>  create mode 100644 include/dt-bindings/memory/tegra20-mc.h

Reviewed-by: Rob Herring <robh@kernel.org>
