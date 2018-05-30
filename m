Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeE3XlH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 19:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932408AbeE3XlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 19:41:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <ray.jui@broadcom.com>, Rob Herring <robh+dt@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527266717-8406-3-git-send-email-ray.jui@broadcom.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
References: <1527266717-8406-1-git-send-email-ray.jui@broadcom.com>
 <1527266717-8406-3-git-send-email-ray.jui@broadcom.com>
Message-ID: <152772366322.144038.12289577935853704907@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] clk: bcm: Update and add tingray clock entries
Date: Wed, 30 May 2018 16:41:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UNfCfc025178

Subject is missing an 's' on stringray?

Quoting Ray Jui (2018-05-25 09:45:16)
> Update and add Stingray clock definitions and tables so they match the
> binding document and the latest ASIC datasheet
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Otherwise it looks ok, but maybe Pramod should be the author?
