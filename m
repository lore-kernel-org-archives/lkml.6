Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA91C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2D12084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="f5TlQoBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbeLOPRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:17:43 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47788 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbeLOPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:17:43 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6552025AD76;
        Sun, 16 Dec 2018 02:17:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544887060; bh=k6SOkAqrkojZI4BGjomq1TfDfFB6dx+PG7FkwL1StKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5TlQoBmDhhEO7cj048llwfMSij8gJLEO4XSm5WdOPILJ017GVagXFebYTH+d3+O7
         Yu7zN/VBsaJI2en3tOe6eITbLt+UIiO6FBU0muYYTFRmvT6xOCR/MvSi6hym/K+Tdn
         FNCSL7ukjaMXtbtWZwF+CsXBDrrDVVhb0qoXhgII=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 68EB5E20E06; Sat, 15 Dec 2018 07:17:38 -0800 (PST)
Date:   Sat, 15 Dec 2018 16:17:38 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] usb: renesas_usbhs: add support for RZ/G2E
Message-ID: <20181215151738.mgrtxqxklqzevnzl@verge.net.au>
References: <1544776023-13364-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544776023-13364-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 08:27:03AM +0000, Fabrizio Castro wrote:
> HS-USB found in RZ/G2E (a.k.a. r8a774c0) is very similar to the
> one found in R-Car E3 (a.k.a. r8a77990), as it needs to release
> the PLL reset by the UGCTRL register like R-Car E3, therefore add
> r8a774c0 support in a similar fashion to what was done for the
> r8a77990.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

