Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29364ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E371721476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2PZq0bN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E371721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeJSRVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeJSRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:21:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D6720869;
        Fri, 19 Oct 2018 09:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539940558;
        bh=UxT9RXuaibFLahS7zsqxQPBD56qDRV2jhoO3PZEpK8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2PZq0bNVFpiqG0k3A9nEv1Loy5XH6Xjbj1aTIhFaYeQv7+MkqxgRg3IlAcpQ8igX
         poHfTSHc2Zju+bmwMrxNcihmh+AR0eeb1BI6JATevV3eDGz/RofAbE/bOgoJK+ZHiE
         b2ah6W49k1BNuGn6J2iP9TuVP6vC5K9MnLhBraBc=
Date:   Fri, 19 Oct 2018 11:15:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/48] 4.4.162-stable review
Message-ID: <20181019091556.GA27133@kroah.com>
References: <20181018175427.133690306@linuxfoundation.org>
 <a08571aa-a538-6d7d-bbe3-0ee095d1655c@newmedia-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a08571aa-a538-6d7d-bbe3-0ee095d1655c@newmedia-net.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:40:48AM +0200, Sebastian Gottschall wrote:
> 4.4, 4.9 and 4.14 contain a new file named
> arch/riscv/include/asm/asm-prototypes.h
> 
> this doesnt seem to belong to these kernels since arch/riscv was not even
> present before

Good catch, patch now dropped from all of those trees.

thanks,

greg k-h
