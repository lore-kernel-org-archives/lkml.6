Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeFBG07 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 02:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750886AbeFBG0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 02:26:54 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <ray.jui@broadcom.com>, Rob Herring <robh+dt@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527900968-12017-2-git-send-email-ray.jui@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1527900968-12017-1-git-send-email-ray.jui@broadcom.com>
 <1527900968-12017-2-git-send-email-ray.jui@broadcom.com>
Message-ID: <152792081356.225090.6196399335681845828@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/3] dt-bindings: clk: Update Stingray binding doc
Date: Fri, 01 Jun 2018 23:26:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w526RHf7004026

Quoting Ray Jui (2018-06-01 17:56:06)
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Update Stingray clock binding document to add additional clock entries
> with names matching the latest ASIC datasheet. Also modify a few existing
> entries to make their naming more consistent with the rest of the entries
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---

Applied to clk-next
