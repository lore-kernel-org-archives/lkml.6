Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeCIXBj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:01:39 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46626 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932186AbeCIXBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:01:37 -0500
X-Google-Smtp-Source: AG47ELsfpLpLNljKtyvDmTiz8oKSGqfWIxgkfdjNkKqlEVp92agZYYKmbGB4gmm/LnRRSgHeNsVFJg==
Date: Fri, 9 Mar 2018 17:01:34 -0600
From: Rob Herring <robh@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v6 2/6] regulator: bindings: Add properties for coupled
 regulators
Message-ID: <20180309230134.asabvtprijfav7ck@rob-hp-laptop>
References: <1520598128-11768-1-git-send-email-m.purski@samsung.com>
 <CGME20180309122233eucas1p14d57674d3e9539db144c401593679c08@eucas1p1.samsung.com>
 <1520598128-11768-3-git-send-email-m.purski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520598128-11768-3-git-send-email-m.purski@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 01:22:04PM +0100, Maciej Purski wrote:
> Some regulators require keeping their voltage spread below defined
> max_spread.
> 
> Add properties to provide information on regulators' coupling.
> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
