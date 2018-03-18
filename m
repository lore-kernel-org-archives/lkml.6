Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeCRM67 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:58:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35602 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbeCRMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:48:05 -0400
X-Google-Smtp-Source: AG47ELtPhgJRXLGICy6WQcR5nR8zMlSvbM6/LRznNLKDAsoHrEfnXFv544MWyAOCl6bjZ10PzbngGg==
Date: Sun, 18 Mar 2018 07:48:03 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] of: overlay: Remove unused of_overlay_remove_all()
Message-ID: <20180318124803.hv3fsny33trabscf@rob-hp-laptop>
References: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
 <1520592288-7680-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520592288-7680-4-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 11:44:48AM +0100, Geert Uytterhoeven wrote:
> of_overlay_remove_all(), and its predecessor of_overlay_destroy_all(),
> were never used.

Maybe, but I think we should leave it. It's not that much and we'll just 
end up with open coded versions.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/overlay-notes.txt |  4 ----
>  drivers/of/overlay.c                       | 23 -----------------------
>  include/linux/of.h                         |  6 ------
>  3 files changed, 33 deletions(-)
