Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD2C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D0B21470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE6kA49w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D0B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeJLXKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbeJLXKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:10:30 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905A02098A;
        Fri, 12 Oct 2018 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539358649;
        bh=U1MnVxqlCPi/QkkS4C1D/cR5NyKkI2g0PvBt7BfX8vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DE6kA49wN5JtbwnpEEgdUgP12TmodI/Exp4sLAuqB4JIOaAimsxUi3S9McNZvU+Yq
         4QAzwc1mSe+SsA/dTLTFAHmgxkXNolf9d2GnEoS/Q8jzrExhZ8bSXIyI8SMgeP++Tc
         JrQpwfG74uxeYqUQ1CcO8pSlL+qSL+XEJe/zRpZw=
Date:   Fri, 12 Oct 2018 17:37:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mux: small fixes for 4.20-rc1
Message-ID: <20181012153726.GB25689@kroah.com>
References: <20181012144625.9345-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012144625.9345-1-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:46:34PM +0000, Peter Rosin wrote:
> Hi Greg,
> 
> A couple of tiny fixlets for the mux subsystem. Please pick them up
> for 4.20.

All now applied, thanks.

greg k-h
