Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeCRMsQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:48:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37608 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeCRMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:48:10 -0400
X-Google-Smtp-Source: AG47ELu8GsSp8eFv2YUv0ZNDPpqdtmhP2o7qZv2jzNP3zGKYlwJckjf88zF+ypv/EHaFhHiq9cr1/A==
Date: Sun, 18 Mar 2018 07:48:08 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] of: overlay: Fix forgotten reference to
 of_overlay_apply()
Message-ID: <20180318124808.dqdjtejtjit3yi7m@rob-hp-laptop>
References: <1520592288-7680-1-git-send-email-geert+renesas@glider.be>
 <1520592288-7680-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520592288-7680-3-git-send-email-geert+renesas@glider.be>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 11:44:47AM +0100, Geert Uytterhoeven wrote:
> While technically the ovcs_id is still returned by of_overlay_apply(),
> this is an internal function.  All public callers of of_overlay_remove()
> pass an ovcs_id returned by the public function of_overlay_fdt_apply().
> 
> Fixes: 39a751a4cb7e4798 ("of: change overlay apply input data from unflattened to FDT")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The single internal caller is of_overlay_remove_all().
> ---
>  drivers/of/overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.
