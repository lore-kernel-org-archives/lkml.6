Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1912208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg+jG+qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1912208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeGISyX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932607AbeGISyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:54:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AB22089D;
        Mon,  9 Jul 2018 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531162461;
        bh=XWJBF2mPHJErpYlmOo9dONrbEgdHs/98+pDVPTXJrq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sg+jG+qR5qxjDi+r+7Q9J/rcq7QV+v9LkcZ1eHlRWXD8X3LvXtQ3fO3D8I33zYCjg
         CR3VGPa8ORxWAv2175DwfuHMhkwNiacDldKiiSVvXIBmZj8PnqlRCWYtKWz5qKfRd0
         It2yxtYZWEybdVC4mEoEU9RAMf0MnIeyLA5SoEFg=
Date:   Mon, 9 Jul 2018 20:54:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
Message-ID: <20180709185417.GA17528@kroah.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
 <20180707151622.GB410@kroah.com>
 <20180709174026.GA29186@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709174026.GA29186@sophia>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:40:36PM -0400, William Breathitt Gray wrote:
> I'll make the updates noted in a version 8 submission, but I'll wait to
> submit it until you have a chance to review the rest of this current
> patchset. The counter device drivers in this directory (104-quad-8.c,
> stm32-lptimer-cnt.c, stm32-timer-cnt.c) should give you an idea of how
> the counter.h file is used at the moment.

Please do not wait for me, I will not have a chance to review the other
patches anytime soon.

greg k-h
