Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A3B21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551279894;
	bh=2QWv8Act9X7mmWlRFXS4rlbrs+OxCMh4QEMVObmHD4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KNvvH1Ia7G9aiiqKhgmC2Oe4l8GgYjbkATG0ELqyBMFtw2v/AWP8YpKuoU5ni90Qs
	 9nuRhKztX9Q5DnxL+03C8swyEUc8hQWFABCKh30b2POqAE8FJmn0vRyjZU8U28CKmp
	 hf/ErNoijVQw64kEMZNvfIF9A8DYzbQgWTq6OPEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfB0PEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfB0PEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:04:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BC62184A;
        Wed, 27 Feb 2019 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551279892;
        bh=2QWv8Act9X7mmWlRFXS4rlbrs+OxCMh4QEMVObmHD4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwiUPDIMFf4Tm0n7/M9VTVXzb+mCDGQytvfjhkKmt0+5FK8uq++e6bAHAToH0mS3H
         gODFx8Vv8+bbHzCrvUWTnfwrEBoar4WbXU56GqHVmfZpjRb5O1knLqfI3KS16KbwvM
         jnZVjyQQBzhaB9WdSN9a3M/x6I0RC+S85iESBsjA=
Date:   Wed, 27 Feb 2019 16:04:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v4 07/10] dt-bindings: serial: Add Milbeaut serial driver
 description
Message-ID: <20190227150450.GA7056@kroah.com>
References: <1551243210-10826-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551243210-10826-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 01:53:30PM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut serial driver.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt

I have already queued this up in my tty tree for merging in 5.1-rc1.

thanks,

greg k-h
