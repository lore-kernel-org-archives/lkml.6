Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163043AbeCAX0t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:26:49 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37629 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162908AbeCAX0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:26:47 -0500
X-Google-Smtp-Source: AG47ELvNN9efV1sAZ2ynNXPvjENlgBSZW6U48qz/fsl5xmeNNusxtvGz3Qd7X/CvuyvIq8S7N3f0Nw==
Date: Thu, 1 Mar 2018 17:26:45 -0600
From: Rob Herring <robh@kernel.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, sre@kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset: gpio-poweroff: Add
 'timeout-ms' property
Message-ID: <20180301232645.k4lraqvb2qqccipc@rob-hp-laptop>
References: <20180222231714.11843-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222231714.11843-1-mdf@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:17:13PM -0800, Moritz Fischer wrote:
> Add 'timeout-ms' property to support boards where the 3s timeout that the
> current driver defaults to is too short.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Changes from v2:
> - Addressed Rob's feedback (timeout_ms -> timeout-ms)
> 
> Changes from v1:
> - Addressed Rob's feedback (timeout -> timeout_ms)
> - Added to old example rather than creating separate one
> 
> ---
> 
>  Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
