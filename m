Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755706AbeEaQ0D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:26:03 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45128 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755653AbeEaQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:25:58 -0400
X-Google-Smtp-Source: ADUXVKLMmGZvq4OJOxODfHfOquMNwjFOKHMhf5qvb+Z26fp2IAb8+brmtmat3bLa2AmX0VPf4hdK4g==
Date: Thu, 31 May 2018 11:25:56 -0500
From: Rob Herring <robh@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH 2/3] clk: bcm: Update and add tingray clock entries
Message-ID: <20180531162556.GA955@rob-hp-laptop>
References: <1527266717-8406-1-git-send-email-ray.jui@broadcom.com>
 <1527266717-8406-3-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527266717-8406-3-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 09:45:16AM -0700, Ray Jui wrote:
> Update and add Stingray clock definitions and tables so they match the
> binding document and the latest ASIC datasheet
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---
>  drivers/clk/bcm/clk-sr.c           | 135 ++++++++++++++++++++++++++++++++-----
>  include/dt-bindings/clock/bcm-sr.h |  24 +++++--

This goes in the 1st patch.

>  2 files changed, 137 insertions(+), 22 deletions(-)
