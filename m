Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeBEGNH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:13:07 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36759 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeBEGIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:40 -0500
X-Google-Smtp-Source: AH8x22550MNCs5OwNfx2BmN8ne4/Db2DE0GFyqs0WkwiYm0UkUmV4MWrKr2CywOuUobGq/C9bSYJaQ==
Date: Mon, 5 Feb 2018 00:08:37 -0600
From: Rob Herring <robh@kernel.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] Documentation: dt-bindings: arm: Document kryo385
 cpu
Message-ID: <20180205060837.m4wwnh3dhav75d5y@rob-hp-laptop>
References: <20180131161941.29865-1-rnayak@codeaurora.org>
 <20180131161941.29865-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131161941.29865-2-rnayak@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 09:49:39PM +0530, Rajendra Nayak wrote:
> Document the compatible string for the Kryo385 cpus found in qualcomm
> SoCs.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)

"dt-bindings: arm: " for the subject prefix. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
