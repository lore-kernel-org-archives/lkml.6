Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E67AC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5842098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbZVCU+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5842098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeJLXgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbeJLXgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:36:39 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8986420835;
        Fri, 12 Oct 2018 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539360210;
        bh=KCPJ5m+sRBBNl7UtIyD/nzN+cIZxs102pck1XZsMuxo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=bbZVCU+YnrUEWhAj6y9prcVKjGgttrX0QkC2PXuk0jYz/M785SlSc/zwmtD7z84gt
         OKOjOWv3jV6Av2xMKNw33Zz6o4GDOlN2iynd7sLonpnYa6ITtw+p/jinT6gEb9A2/0
         FIZT3GCeXg2niJb2Li21vEwTr0aXBVUuaDSQQEFU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org, xuwei5@hisilicon.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181012033857.GA5438@Mani-XPS-13-9360>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20181012033857.GA5438@Mani-XPS-13-9360>
Message-ID: <153936020982.5275.4942701350789062401@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/4] Add clock support for Hi3670 SoC
Date:   Fri, 12 Oct 2018 09:03:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2018-10-11 20:38:58)
> On Thu, Sep 20, 2018 at 11:00:59PM -0700, Manivannan Sadhasivam wrote:
> > This patchset adds clock support for Hi3670 SoC from HiSilicon utilizing
> > the HiSi common clock code. While adding clock support, let's remove the
> > fixed clock for UART and source SoC clock on HiKey970 board.
> > =

> > This patchset has been verified on HiKey970 board.
> >
> =

> Hi,
> =

> Any update on this series?
> =


Can I merge the clk driver part by itself? Are you looking for an ack
from clk maintainers?

