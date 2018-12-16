Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C401C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A3B2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="aItnv6CJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbeLPTut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:50:49 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:58797 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbeLPTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:50:49 -0500
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 67D9425B764;
        Mon, 17 Dec 2018 06:50:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544989846; bh=Bi0CJRtMoqU1wx0C5cFJTsgiEBbdKBzi/FQYdGF7pFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aItnv6CJtjp2nv+DCm1MoFdEfr/0rLHDcJ7fqNwA/JooO6e+tbUm0ehX7nSqYHcez
         zJ1taZ/xJfMVo/Wkz+DzZCqfNjd6/NsJMRDvgP5JlcVD9+RjuLjpqaIXMCiWq7EHMf
         eiwb5RJs82LTHhfFtf1mtpIJNhq5UwTQnHAC4w0A=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 52886E211EC; Sun, 16 Dec 2018 11:50:44 -0800 (PST)
Date:   Sun, 16 Dec 2018 20:50:44 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: add support for r8a774c0
Message-ID: <20181216195044.s24tvxhhazb2vpgg@verge.net.au>
References: <1544732635-7367-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544732635-7367-1-git-send-email-fabrizio.castro@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:23:55PM +0000, Fabrizio Castro wrote:
> RZ/G2E USB 3.0 implementation is like the one found on R-Car E3,
> therefore add the same quirk.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

