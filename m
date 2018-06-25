Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F938C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBD02548F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBD02548F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeFYFyD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:54:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:59401 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751405AbeFYFyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:54:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 22:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="67392420"
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.101])
  by orsmga001.jf.intel.com with SMTP; 24 Jun 2018 22:53:56 -0700
Received: by ubuntu (sSMTP sendmail emulation); Mon, 25 Jun 2018 13:53:56 +0800
Message-ID: <1529906036.5367.1.camel@intel.com>
Subject: Re: [PATCH v4] MAINTAINERS: Add file patterns for nios2 device tree
 bindings
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <lftan@altera.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        nios2-dev@lists.rocketboards.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Jun 2018 13:53:56 +0800
In-Reply-To: <20180622100817.29370-1-geert@linux-m68k.org>
References: <20180622100817.29370-1-geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-22 at 12:08 +0200, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v3:
>   - Update for next-20180622,
> 
> v2:
>   - No changes.
> 
> Impact on "scripts/get_maintainer.pl -f
> Documentation/devicetree/bindings/nios2/":
> 
> -Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE
> BINDINGS,commit_signer:2/2=100%,authored:1/2=50%)
> +Ley Foon Tan <lftan@altera.com> (maintainer:NIOS2 ARCHITECTURE)
> +Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS)
>  Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS)
> -Mathieu Malaterre <malat@debian.org>
> (commit_signer:1/2=50%,authored:1/2=50%)
> -Thierry Reding <thierry.reding@gmail.com> (commit_signer:1/2=50%)
> +nios2-dev@lists.rocketboards.org (moderated list:NIOS2 ARCHITECTURE)
>  devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS)
>  linux-kernel@vger.kernel.org (open list)
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index baa4dc046daf9cdc..dd72b804b9b8bab3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10074,6 +10074,7 @@ M:      Ley Foon Tan <lftan@altera.com>
>  L:     nios2-dev@lists.rocketboards.org (moderated for non-
> subscribers)
>  T:     git
> git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git
>  S:     Maintained
> +F:     Documentation/devicetree/bindings/nios2/
>  F:     arch/nios2/
> 
>  NOHZ, DYNTICKS SUPPORT
> --
> 2.17.1
> 
> 
Reviewed-by: Ley Foon Tan <ley.foon.tan@intel.com>
