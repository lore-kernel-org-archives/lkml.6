Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162365AbeCAVu5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:50:57 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43195 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162201AbeCAVuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:50:52 -0500
X-Google-Smtp-Source: AG47ELsh2CZA8deAb4f8dXCkvVj3HP07TchOv0bV3pF8ueV+cFQxNkiDMJhzkC5CZg6WUsqBJvSCRA==
Date: Thu, 1 Mar 2018 15:50:50 -0600
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/19] dt-bindings: serial: sh-sci: Add support for
 r8a77965 (H)SCIF
Message-ID: <20180301215050.ta5wjzho6ib6i34r@rob-hp-laptop>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-13-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519139541-18783-13-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:12:14PM +0100, Jacopo Mondi wrote:
> Add documentation for r8a77965 compatible string to Renesas sci-serial
> device tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
