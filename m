Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755943AbeEAO0C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:26:02 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:40578 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754630AbeEAO0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:26:00 -0400
X-Google-Smtp-Source: AB8JxZqwetcOTXjpq86Ioly/6OCg7RcN0ESyJCW23jg+ZlgXfFTQSZQtm882Ea6IWbaRyFk1czba9A==
Date: Tue, 1 May 2018 09:25:59 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: panel: lvds: Fix path to display timing
 bindings
Message-ID: <20180501142559.GA13179@rob-hp-laptop>
References: <1524642578-2885-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524642578-2885-1-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 09:49:38AM +0200, Geert Uytterhoeven wrote:
> Fixes: 14da3ed8dd08c581 ("devicetree/bindings: display: Document common
> panel properties")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-common.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
