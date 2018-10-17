Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A683ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4039821526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xTYeES4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4039821526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJQPnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeJQPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:43:13 -0400
Received: from localhost (unknown [188.88.119.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A231214C3;
        Wed, 17 Oct 2018 07:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762528;
        bh=/TbKA/isZ6f8DSG+cy2n/ft7ChHmnC6F1FIwAhiqzHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTYeES4qcNyq94g/4jTk6m+EOgIEfHQnhTNeeAE7Nc4QdHNFhhz/HYzsvLn1lfn00
         W0jqS8w8zjTaeygrPXBwud2cNjr2j7fqtS6iXGnLOk5J1dmg1e0PAnFZ5gqqw1Jmjb
         0MQi8AfzAkgeb8SDwk5lovBWlGKvsaWFCGKlk3hs=
Date:   Wed, 17 Oct 2018 09:48:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/135] 4.18.15-stable review
Message-ID: <20181017074845.GG25537@kroah.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <e76f0204-fb8e-137f-200b-770972fd1553@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e76f0204-fb8e-137f-200b-770972fd1553@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 08:33:42PM +0200, Holger Hoffstätte wrote:
> On 10/16/18 19:03, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.18.15 release.
> 
> Gave this a try since I have r8169 NICs. Applied over .14 and now running
> on three different machines. No observed regressions in dmesg or behaviour;
> all smooth sailing.

Wonderful, thanks for testing this and letting me know.

greg k-h
