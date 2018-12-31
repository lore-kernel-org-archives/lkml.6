Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F89520828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lds4DTdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeLaNxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:53:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34572 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeLaNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:53:24 -0500
Received: from [192.168.0.104] (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 882C01EC02AE;
        Mon, 31 Dec 2018 14:53:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1546264402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDGFarEqBTIVBc440gKwnKsVyV0Mt0fkgmO27WZg9YM=;
        b=lds4DTdtxJHxCdKoNJAJxXd8FScRN5eVYTTdXZpHwg0l8zYFxz1iKFFos9auG39J06ine3
        EKfz2ZPWp9y7A+LE5opdg27WHzLGUPBwC5aZNLbYcvfwGSSYqNoXB0FLz1kOue8vz9NSnm
        awIpPQu9v8rmR9ZIEi2OcL1kiKKJxEk=
Date:   Mon, 31 Dec 2018 15:53:20 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20181231132000.3894E6E85603@corona.crabdance.com>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net> <1545026517-64069-2-git-send-email-schaecsn@gmx.net> <20181231132000.3894E6E85603@corona.crabdance.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
To:     schaecsn@gmx.net, Stefan Schaeckeler <schaecsn@gmx.net>,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, mchehab@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        sschaeck@cisco.com
From:   Boris Petkov <bp@alien8.de>
Message-ID: <107B9625-83E8-4791-AE21-F7D089DA6D97@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 31, 2018 3:20:00 PM GMT+02:00, Stefan Schaeckeler <schaecsn@gmx=
=2Enet> wrote:
>Let me start with reviewing my own driver=2E Perhaps someone could review
>it as well, please?

Someone will review it when the merge window and vacations are over=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
